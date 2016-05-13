[Code]

/// <summary>
/// Expand environment variables
/// </summary>
/// <param name="Input">Full file name path to expand.</param>
/// <returns>Expanded variables.</returns>
/// <url>http://blogs.candoerz.com/question/19517/innosetup-expand-environment-variable-taken-from-registry-value-using-reg-.aspx</url>
function MIDI_ExpandEnvVars(const Input: string): string;
var
	BufSize: DWORD;
begin
	BufSize := ExpandEnvironmentStrings(Input, #0, 0);
	if BufSize > 0 then begin
		SetLength(Result, BufSize);
		if ExpandEnvironmentStrings(Input, Result, Length(Result)) = 0 then
			RaiseException(Format('Expanding env. strings failed. %s', [SysErrorMessage(DLLGetLastError)]));
	end else
		RaiseException(Format('Expanding env. strings failed. %s', [SysErrorMessage(DLLGetLastError)]));
end;

 
/// <summary>
/// Check wether a process filename is a 64 bits application or not
/// </summary>
/// <param name="fileName">Full file name path to check.</param>
function MIDI_Is64BitProcess (fileName : String): Boolean;
var
	buffer: AnsiString;
	logFile : String;
	ResultCode: Integer;
begin
	logFile := MIDI_ExpandEnvVars(ExpandConstant('{tmp}\innosetup-7zip.log'));

	// Extract internal 7Zip
	ExtractTemporaryFile('7z.exe');

	// Run 7-zip command to check application architecture
	if Exec('cmd.exe', '/C "' + ExpandConstant('{tmp}\7z.exe') + ' l "' + fileName + '" | findstr CPU > "' + logFile + '""', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then begin
		// handle success if necessary; ResultCode contains the exit code
		buffer := 'Success calling 7-Zip : ' + IntToStr(ResultCode) + ' - ' + SysErrorMessage(ResultCode);
		Log (buffer);
	end else begin
		// handle failure if necessary; ResultCode contains the error code
		buffer := 'FAILURE calling 7-Zip : ' + IntToStr(ResultCode) + ' - ' + SysErrorMessage(ResultCode);
		Log (buffer);
	end;

	// Check if output file exist (which contain 7-Zip application architecture result)
	if (FileExists (logFile)) then begin
		if (LoadStringFromFile (logFile, buffer)) then begin
			if (Pos ('64', buffer) <> 0) then begin
				Result:=True;
				//SuppressibleMsgBox('This is a x64 application', mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
			end else begin
				Result:=False;
				//SuppressibleMsgBox('This is a x86 application', mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
			end;
		end;
	end;
end;


/// <summary>
/// Convert a boolean value to string
/// </summary>
function MIDI_BoolToStr(Value : Boolean) : String; 
begin
	if Value then
		result := 'true'
	else
		result := 'false';
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section