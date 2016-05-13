; requires Windows 7 Service Pack 1, Windows 8, Windows 8.1, Windows Server 2003, Windows Server 2008 R2 SP1, Windows Server 2008 Service Pack 2, Windows Server 2012, Windows Vista Service Pack 2, Windows XP
; 11.0.61030 - http://www.microsoft.com/en-us/download/details.aspx?id=30679

[CustomMessages]
vcredist2012_title=Microsoft Visual C++ 2012 Update 4 Redistributable
vcredist2012_title_x64=Microsoft Visual C++ 2012 Update 4 (64-Bit) Redistributable

vcredist2012_url=https://download.microsoft.com/download/D/3/B/D3B72629-7D95-49ED-A4EC-7FF105754124/VSU4/vcredist_x86.exe
vcredist2012_url_x64=https://download.microsoft.com/download/D/3/B/D3B72629-7D95-49ED-A4EC-7FF105754124/VSU4/vcredist_x64.exe

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_vs2012"; Description: {cm:vcredist2012_title}; ExtraDiskSpaceRequired: 6555760; Types: custom; 
; Check: not Is64BitInstallMode;
Name: "dependencies\ms_vs2012"; Description: {cm:vcredist2012_title_x64}; ExtraDiskSpaceRequired: 7188184; Types: custom; 
; Check: Is64BitInstallMode;

[Code]
const
	vcredist2012_size=6.3;
	vcredist2012_size_x64=6.9;
	vcredist2012_productcode = '{BD95A8CD-1D9F-35AD-981A-3E7925026EBB}';
	vcredist2012_productcode_x64 = '{37B8F9C7-03FB-3253-8781-2517C99D7C00}';

/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function vcredist2012(): Boolean;
begin
	Result := True;
	if (not MIDI_IsIA64()) then begin
		if (not MIDI_MsiProduct(MIDI_GetString(vcredist2012_productcode, vcredist2012_productcode_x64, ''))) then begin
			MIDI_AddProduct('vcredist2012' + MIDI_GetArchitectureString() + '.exe',
				'/passive /norestart',
				CustomMessage('vcredist2012_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (vcredist2012_size, vcredist2012_size_x64, 00),
				MIDI_GetString(CustomMessage('vcredist2012_url'), CustomMessage('vcredist2012_url_x64'), ''),
				false, false);
		end else begin	
			MIDI_AddInstalledProduct('vcredist2012' + MIDI_GetArchitectureString() + '.exe',
				CustomMessage('vcredist2012_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (vcredist2012_size, vcredist2012_size_x64, 00),
				MIDI_GetString(CustomMessage('vcredist2012_url'), CustomMessage('vcredist2012_url_x64'), ''),
				false, false);
		end;
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section