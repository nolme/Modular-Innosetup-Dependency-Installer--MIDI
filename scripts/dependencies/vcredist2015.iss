; requires Windows 10, Windows 7 Service Pack 1, Windows 8, Windows 8.1, Windows Server 2003 Service Pack 2, Windows Server 2008 R2 SP1, Windows Server 2008 Service Pack 2, Windows Server 2012, Windows Vista Service Pack 2, Windows XP Service Pack 3
; Update 1 : https://www.microsoft.com/fr-fr/download/details.aspx?id=49984
; 14.0.25918 - Update 2 : https://www.microsoft.com/fr-FR/download/details.aspx?id=51682

[CustomMessages]
vcredist2015_title=Microsoft Visual C++ 2015 Update 2 Redistributable
vcredist2015_title_x64=Microsoft Visual C++ 2015 Update 2 (64-Bit) Redistributable

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_vs2015"; Description: {cm:vcredist2015_title}; ExtraDiskSpaceRequired: 13969576; Types: custom;  Check: not Is64BitInstallMode;
Name: "dependencies\ms_vs2015"; Description: {cm:vcredist2015_title_x64}; ExtraDiskSpaceRequired: 14749128; Types: custom;  Check: Is64BitInstallMode;

[Code]
const
	vcredist2015_source_size=13.3;
	vcredist2015_source_size_x64=14.0;
	vcredist2015_url='https://download.microsoft.com/download/7/8/3/78354CEE-596A-409B-BB4D-4B20CB81B608/vc_redist.x86.exe';
	vcredist2015_url_x64='https://download.microsoft.com/download/7/8/3/78354CEE-596A-409B-BB4D-4B20CB81B608/vc_redist.x64.exe';
	vcredist2015_productcode = '{7B50D081-E670-3B43-A460-0E2CDB5CE984}';
	vcredist2015_productcode_x64 = '{7B50D081-E670-3B43-A460-0E2CDB5CE984}';

/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns> 
function vcredist2015(): Boolean;
begin
  Result := True;
  if (not MIDI_IsIA64()) then begin
		if (not MIDI_MsiProduct(MIDI_GetString(vcredist2015_productcode, vcredist2015_productcode_x64, ''))) then begin
			MIDI_AddProduct('vcredist2015' + MIDI_GetArchitectureString() + '.exe',
				'/passive /norestart',
				CustomMessage('vcredist2015_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (vcredist2015_source_size, vcredist2015_source_size_x64, 0),
				MIDI_GetString(vcredist2015_url, vcredist2015_url_x64, ''),
				false, false);
		end else begin	
			MIDI_AddInstalledProduct('vcredist2015' + MIDI_GetArchitectureString() + '.exe',
				CustomMessage('vcredist2015_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (vcredist2015_source_size, vcredist2015_source_size_x64, 0),
				MIDI_GetString(vcredist2015_url, vcredist2015_url_x64, ''),
				false, false);
		end;
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section