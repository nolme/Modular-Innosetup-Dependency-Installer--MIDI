[Code]
var
	WindowsVersion: TWindowsVersion;    // Store Windows version


/// <summary>
/// MAke the full Windows version name
/// </summary>
/// <returns>Full Windows version string.</returns>
function MIDI_GetFullVersion(VersionMS, VersionLS: cardinal): string;
var
	version: string;
begin
	version := IntToStr(word(VersionMS shr 16));
	version := version + '.' + IntToStr(word(VersionMS and not $ffff0000));

	version := version + '.' + IntToStr(word(VersionLS shr 16));
	version := version + '.' + IntToStr(word(VersionLS and not $ffff0000));

	Result := version;
end;

/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_FileVersion(file: string): string;
var
	versionMS, versionLS: cardinal;
begin
	if GetVersionNumbers(file, versionMS, versionLS) then
		Result := MIDI_GetFullVersion(versionMS, versionLS)
	else
		Result := '0';
end;

/// <summary>
/// 
/// </summary>
procedure MIDI_InitWinVersion();
begin
	GetWindowsVersionEx(WindowsVersion);
end;

/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_ExactWinVersion(MajorVersion, MinorVersion: integer): boolean;
begin
	Result := (WindowsVersion.Major = MajorVersion) and (WindowsVersion.Minor = MinorVersion);
end;

/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_MinWinVersion(MajorVersion, MinorVersion: integer): boolean;
begin
	Result := (WindowsVersion.Major > MajorVersion) or ((WindowsVersion.Major = MajorVersion) and (WindowsVersion.Minor >= MinorVersion));
end;

/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_MaxWinVersion(MajorVersion, MinorVersion: integer): boolean;
begin
	Result := (WindowsVersion.Major < MajorVersion) or ((WindowsVersion.Major = MajorVersion) and (WindowsVersion.Minor <= MinorVersion));
end;

/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_ExactWinSPVersion(MajorVersion, MinorVersion, SpVersion: integer): boolean;
begin
	if MIDI_ExactWinVersion(MajorVersion, MinorVersion) then
		Result := WindowsVersion.ServicePackMajor = SpVersion
	else
		Result := true;
end;

/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_MinWinSPVersion(MajorVersion, MinorVersion, SpVersion: integer): boolean;
begin
	if MIDI_ExactWinVersion(MajorVersion, MinorVersion) then
		Result := WindowsVersion.ServicePackMajor >= SpVersion
	else
		Result := true;
end;

/// <summary>
/// 
/// </summary>
/// <returns></returns>
function MIDI_MaxWinSPVersion(MajorVersion, MinorVersion, SpVersion: integer): boolean;
begin
	if MIDI_ExactWinVersion(MajorVersion, MinorVersion) then
		Result := WindowsVersion.ServicePackMajor <= SpVersion
	else
		Result := true;
end;

/// <summary>
/// Convert a version string to an integer version
/// </summary>
/// <returns></returns>
function MIDI_StringToVersion(var temp: String): Integer;
var
	part: String;
	pos1: Integer;

begin
	if (Length(temp) = 0) then begin
		Result := -1;
		Exit;
	end;

	pos1 := Pos('.', temp);
	if (pos1 = 0) then begin
		Result := StrToInt(temp);
		temp := '';
	end else begin
		part := Copy(temp, 1, pos1 - 1);
		temp := Copy(temp, pos1 + 1, Length(temp));
		Result := StrToInt(part);
	end;
end;

/// <summary>
/// Compare 2 strings
/// </summary>
/// <returns>-1 if x < y. +1 if x > y or 0 if x = y</returns>
function MIDI_CompareInnerVersion(var x, y: String): Integer;
var
	num1, num2: Integer;

begin
	num1 := MIDI_StringToVersion(x);
	num2 := MIDI_StringToVersion(y);
	if (num1 = -1) and (num2 = -1) then begin
		Result := 0;
		Exit;
	end;

	if (num1 < 0) then begin
		num1 := 0;
	end;
	if (num2 < 0) then begin
		num2 := 0;
	end;

	if (num1 < num2) then begin
		Result := -1;
	end else if (num1 > num2) then begin
		Result := 1;
	end else begin
		Result := MIDI_CompareInnerVersion(x, y);
	end;
end;

/// <summary>
/// Compare 2 strings
/// </summary>
/// <returns>-1 if x < y. +1 if x > y or 0 if x = y</returns>
function MIDI_CompareVersion(versionA, versionB: String): Integer;
var
	temp1, temp2: String;

begin
    temp1 := versionA;
    temp2 := versionB;
    Result := MIDI_CompareInnerVersion(temp1, temp2);
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section