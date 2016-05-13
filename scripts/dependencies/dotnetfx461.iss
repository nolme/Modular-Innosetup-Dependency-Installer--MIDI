; requires Windows 7 Service Pack 1, Windows 8, Windows 8.1, Windows Server 2008 R2 SP1, Windows Server 2008 Service Pack 2, Windows Server 2012, Windows Server 2012 R2, Windows Vista Service Pack 2
; WARNING: express setup (downloads and installs the components depending on your OS) if you want to deploy it on cd or network download the full bootsrapper on website below
; https://www.microsoft.com/en-us/download/details.aspx?id=49982

[CustomMessages]
dotnetfx461_title=Microsoft .NET Framework 4.6.1

[Code]
const
	dotnetfx461_size_min=1;
	dotnetfx461_size_max=66;
	dotnetfx461_url='https://download.microsoft.com/download/3/5/9/35980F81-60F4-4DE3-88FC-8F962B97253B/NDP461-KB3102438-Web.exe';
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
procedure dotnetfx461(MinVersion: integer);
begin
	if (not netfxinstalled(NetFx4x, '') or (netfxspversion(NetFx4x, '') < MinVersion)) then begin
		MIDI_AddProduct('dotnetfx461.exe',
			'/lcid ' + CustomMessage('MIDI_lcid') + ' /passive /norestart',
			CustomMessage('dotnetfx461_title'),
			MIDI_GetSizeString (dotnetfx461_size_min, dotnetfx461_size_min, 0) + ' - ' + MIDI_GetSizeString (dotnetfx461_size_max, dotnetfx461_size_max, 0),
			dotnetfx461_url,
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('dotnetfx461.exe',
			CustomMessage('dotnetfx461_title'),
			MIDI_GetSizeString (dotnetfx461_size_min, dotnetfx461_size_min, 0) + ' - ' + MIDI_GetSizeString (dotnetfx461_size_max, dotnetfx461_size_max, 0),
			dotnetfx461_url,
			false, false);
  end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section