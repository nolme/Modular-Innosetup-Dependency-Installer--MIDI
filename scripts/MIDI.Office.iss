[Code]
const
	MIDI_RegOfficeClickToRun='SOFTWARE\Microsoft\Office\ClickToRun\Configuration';
	MIDI_RegOfficeClickToRunKey='Platform';

	MIDI_Office2007_MajorVersion = 13;
	MIDI_Office2010_MajorVersion = 14;
	MIDI_Office2013_MajorVersion = 15;
	MIDI_Office2016_MajorVersion = 16;
	MIDI_OfficeLast_MajorVersion = MIDI_Office2016_MajorVersion;

var
	MIDI_OfficeInstalledAs64Bits:Boolean;            // Set to True if Microsoft Office is installed using x64 archictecture, False otherwise.
	MIDI_OfficeClickToRunInstalled:Boolean;          // Set to True if Microsoft Office using ClickToRun is installed

/// <summary>
/// Check is Microsoft Office Click-to-Run is installed or not
/// </summary>
function MIDI_IsOfficeCLickToRunInstalled (): Boolean;
var
	platform: string;
begin
	platform := '';
	RegQueryStringValue(MIDI_GetHKLM(), MIDI_RegOfficeClickToRun, MIDI_RegOfficeClickToRunKey, platform);
	if platform = 'x86' then begin
		#ifdef MIDI_DBG_OFFICE
			SuppressibleMsgBox('Microsoft Office 365 / Click-To-Run found (x86 version)' , mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
		#endif
		Log ('[MIDI] Found product : ' + 'Microsoft Office 365 / Click-To-Run' + ' (x86 version)');
		Result := True;
		MIDI_OfficeClickToRunInstalled := True;
		MIDI_OfficeInstalledAs64Bits := False;
	end else if platform = 'x64' then begin
		#ifdef MIDI_DBG_OFFICE
			SuppressibleMsgBox('Microsoft Office 365 / Click-To-Run found (x64 version)', mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
		#endif
		Log ('[MIDI] Found product : ' + 'Microsoft Office 365 / Click-To-Run' + ' (x64 version)');
		Result := True;
		MIDI_OfficeClickToRunInstalled := True;
		MIDI_OfficeInstalledAs64Bits := True;
	end else begin
		Result := False;
	end;
end;


/// <summary>
/// Check is Microsoft Office is installed or not
/// </summary>
/// <note>Microsoft Office below 2013 is not detected for the moment</note>
function MIDI_IsOfficeInstalled (): Boolean;
var
	platform: string;
	buffer: string;
	i: integer;
	officeFound : boolean;
begin
	officeFound := False;
	
	// Looks for Office 2003
	// TODO

	// Looks for Office 2007, 2010
	for i := MIDI_Office2007_MajorVersion to MIDI_Office2010_MajorVersion do
	begin
		// TODO
	end;

	// Looks for standard office version if no previous version has been found. This way works only for Office 2013, 2016...
	if officeFound <> True then begin
		for i := MIDI_Office2013_MajorVersion to MIDI_OfficeLast_MajorVersion do
		begin
			platform := '';
			RegQueryStringValue(MIDI_GetHKLM(), 'SOFTWARE\Microsoft\Office\' + IntToStr(i) + '.0' + '\ClickToRun\Configuration', MIDI_RegOfficeClickToRunKey, platform);

			buffer:='Microsoft Office ' + IntToStr(i) + '.0';
			if platform = 'x86' then begin
				#ifdef MIDI_DBG_OFFICE
					SuppressibleMsgBox(buffer + ' (x86 version)' , mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
				#endif
				Log ('[MIDI] Found product : ' + buffer + ' (x86 version)');
				officeFound := True;
				MIDI_OfficeInstalledAs64Bits := False;
			end else if platform = 'x64' then begin
				#ifdef MIDI_DBG_OFFICE
					SuppressibleMsgBox(buffer + ' (x64 version)', mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
				#endif
				Log ('[MIDI] Found product : ' + buffer + ' (x64 version)');
				officeFound := True;
				MIDI_OfficeInstalledAs64Bits := True;
			end else begin
				// This version de Office is not found.
			end;
		end;
	end;

	// Looks for Office 365 if no previous version has been found
	if officeFound <> True then begin
		Result := MIDI_IsOfficeCLickToRunInstalled ();
	end;
	// Save result
	Result := officeFound;
end;


/// <summary>
/// Check is Microsoft Office x86 is installed
/// </summary>
/// <returns>True if Microsoft Office x86 is installed, False otherwise.</returns>
function MIDI_IsX86OfficeInstalled (): Boolean;
begin
	if MIDI_IsOfficeInstalled () then begin
		if MIDI_OfficeInstalledAs64Bits then begin
			Result := False;
		end else begin
			Result := True;
		end;
	end else begin
		Result := False;
	end;

	#ifdef MIDI_DBG_OFFICE
		SuppressibleMsgBox('MIDI_IsX86OfficeInstalled () : ' + MIDI_BoolToStr (Result), mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
	#endif
end;


/// <summary>
/// Check is Microsoft Office x64 is installed
/// </summary>
/// <returns>True if Microsoft Office x64 is installed, False otherwise.</returns>
function MIDI_IsX64OfficeInstalled (): Boolean;
begin
	if MIDI_IsOfficeInstalled () then begin
		if MIDI_OfficeInstalledAs64Bits then begin
			Result := True;
		end else begin
			Result := False;
		end;
	end else begin
		Result := False;
	end;

	#ifdef MIDI_DBG_OFFICE
		SuppressibleMsgBox('MIDI_IsX64OfficeInstalled () : ' + MIDI_BoolToStr (Result), mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
	#endif
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section