; requires Windows 7 Service Pack 1, Windows 8, Windows 8.1, Windows Server 2008 R2 SP1, Windows Server 2008 Service Pack 2, Windows Server 2012, Windows Server 2012 R2, Windows Vista Service Pack 2
; WARNING: express setup (downloads and installs the components depending on your OS) if you want to deploy it on cd or network download the full bootsrapper on website below
; http://www.microsoft.com/en-us/download/details.aspx?id=48137

[CustomMessages]
dotnetfx35_title=Microsoft .NET Framework 3.5 SP1

[Code]
const
	dotnetfx35_size_min=3;
	dotnetfx35_size_max=232;
	dotnetfx35_url='http://download.microsoft.com/download/0/6/1/061f001c-8752-4600-a198-53214c69b51f/dotnetfx35setup.exe';
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
procedure dotnetfx35();
begin
	if (netfxspversion(NetFx35, '') < 1) then begin
		MIDI_AddProduct('dotnetfx35sp1.exe',
			'/lang:' + CustomMessage('MIDI_DotNetLanguage') + ' /passive /norestart',
			CustomMessage('dotnetfx35_title'),
			MIDI_GetSizeString (dotnetfx35_size_min, dotnetfx35_size_min, 0) + ' - ' + MIDI_GetSizeString (dotnetfx35_size_max, dotnetfx35_size_max, 0),
			dotnetfx35_url,
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('dotnetfx35sp1.exe',
			CustomMessage('dotnetfx35_title'),
			MIDI_GetSizeString (dotnetfx35_size_min, dotnetfx35_size_min, 0) + ' - ' + MIDI_GetSizeString (dotnetfx35_size_max, dotnetfx35_size_max, 0),
			dotnetfx35_url,
			false, false);
  end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section