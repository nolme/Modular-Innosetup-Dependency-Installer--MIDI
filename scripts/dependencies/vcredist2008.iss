; requires Windows 2000 Service Pack 4, Windows Server 2003, Windows Vista, Windows XP
; requires Windows Installer 3.0
; https://www.microsoft.com/en-us/download/details.aspx?id=5582 (2008/09/16)
; 9.0.30729.6161 - https://www.microsoft.com/fr-fr/download/details.aspx?id=26368 (2011-07-06)

[CustomMessages]
vcredist2008_title=Microsoft Visual C++ 2008 SP1 Redistributable
vcredist2008_title_x64=Microsoft Visual C++ 2008 SP1 (64-Bit) Redistributable
vcredist2008_title_ia64=Microsoft Visual C++ 2008 SP1 (Itanium) Redistributable

vcredist2008_url=https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe
vcredist2008_url_x64=https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe
vcredist2008_url_ia64=https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_IA64.exe

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_vs2008"; Description: {cm:vcredist2008_title}; ExtraDiskSpaceRequired: 4479832; Types: custom;  Check: not Is64BitInstallMode;
Name: "dependencies\ms_vs2008"; Description: {cm:vcredist2008_title_x64}; ExtraDiskSpaceRequired: 5207896; Types: custom;  Check: Is64BitInstallMode;
Name: "dependencies\ms_vs2008"; Description: {cm:vcredist2008_title_ia64}; ExtraDiskSpaceRequired: 4657496; Types: custom;  Check: MIDI_IsIA64;

[Code]
const
	vcredist2008_size=4.3;
	vcredist2008_size_x64=5.0;
	vcredist2008_size_ia64=4.4;
	vcredist2008_productcode = '{9BE518E6-ECC6-35A9-88E4-87755C07200F}';
	vcredist2008_productcode_x64 = '{5FCE6D76-F5DC-37AB-B2B8-22AB8CEDB1D4}';
	vcredist2008_productcode_ia64 = '{2B547B43-DB50-3139-9EBE-37D419E0F5FA}';
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function vcredist2008(): Boolean;
begin
	Result := True;
	if (not MIDI_MsiProduct(MIDI_GetString(vcredist2008_productcode, vcredist2008_productcode_x64, vcredist2008_productcode_ia64))) then begin
		MIDI_AddProduct('vcredist2008' + MIDI_GetArchitectureString() + '.exe',
			'/q',
			CustomMessage('vcredist2008_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (vcredist2008_size, vcredist2008_size_x64, vcredist2008_size_ia64),
			MIDI_GetString(CustomMessage('vcredist2008_url'), CustomMessage('vcredist2008_url_x64'), CustomMessage('vcredist2008_url_ia64')),
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('vcredist2008' + MIDI_GetArchitectureString() + '.exe',
			CustomMessage('vcredist2008_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (vcredist2008_size, vcredist2008_size_x64, vcredist2008_size_ia64),
			MIDI_GetString(CustomMessage('vcredist2008_url'), CustomMessage('vcredist2008_url_x64'), CustomMessage('vcredist2008_url_ia64')),
			false, false);
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section