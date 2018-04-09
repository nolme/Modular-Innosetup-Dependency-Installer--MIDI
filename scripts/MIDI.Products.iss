[Code]
type
	MIDI_TProduct = record
		File: String;
		Title: String;
		Parameters: String;
		InstallClean : boolean;
		MustRebootAfter : boolean;
	end;

	/// <summary>
	/// Define dependency install result
	/// </summary>
	MIDI_InstallResult = (InstallSuccessful, InstallRebootRequired, InstallError);

var
	MIDI_InstalledMemo : string;   /// Display dependencies already installed
	MIDI_InstallMemo   : string;   /// Display dependencies to install (may be in local repository or needed to be downloaded
	MIDI_DownloadMemo  : string;   /// Display dependencies to download
	MIDI_DownloadMessage: string;
	MIDI_Products: array of MIDI_TProduct;
	MIDI_DelayedReboot: boolean;
	MIDI_DependencyPage: TOutputProgressWizardPage;

/// <summary>
/// Clear product list
/// </summary>
procedure MIDI_ClearProducts ();
var
	i: Integer;
begin
	// Reset array of MIDI_Products
	SetArrayLength (MIDI_Products, 0);

	// Reset memo strings
	MIDI_InstalledMemo := '';
	MIDI_InstallMemo := '';
	MIDI_DownloadMemo := '';
	MIDI_DownloadMessage := '';
end;


/// <summary>
/// Add an installed product dependency to list for information purpose
/// </summary>
procedure MIDI_AddInstalledProduct(FileName, Title, Size, URL: string; InstallClean : boolean; MustRebootAfter : boolean);
begin
	Log ('[MIDI] Product already installed : ' + FileName + ' - ' + Title);
	MIDI_InstalledMemo := MIDI_InstalledMemo + '%1' + Title + #13;
end;


/// <summary>
/// Add a product dependency to manage
/// </summary>
procedure MIDI_AddProduct(FileName, Parameters, Title, Size, URL: string; InstallClean : boolean; MustRebootAfter : boolean);
var
	path: string;
	i: Integer;
begin
	MIDI_InstallMemo := MIDI_InstallMemo + '%1' + Title + #13;

	path := ExpandConstant('{src}{\}') + CustomMessage('MIDI_DependenciesDir') + '\' + FileName;
	Log ('[MIDI] Check local file : ' + path);
	
	// Check local file presence
	if not FileExists(path) then begin
		Log ('[MIDI] Local file NOT present, add product remote URL : ' + URL);
	
		// Change path to temporary folder
		path := ExpandConstant('{tmp}{\}') + FileName;
		Log ('[MIDI] Store downloaded product to : ' + path);

		// DEBUG MSGBOX
		//SuppressibleMsgBox ('URL :' + #13#10 + URL + #13#10 + 'path :' + #13#10 + path, mbInformation, MB_OK, IDOK);
		// END DEBUG MSGBOX

		// IDP version
		idpAddFile(URL, path);
		idpDownloadAfter(wpReady);

		MIDI_DownloadMemo := MIDI_DownloadMemo + '%1' + Title + #13;
		MIDI_DownloadMessage := MIDI_DownloadMessage + '	' + Title + ' (' + Size + ')' + #13;
	end else begin
		Log ('[MIDI] Local file present : ' + path);
	end;

	i := GetArrayLength(MIDI_Products);
	SetArrayLength(MIDI_Products, i + 1);
	MIDI_Products[i].File := path;
	MIDI_Products[i].Title := Title;
	MIDI_Products[i].Parameters := Parameters;
	MIDI_Products[i].InstallClean := InstallClean;
	MIDI_Products[i].MustRebootAfter := MustRebootAfter;
end;


/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_SmartExec(prod : MIDI_TProduct; var ResultCode : Integer) : boolean;
begin
	Log ('[MIDI] Run application : ' + prod.File + ' with params : ' + prod.Parameters);

	if (LowerCase(Copy(prod.File,Length(prod.File)-2,3)) = 'exe') then begin
		Result := Exec(prod.File, prod.Parameters, '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
	end else begin
		Result := ShellExec('', prod.File, prod.Parameters, '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
	end;
	Log ('[MIDI] Run result  : ' + MIDI_BoolToStr(Result));
end;


/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_PendingReboot : boolean;
var	names: String;
begin
	if (RegQueryMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager', 'PendingFileRenameOperations', names)) then begin
		Result := true;
	end else if ((RegQueryMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager', 'SetupExecute', names)) and (names <> ''))  then begin
		Result := true;
	end else begin
		Result := false;
	end;
end;


/// <summary>
/// 
/// </summary>
/// <note>DO NOT RENAME THIS FUNCTION.</note>
/// <returns></returns>
function InstallProducts: MIDI_InstallResult;
var
	ResultCode, i, productCount, finishCount: Integer;
begin
	Result := InstallSuccessful;
	productCount := GetArrayLength(MIDI_Products);

	if productCount > 0 then begin
		MIDI_DependencyPage := CreateOutputProgressPage(CustomMessage('MIDI_DepInstall_Title'), CustomMessage('MIDI_DepInstall_Description'));
		MIDI_DependencyPage.Show;

		for i := 0 to productCount - 1 do begin
			if (MIDI_Products[i].InstallClean and (MIDI_DelayedReboot or MIDI_PendingReboot())) then begin
				Result := InstallRebootRequired;
				break;
			end;

			MIDI_DependencyPage.SetText(FmtMessage(CustomMessage('MIDI_DepInstall_Status'), [MIDI_Products[i].Title]), '');
			MIDI_DependencyPage.SetProgress(i, productCount);

			if MIDI_SmartExec(MIDI_Products[i], ResultCode) then begin
				//setup executed; ResultCode contains the exit code
				//MsgBox(MIDI_Products[i].Title + ' install executed. Result Code: ' + IntToStr(ResultCode), mbInformation, MB_OK);
				if (MIDI_Products[i].MustRebootAfter) then begin
					//delay reboot after install if we installed the last dependency anyways
					if (i = productCount - 1) then begin
						MIDI_DelayedReboot := true;
					end else begin
						Result := InstallRebootRequired;
					end;
					break;
				end else if (ResultCode = 0) then begin
					finishCount := finishCount + 1;
				end else if (ResultCode = 3010) then begin
					//ResultCode 3010: A restart is required to complete the installation. This message indicates success.
					MIDI_DelayedReboot := true;
					finishCount := finishCount + 1;
				end else begin
					Result := InstallError;
					break;
				end;
			end else begin
				//MsgBox(MIDI_Products[i].Title + ' install failed. Result Code: ' + IntToStr(ResultCode), mbInformation, MB_OK);
				Result := InstallError;
				break;
			end;
		end;

		//only leave not installed MIDI_Products for error message
		for i := 0 to productCount - finishCount - 1 do begin
			MIDI_Products[i] := MIDI_Products[i+finishCount];
		end;
		SetArrayLength(MIDI_Products, productCount - finishCount);

		MIDI_DependencyPage.Hide;
	end;
end;


/// <summary>
/// 
/// </summary>
/// <note>DO NOT RENAME THIS FUNCTION.</note>
/// <returns></returns>
function PrepareToInstall(var NeedsRestart: boolean): String;
var
	i: Integer;
	s: string;
begin
	MIDI_DelayedReboot := false;

	case InstallProducts() of
		InstallError: begin
			s := CustomMessage('MIDI_DepInstall_Error');

			for i := 0 to GetArrayLength(MIDI_Products) - 1 do begin
				s := s + #13 + '	' + MIDI_Products[i].Title;
			end;

			Result := s;
			end;
		InstallRebootRequired: begin
			Result := MIDI_Products[0].Title;
			NeedsRestart := true;

			//write into the registry that the installer needs to be executed again after restart
			RegWriteStringValue(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce', 'InstallBootstrap', ExpandConstant('{srcexe}'));
			end;
	end;
end;


/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_NeedRestart : boolean;
begin
	if (MIDI_DelayedReboot) then
		Result := true;
end;


/// <summary>
/// Overload the standard UpdateReadyMemo.
/// </summary>
/// <note>DO NOT RENAME THIS FUNCTION.</note>
/// <returns>Full memo text to display.</returns>
function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
	s: string;
	userName : string;
begin

	// Display user information
	userName := ExpandConstant('{userinfoname}');
	if userName <> '' then
		s := s + MemoUserInfoInfo + NewLine + NewLine;

	if MIDI_InstalledMemo <> '' then
		s := s + CustomMessage('MIDI_DepAlreadyDownloaded_MemoTitle') + ':' + NewLine + FmtMessage(MIDI_InstalledMemo, [Space]) + NewLine;
	if MIDI_DownloadMemo <> '' then
		s := s + CustomMessage('MIDI_DepDownload_MemoTitle') + ':' + NewLine + FmtMessage(MIDI_DownloadMemo, [Space]) + NewLine;
	if MIDI_InstallMemo <> '' then
		s := s + CustomMessage('MIDI_DepInstall_MemoTitle') + ':' + NewLine + FmtMessage(MIDI_InstallMemo, [Space]) + NewLine;

	// Add text - Destination folder (never empty)
	if MemoDirInfo <> '' then
		s := s + MemoDirInfo + NewLine + NewLine;

	// Add text
	if MemoGroupInfo <> '' then
		s := s + MemoGroupInfo + NewLine + NewLine;

	// Add text - Additional tasks
	if MemoTasksInfo <> '' then
		s := s + MemoTasksInfo;

	Result := s
end;


/// <summary>
/// 
/// </summary>
/// <returns></returns>
function NextButtonClick(CurPageID: Integer): boolean;
begin
	Result := true;

	if CurPageID = wpReady then begin
		if MIDI_DownloadMemo <> '' then begin
			if SuppressibleMsgBox(FmtMessage(CustomMessage('MIDI_DepDownload_Msg'), [MIDI_DownloadMessage]), mbConfirmation, MB_YESNO, IDYES) = IDNO then
				Result := false
		end;
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section