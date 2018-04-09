You can put the renamed setup files of the dependencies in this folder so that they will be installed from the drive instead of being downloaded. You have to rename them like below...

Supported dependency names:

|   crystalreports13[*1].msi
|   dxwebsetup.exe
|   dotNetFx40_Client_setup.exe
|   dotNetFx40_Full_setup.exe
|   dotnetfx46.exe
|   dotnetfx461.exe
|   SQLEXPR[*1]-[*3].exe
|   SSCERuntime[*1]-[*3].exe
|   vcredist2005[*1].exe
|   vcredist2008[*1].exe
|   vcredist2010[*1].exe
|   vcredist2012[*1].exe
|   vcredist2013[*1].exe
|   vcredist2015[*1].exe
|   docker.exe
|   vstor_redist.exe

[*1] = "_x64" for 64-bit OS, "_ia64" for Itanium OS or "" (empty) for 32-bit OS
[*2] = 2 letter language name ... e.g. "en", "de", "fr", "sp", ...
[*3] = 3 letter language name ... e.g. "enu", "deu", "fra", "esn", ...
[*4] = windows version of msi 4.5 ... either "60.msu", "52.exe" or "51.exe"
