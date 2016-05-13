; http://stackoverflow.com/questions/2799941/how-to-determine-if-vsto-2010-runtime-is-installed
; May install VC++ 2010 redist
; https://www.microsoft.com/en-us/download/details.aspx?id=48217

[CustomMessages]
vsto2010_title=Microsoft Visual Studio 2010 Tools for Office Runtime 
de.vsto2010_title=Microsoft Visual Studio 2010-Tools für Office-Laufzeit 
fr.vsto2010_title=Microsoft Visual Studio 2010 Tools pour Office Runtime
fi.vsto2010_title=Microsoft Visual Studio 2010 Tools for Office Runtime
sp.vsto2010_title=Microsoft Visual Studio 2010 Tools para Office Runtime
nl.vsto2010_title=Microsoft Visual Studio 2010 Tools for Office Runtime
it.vsto2010_title=Microsoft Visual Studio 2010 Tools per Office Runtime
pl.vsto2010_title=Microsoft Visual Studio 2010 Tools for Office Runtime
ru.vsto2010_title=Microsoft Visual Studio 2010 Tools для офиса Время воспроизведения

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_vsto2010"; Description: {cm:vsto2010_title}; ExtraDiskSpaceRequired: 40102072; Types: custom;

[Code]
const 
	vsto2010_source_size=38.2;
	vsto2010_source_url ='http://download.microsoft.com/download/7/A/F/7AFA5695-2B52-44AA-9A2D-FC431C231EDC/vstor_redist.exe';

/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function visualstudio2010toolsforoffice(): Boolean;
var
	regVersionString: string;
	installed: boolean;
begin
	Result := True;
	RegQueryStringValue(HKLM32, 'SOFTWARE\Microsoft\VSTO Runtime Setup\v4R', 'Version', regVersionString);
	installed := regVersionString <> '';

	if (MIDI_IsX64() and not installed) then  begin
		RegQueryStringValue(HKLM64, 'SOFTWARE\Microsoft\VSTO Runtime Setup\v4R', 'Version', regVersionString);
		installed := regVersionString <> '';
	end;

	if (not installed) then begin
		MIDI_AddProduct('vstor_redist.exe', '/q',
		CustomMessage('vsto2010_title'),
		MIDI_GetSizeString (vsto2010_source_size, vsto2010_source_size, 0),
		vsto2010_source_url,
		false, false);
	end else begin	
		MIDI_AddInstalledProduct('vstor_redist.exe',
		CustomMessage('vsto2010_title'),
		MIDI_GetSizeString (vsto2010_source_size, vsto2010_source_size, 0),
		vsto2010_source_url,
		false, false);
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section