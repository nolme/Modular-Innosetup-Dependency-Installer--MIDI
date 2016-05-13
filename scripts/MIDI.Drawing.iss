[Code]
/// <summary>
/// Convert a color string using format $BBGGRR to integer
/// </summary>
function MIDI_StringToRGB(ColorStr: string): Integer;
var
	r, g, b: Integer;
begin
	r := StrToInt(Copy(ColorStr, 1, 3));
	g := StrToInt('$' + Copy(ColorStr, 4, 2));
	b := StrToInt('$' + Copy(ColorStr, 6, 2));
	Result := (r or (g shl 8) or (b shl 16));
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section