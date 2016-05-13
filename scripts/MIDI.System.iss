; Manage system functions

[Code]
var
	isForcedX86: boolean;

	
/// <summary>
/// PSVince external - MIDI_IsModuleLoadedI - function to call at install time
/// </summary>
//function MIDI_IsModuleLoaded(modulename: String ):  Boolean;
//external 'MIDI_IsModuleLoaded@files:psvince.dll stdcall setuponly';

/// <summary>
/// PSVince - MIDI_IsModuleLoadedI or MIDI_IsModuleLoadedU as appropriate
/// </summary>
function MIDI_IsModuleLoaded( modulename: String): Boolean;
begin
	Result := True;
	//Result := MIDI_IsModuleLoaded( modulename );
end;
/// <summary>
/// Prompt the user to close a program that's still running.
/// Finish when the executable is closed or the user cancels the process.
/// </summary>
/// <param name="exeName">Executable name to check.</param> 
/// <param name="message">A message to show the user to prompt them to close.</param> 
/// <param name="isUninstallation">Whether this is an uninstallation (to call the right function).</param>
//  <returns>True if the program was closed (or was not running),
//           False if the user clicked on the Cancel button and didn't close the program.</returns>
function MIDI_PromptUntilProgramClosedOrInstallationCanceled(
              exeName: String;  
              message: String; 
              isUninstallation: Boolean ): Boolean;
var
	ButtonPressed : Integer;
begin
	ButtonPressed := IDRETRY;

	// Check if the program is running or if the user has pressed the cancel button
	while MIDI_IsModuleLoaded( exeName )  do
		// and ( ButtonPressed <> IDCANCEL ) do
	begin
		ButtonPressed := SuppressibleMsgBox ( message , mbError, MB_RETRYCANCEL, IDCANCEL );    
	end;

	// Has the program been closed?
	//Result := Not MIDI_IsModuleLoaded( exeName );
  Result := True;
end;

/// <summary>
/// Check CPU architecture
/// </summary>
/// <returns>True if 32 bits, false otherwise.</returns>
function MIDI_IsX86: boolean;
begin
	Result := isForcedX86 or (ProcessorArchitecture = paX86) or (ProcessorArchitecture = paUnknown);
end;

/// <summary>
/// Check CPU architecture
/// </summary>
/// <returns>True if 64 bits, false otherwise.</returns>
function MIDI_IsX64: boolean;
begin
	Result := (not isForcedX86) and Is64BitInstallMode and (ProcessorArchitecture = paX64);
end;

/// <summary>
/// Check CPU architecture
/// </summary>
/// <returns>True if 64 bits Itanium, false otherwise.</returns>
function MIDI_IsIA64: boolean;
begin
	Result := (not isForcedX86) and Is64BitInstallMode and (ProcessorArchitecture = paIA64);
end;

/// <summary>
/// Return string corresponding to architecture
/// </summary>
/// <param name="x86">The string for x86 architecture.</param>
/// <param name="x64">The string for x64 architecture.</param>
/// <param name="ia64">The string for Itanium x64 architecture.</param>
/// <returns>String for current architecture.</returns>
function MIDI_GetString(x86, x64, ia64: String): String;
begin
	if MIDI_IsX64() and (x64 <> '') then begin
		Result := x64;
	end else if MIDI_IsIA64() and (ia64 <> '') then begin
		Result := ia64;
	end else begin
		Result := x86;
	end;
end;


/// <summary>
/// Return an integer corresponding to architecture
/// </summary>
/// <param name="x86">The integer value for x86 architecture.</param>
/// <param name="x64">The integer value for x64 architecture.</param>
/// <param name="ia64">The integer value for Itanium x64 architecture.</param>
/// <returns>Integer for current architecture.</returns>
function MIDI_GetInt(x86, x64, ia64: Integer): Integer;
begin
	if MIDI_IsX64() and (x64 <> 0) then begin
		Result := x64;
	end else if MIDI_IsIA64() and (ia64 <> 0) then begin
		Result := ia64;
	end else begin
		Result := x86;
	end;
end;


/// <summary>
/// Return a double value corresponding to architecture
/// </summary>
/// <param name="x86">The integer value for x86 architecture.</param>
/// <param name="x64">The integer value for x64 architecture.</param>
/// <param name="ia64">The integer value for Itanium x64 architecture.</param>
/// <returns>Double value for current architecture.</returns>
function MIDI_GetDouble(x86, x64, ia64: Double): Double;
begin
	if MIDI_IsX64() and (x64 <> 0) then begin
		Result := x64;
	end else if MIDI_IsIA64() and (ia64 <> 0) then begin
		Result := ia64;
	end else begin
		Result := x86;
	end;
end;


/// <summary>
/// Convert a Double value to a formated string
/// </summary>
/// <return>Size converted to string according to current architecture</return>
function MIDI_GetSizeString(x86, x64, ia64: Double) : String;
begin
	Result := Format('%.2f %s', [MIDI_GetDouble(x86, x64, ia64),CustomMessage('MIDI_size_unit')]);
end;


/// <summary>
/// Add a suffix according to current architecture
/// </summary>
/// <returns>Suffix to add.</returns>
function MIDI_GetArchitectureString(): String;
begin
	if MIDI_IsX64() then begin
		Result := '_x64';
	end else if MIDI_IsIA64() then begin
		Result := '_ia64';
	end else begin
		Result := '';
	end;
end;

/// <summary>
/// Add a suffix according to current architecture
/// </summary>
/// <note>This version is the same than MIDI_GetArchitectureString() except for _x86 which will add this prefix too.</note>
/// <returns>Suffix to add.</returns>
function MIDI_GetArchitectureStringEx(): String;
begin
	if MIDI_IsX64() then begin
		Result := '_x64';
	end else if MIDI_IsIA64() then begin
		Result := '_ia64';
	end else begin
		Result := '_x86';
	end;
end;

/// <summary>
/// Force x86 architecture
/// </summary>
/// <param name="value">Value to set to force x86 (under x64 environment.</param>
procedure MIDI_SetForceX86(value: boolean);
begin
	isForcedX86 := value;
end;

/// <summary>
/// Check Windows XP
/// </summary>
/// <url>http://pvbookmarks.readthedocs.org/en/latest/devel/installation/innosetup/graphical/examples/</url>
function MIDI_IsWindowsXP: Boolean;
var
	Version: TWindowsVersion;
begin
	GetWindowsVersionEx(Version);
	Result := Version.NTPlatform and (Version.Major = 5) and (Version.Minor = 1);
end;

/// <summary>
/// Get the version of Windows installer DLL
/// </summary>
/// <url>https://gist.github.com/meng-hui/3311509</url>
function MIDI_GetMSIVersion(): String;
begin
    GetVersionNumbersString(GetSystemDir+'\msi.dll', Result);
end;

/// <summary>
/// Get the uninstall string
/// </summary>
/// <returns>Uninstall string.</returns>
function MIDI_GetUninstallString(ApplicationId: String): String;
var
	sUnInstPath: String;
	sUnInstallString: String;
begin
	sUnInstPath := 'Software\Microsoft\Windows\CurrentVersion\Uninstall\' + ApplicationId;
	sUnInstallString := '';
	if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
		RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);
	Result := sUnInstallString;
end;

/// <summary>
/// Check if application is an upgrade
/// </summary>
/// <returns>True if it's an application upgrade. False otherwise.</returns>
function MIDI_IsUpgrade(ApplicationId: String): Boolean;
begin
	Result := (MIDI_GetUninstallString(ApplicationId) <> '');
end;

/// <summary>
/// Uninstall current application old versions
/// </summary>
/// <param name="guid">Application GUID</param>
/// <returns>Uninstall result. See below.</returns>
/// 1 - uninstall string is empty
/// 2 - error executing the UnInstallString
/// 3 - successfully executed the UnInstallString
function MIDI_UnInstallOldVersion(guid: String): Integer;
var
	sUnInstallString: String;
	iResultCode: Integer;
begin
	// default return value
	Result := 0;

	// get the uninstall string of the old app
	sUnInstallString := MIDI_GetUninstallString(guid);
	if sUnInstallString <> '' then begin
		sUnInstallString := RemoveQuotes(sUnInstallString);
		if Exec(sUnInstallString, '/SILENT /NORESTART /SUPPRESSMSGBOXES','', SW_HIDE, ewWaitUntilTerminated, iResultCode) then
			Result := 3
		else if Exec(sUnInstallString, '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES','', SW_HIDE, ewWaitUntilTerminated, iResultCode) then
			Result := 3
		else
			Result := 2;
	end else
		Result := 1;
end;


/// <summary>
/// Uninstall application before upgrading
/// </summary>
/// <param name="guid">Application GUID</param>
/// <param name="apSetupName">Application setup name</param>
procedure MIDI_UninstallBeforeUpgrade (guid, appSetupName : String);var
	text : String;
begin
	if (MIDI_IsUpgrade(guid)) then begin
		// Ask the user to uninstall previous version of application
		text := FmtMessage(CustomMessage('MIDI_AskForUninstall'), [appSetupName]);
		if SuppressibleMsgBox(text, mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES) = IDYES then begin
			// user clicked Yes
			MIDI_UnInstallOldVersion(guid);
		end;
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section