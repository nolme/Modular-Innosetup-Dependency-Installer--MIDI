; requires Windows 7 Service Pack 1, Windows 8, Windows 8.1, Windows Server 2003, Windows Server 2008 R2 SP1, Windows Server 2008 Service Pack 2, Windows Server 2012, Windows Server 2012 R2, Windows Vista Service Pack 2, Windows XP
; 12.0.30501 - https://www.microsoft.com/en-US/download/details.aspx?id=40784

[CustomMessages]
vcredist2013_title=Microsoft Visual C++ 2013 Redistributable
vcredist2013_title_x64=Microsoft Visual C++ 2013 (64-Bit) Redistributable

vcredist2013_url=https://download.microsoft.com/download/A/4/D/A4D9F1D3-6449-49EB-9A6E-902F61D8D14B/vcredist_x86.exe
vcredist2013_url_x64=https://download.microsoft.com/download/A/4/D/A4D9F1D3-6449-49EB-9A6E-902F61D8D14B/vcredist_x64.exe

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_vs2013"; Description: {cm:vcredist2013_title}; ExtraDiskSpaceRequired: 6504792; Types: custom;  Check: not Is64BitInstallMode;
Name: "dependencies\ms_vs2013"; Description: {cm:vcredist2013_title_x64}; ExtraDiskSpaceRequired: 7195120; Types: custom;  Check: Is64BitInstallMode;

[Code]
const
	vcredist2013_size=6.2;
	vcredist2013_size_x64=6.9;
	vcredist2013_productcode = '{13A4EE12-23EA-3371-91EE-EFB36DDFFF3E}';
	vcredist2013_productcode_x64 = '{A749D8E6-B613-3BE3-8F5F-045C84EBA29B}';
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function vcredist2013(): Boolean;
begin
	Result := True;
	if (not MIDI_IsIA64()) then begin
		if (not MIDI_MsiProduct(MIDI_GetString(vcredist2013_productcode, vcredist2013_productcode_x64, ''))) then begin
			MIDI_AddProduct('vcredist2013' + MIDI_GetArchitectureString() + '.exe',
				'/passive /norestart',
				CustomMessage('vcredist2013_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (vcredist2013_size, vcredist2013_size_x64, 00),
				MIDI_GetString(CustomMessage('vcredist2013_url'), CustomMessage('vcredist2013_url_x64'), ''),
				false, false);
		end else begin	
			MIDI_AddInstalledProduct('vcredist2013' + MIDI_GetArchitectureString() + '.exe',
				CustomMessage('vcredist2013_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (vcredist2013_size, vcredist2013_size_x64, 00),
				MIDI_GetString(CustomMessage('vcredist2013_url'), CustomMessage('vcredist2013_url_x64'), ''),
				false, false);
		end;
	end;
end;

// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section