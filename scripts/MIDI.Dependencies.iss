#ifdef MIDI_Dependencies

	#include "MIDI.Dependencies.DotNetFxVersion.iss"


	#ifdef use_dotnetfx35
		#include "dependencies\dotnetfx35.iss"
	#endif

	; actual MIDI_Products
	#ifdef use_dotnetfx40
		#include "dependencies\dotnetfx40client.iss"
		#include "dependencies\dotnetfx40full.iss"
	#endif
	#ifdef use_dotnetfx46
		#include "dependencies\dotnetfx46.iss"
	#endif
	#ifdef use_dotnetfx461
		#include "dependencies\dotnetfx461.iss"
	#endif

 ; #ifdef use_MIDI_MsiProduct
 ;   #include "MIDI.Dependencies.MIDI_MsiProduct.iss"
 ; #endif

	#ifdef use_vc2005
		#include "dependencies\vcredist2005.iss"
	#endif
	#ifdef use_vc2008
		#include "dependencies\vcredist2008.iss"
	#endif
	#ifdef use_vc2010
		#include "dependencies\vcredist2010.iss"
	#endif
	#ifdef use_vc2012
		#include "dependencies\vcredist2012.iss"
	#endif
	#ifdef use_vc2013
		#include "dependencies\vcredist2013.iss"
	#endif
	#ifdef use_vc2015
		#include "dependencies\vcredist2015.iss"
	#endif
	
	#ifdef use_docker
		#include "dependencies\docker.iss"
	#endif

	#ifdef use_crystalreports13
		#include "dependencies\crystalreports13.iss"
	#endif

	#ifdef use_sqlcompact40
		#include "dependencies\sqlcompact40.iss"
	#endif

	#ifdef use_sql2014express
		#include "dependencies\sql2014express.iss"
	#endif
;   #ifdef use_sql2016express
;     #include "dependencies\sql2016express.iss"
; 	#endif

	#ifdef use_vsto2010
		#include "dependencies\vsto2010.iss"
	#endif

	#ifdef use_accessruntime2016
		#include "dependencies\accessruntime2016.iss"
	#endif


	#ifdef use_custom1
		#include "dependencies\custom\custom1.iss"
	#endif

[Code]
/// <summary>
/// Install common dependencies
/// </summary>
procedure MIDI_InitializeDependencies();
begin
	// Clear product list before. (User can go back during setup)
	MIDI_ClearProducts ();

	// initialize windows version
	MIDI_InitWinVersion();

	
#ifdef use_dotnetfx35
    dotnetfx35();
#endif

	// if no .netfx 4.0 is found, install the client (smallest)
#ifdef use_dotnetfx40
	if (not NetFxInstalled(NetFx40Client, '') and not NetFxInstalled(NetFx40Full, '')) then
		dotnetfx40client();
#endif

#ifdef use_dotnetfx46
    dotnetfx46(50); // min allowed version is 4.5.0
#endif

#ifdef use_dotnetfx461
    dotnetfx461(61); // min allowed version is 4.6.1
#endif

#ifdef use_vc2005
	if (IsComponentSelected ('dependencies\ms_vs2005')) then
		vcredist2005();
#endif
#ifdef use_vc2008
	if (IsComponentSelected ('dependencies\ms_vs2008')) then
		vcredist2008();
#endif
#ifdef use_vc2010
	if (IsComponentSelected ('dependencies\ms_vs2010')) then
		vcredist2010();
#endif
#ifdef use_vc2012
	if (IsComponentSelected ('dependencies\ms_vs2012')) then
		vcredist2012();
#endif
#ifdef use_vc2013
	if (IsComponentSelected ('dependencies\ms_vs2013')) then
		vcredist2013();
#endif
#ifdef use_vc2015
	if (IsComponentSelected ('dependencies\ms_vs2015')) then
		vcredist2015();
#endif

#ifdef use_docker
	if (IsComponentSelected ('dependencies\docker')) then
		docker();
#endif

#ifdef use_sqlcompact40
	if (IsComponentSelected ('dependencies\ms_sqlcompact40')) then
		sqlcompact40();
#endif

#ifdef use_sql2014sp1express
	if (IsComponentSelected ('dependencies\ms_sql2014express')) then
		sql2014express();
#endif
#ifdef use_sql2016express
	if (IsComponentSelected ('dependencies\ms_sql2016express')) then
		sql2016express();
#endif

#ifdef use_vsto2010
	if (IsComponentSelected ('dependencies\ms_vsto2010')) then
		visualstudio2010toolsforoffice();
#endif

#ifdef use_crystalreports13
	if (IsComponentSelected ('dependencies\sap_crystalreports13')) then
		crystalreports13 ();
#endif

#ifdef use_accessruntime2016
	if (IsComponentSelected ('dependencies\ms_accessruntime2016')) then
		accessruntime2016();
#endif

#ifdef use_custom1
	if (IsComponentSelected ('dependencies\custom1')) then
		custom1();
#endif
end;


/// <summary>
/// Uninstall common dependencies
/// </summary>
procedure MIDI_UninstallDependencies();
begin
	// Add code here if you want to remove frameworks, SQL server.
	// Be careful. Some components may be used by other third-party application
end;
#endif


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section