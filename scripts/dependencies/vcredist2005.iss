; requires Windows 2000 Service Pack 3, Windows 98, Windows 98 Second Edition, Windows ME, Windows Server 2003, Windows XP Service Pack 2
; requires Windows Installer 3.0
; 8.0.50727.762 : https://www.microsoft.com/fr-fr/download/details.aspx?id=5638

; Microsoft Visual C++ 2005 Service Pack 1 Redistributable Package MFC Security Update ; 8.0.61000 https://www.microsoft.com/en-us/download/details.aspx?displaylang=en&id=26347



[CustomMessages]
vcredist2005_title=Microsoft Visual C++ 2005 SP1 Redistributable
vcredist2005_title_x64=Microsoft Visual C++ 2005 SP1 (64-Bit) Redistributable
vcredist2005_title_ia64=Microsoft Visual C++ 2005 SP1 (Itanium) Redistributable

vcredist2005_url=https://download.microsoft.com/download/5/D/A/5DA273D6-C1CB-4F1C-90C0-73B5263E0AC7/vcredist_x86.EXE
vcredist2005_url_x64=https://download.microsoft.com/download/5/D/A/5DA273D6-C1CB-4F1C-90C0-73B5263E0AC7/vcredist_x64.EXE
vcredist2005_url_ia64=https://download.microsoft.com/download/5/D/A/5DA273D6-C1CB-4F1C-90C0-73B5263E0AC7/vcredist_IA64.EXE

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_vs2005"; Description: {cm:vcredist2005_title}; ExtraDiskSpaceRequired: 2709912; Types: custom;  Check: not Is64BitInstallMode;
Name: "dependencies\ms_vs2005"; Description: {cm:vcredist2005_title_x64}; ExtraDiskSpaceRequired: 3177880; Types: custom;  Check: Is64BitInstallMode;
Name: "dependencies\ms_vs2005"; Description: {cm:vcredist2005_title_ia64}; ExtraDiskSpaceRequired: 6617496; Types: custom;  Check: MIDI_IsIA64;

[Code]
const 
	vcredist2005_size=2.6;
	vcredist2005_size_x64=3.0;
	vcredist2005_size_ia64=6.3;
	vcredist2005_productcode = '{710f4c1c-cc18-4c49-8cbf-51240c89a1a2}';
	vcredist2005_productcode_x64 =  '{ad8a2fa1-06e7-4b0d-927d-6e54b3d31028}'; 	// 	8.0.56336 '{071c9b48-7c32-4621-a0ac-3f809523288f}';
	vcredist2005_productcode_ia64 = '{03ED71EA-F531-4927-AABD-1C31BCE8E187}';
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function vcredist2005(): Boolean;
begin
	Result := True;
	if (not MIDI_MsiProduct(MIDI_GetString(vcredist2005_productcode, vcredist2005_productcode_x64, vcredist2005_productcode_ia64))) then begin
		MIDI_AddProduct('vcredist2005' + MIDI_GetArchitectureString() + '.exe',
			'/q',
			CustomMessage('vcredist2005_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (vcredist2005_size, vcredist2005_size_x64, vcredist2005_size_ia64),
			MIDI_GetString(CustomMessage('vcredist2005_url'), CustomMessage('vcredist2005_url_x64'), CustomMessage('vcredist2005_url_ia64')),
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('vcredist2005' + MIDI_GetArchitectureString() + '.exe',
			CustomMessage('vcredist2005_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (vcredist2005_size, vcredist2005_size_x64, vcredist2005_size_ia64),
			MIDI_GetString(CustomMessage('vcredist2005_url'), CustomMessage('vcredist2005_url_x64'), CustomMessage('vcredist2005_url_ia64')),
			false, false);
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section