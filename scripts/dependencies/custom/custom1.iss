; requires : [TODO:ADD REQUIREMENTS HERE]

[CustomMessages]
custom1_title=[TODO:ADD TITLE]
custom1_title_x64=[TODO:ADD TITLE]
custom1_title_ia64=[TODO:ADD TITLE]

custom1_url=[TODO:ADD URL]
custom1_url_x64=[TODO:ADD URL]
custom1_url_ia64=[TODO:ADD URL]

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\custom1"; Description: {cm:custom1_title}; ExtraDiskSpaceRequired: 0; Types: custom; Check: not Is64BitInstallMode;
Name: "dependencies\custom1"; Description: {cm:custom1_title_x64}; ExtraDiskSpaceRequired: 0; Types: custom; Check: Is64BitInstallMode;
Name: "dependencies\custom1"; Description: {cm:custom1_title_ia64}; ExtraDiskSpaceRequired: 0; Types: custom;  Check: MIDI_IsIA64;

[Code]
const 
	custom1_productcode = '{00000000-1111-2222-3333-444444444444}';
	custom1_productcode_x64 = '{00000000-1111-2222-3333-444444444444}';
	custom1_productcode_ia64 = '{00000000-1111-2222-3333-444444444444}';

	custom1_parameters = '/q';

	custom1_size_min=0;
	custom1_size_max=0;

/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function custom1(): Boolean;
begin
	Result := True;
	if (not msiproduct(MIDI_GetString(custom1_productcode, custom1_productcode_x64, custom1_productcode_ia64))) then begin
		MIDI_AddProduct('custom1' + MIDI_GetArchitectureString() + '.exe',
			custom1_parameters,
			CustomMessage('custom1_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (custom1_size_min, custom1_size_min, custom1_size_min) + ' - ' + MIDI_GetSizeString (custom1_size_max, custom1_size_max, custom1_size_max),
			MIDI_GetString(CustomMessage('custom1_url'), CustomMessage('custom1_url_x64'), CustomMessage('custom1_url_ia64')),
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('custom1' + MIDI_GetArchitectureString() + '.exe',
			CustomMessage('custom1_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (custom1_size_min, custom1_size_min, custom1_size_min) + ' - ' + MIDI_GetSizeString (custom1_size_max, custom1_size_max, custom1_size_max),
			MIDI_GetString(CustomMessage('custom1_url'), CustomMessage('custom1_url_x64'), CustomMessage('custom1_url_ia64')),
			false, false);
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section