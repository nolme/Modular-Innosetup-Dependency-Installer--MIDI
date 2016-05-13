; WIN32API

[Code]
#ifdef UNICODE
	#define AW "W"
#else 
	#define AW "A"
#endif

function ExpandEnvironmentStrings(lpSrc: string; lpDst: string; nSize: DWORD): DWORD;
external 'ExpandEnvironmentStrings{#AW}@kernel32.dll stdcall';

type
    INSTALLSTATE = Longint;
const
    INSTALLSTATE_INVALIDARG = -2;  // An invalid parameter was passed to the function.
    INSTALLSTATE_UNKNOWN = -1;     // The product is neither advertised or installed.
    INSTALLSTATE_ADVERTISED = 1;   // The product is advertised but not installed.
    INSTALLSTATE_ABSENT = 2;       // The product is installed for a different user.
    INSTALLSTATE_DEFAULT = 5;      // The product is installed for the current user.

function MsiQueryProductState(szProduct: string): INSTALLSTATE;
external 'MsiQueryProductState{#AW}@msi.dll stdcall';

/// <summary>
/// Check installed product state
/// </summary>
/// <return>True if product is installed, false otherwise.</return>
function MIDI_MsiProduct(const ProductID: string): boolean;
begin
	Result := MsiQueryProductState(ProductID) = INSTALLSTATE_DEFAULT;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section