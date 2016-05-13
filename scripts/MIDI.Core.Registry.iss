; <summary>
; Manage access to Windows Registry
; </summary>

[Code]
/// <summary>
/// Get current HKLM version according to Windows architecture
/// </summary>
function MIDI_GetHKLM: Integer;
begin
	if IsWin64 then
		Result := HKLM64
	else
		Result := HKLM32;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section