; requires Windows 7, Windows Server 2003 R2 (32-Bit x86), Windows Server 2003 Service Pack 2, Windows Server 2008 R2, Windows Server 2008 Service Pack 2, Windows Vista Service Pack 2, Windows XP Service Pack 3
; http://blogs.msdn.com/b/astebner/archive/2010/05/05/10008146.aspx
; 10.0.40219 : https://www.microsoft.com/en-US/download/details.aspx?id=26999

[CustomMessages]
vcredist2010_title=Microsoft Visual C++ 2010 SP1 Redistributable
vcredist2010_title_x64=Microsoft Visual C++ 2010 SP1 (64-Bit) Redistributable
vcredist2010_title_ia64=Microsoft Visual C++ 2010 SP1 (Itanium) Redistributable

vcredist2010_url=https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe
vcredist2010_url_x64=https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe
vcredist2010_url_ia64=https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_ia64.exe

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_vs2010"; Description: {cm:vcredist2010_title}; ExtraDiskSpaceRequired: 4995416; Types: custom;  Check: not Is64BitInstallMode;
Name: "dependencies\ms_vs2010"; Description: {cm:vcredist2010_title_x64}; ExtraDiskSpaceRequired: 5673816; Types: custom;  Check: Is64BitInstallMode;
Name: "dependencies\ms_vs2010"; Description: {cm:vcredist2010_title_ia64}; ExtraDiskSpaceRequired: 2264408; Types: custom;  Check: MIDI_IsIA64;

[Code]
const
	vcredist2010_size=4.8;
	vcredist2010_size_x64=5.4;
	vcredist2010_size_ia64=2.2;
	vcredist2010_productcode = '{F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}';
	vcredist2010_productcode_x64 = '{1D8E6291-B0D5-35EC-8441-6616F567A0F7}';
	vcredist2010_productcode_ia64 = '{88C73C1C-2DE5-3B01-AFB8-B46EF4AB41CD}';
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function vcredist2010(): Boolean;
begin
	Result := True;
	if (not MIDI_MsiProduct(MIDI_GetString(vcredist2010_productcode, vcredist2010_productcode_x64, vcredist2010_productcode_ia64))) then begin
		MIDI_AddProduct('vcredist2010' + MIDI_GetArchitectureString() + '.exe',
			'/passive /norestart',
			CustomMessage('vcredist2010_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (vcredist2010_size, vcredist2010_size_x64, vcredist2010_size_ia64),
			MIDI_GetString(CustomMessage('vcredist2010_url'), CustomMessage('vcredist2010_url_x64'), CustomMessage('vcredist2010_url_ia64')),
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('vcredist2010' + MIDI_GetArchitectureString() + '.exe',
			CustomMessage('vcredist2010_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (vcredist2010_size, vcredist2010_size_x64, vcredist2010_size_ia64),
			MIDI_GetString(CustomMessage('vcredist2010_url'), CustomMessage('vcredist2010_url_x64'), CustomMessage('vcredist2010_url_ia64')),
			false, false);
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section