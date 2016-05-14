# Modular-InnoSetup-Dependency-Installer (MIDI)
A modular InnoSetup script to download and install .NET Framework versions and much more.

This project is based on CodeProject previous article from stfx :
http://www.codeproject.com/Articles/20868/NET-Framework-Installer-for-InnoSetup?msg=5192030#xx5192030xx

For this project you need :
---------------------------
- InnoSetup QuickStartPack (http://www.jrsoftware.org/isdl.php).
- Inno Download Plugin (https://code.google.com/p/inno-download-plugin/source/browse/examples/multilang.iss?r=5d8a4a7dc6591d23f73271e6caf36060f1c1abf7).
- Optional : VCL Styles (https://github.com/RRUZ/vcl-styles-plugins/wiki/Inno-Setup)

Embedded in this project :
--------------------------
- PSD Graphics for welcome and finish page (http://www.psdgraphics.com)
- 7-Zip for checking file architecture (x86/x64) (http://www.7-zip.org)

Screenshots :
-------------
 <img src=http://i.imgur.com/wpbdkfm.png>
 <img src=http://i.imgur.com/j324eba.png>
 <img src=http://i.imgur.com/VrWlpNd.png>
 <img src=http://i.imgur.com/0XADz2c.png>
 <img src=http://i.imgur.com/hKHLPJQ.png>

Known issues :
--------------
- Microsoft Office 2010 and below not detected.
- Microsoft Access Runtime silent install don't work using the EXE installer.
- Wrong message when dependencies are unselected

Project tree :
--------------

| File or folder | Description |
| -------------- | ----------- | 
| `/` | Main setup file and dependencies to install. You can edit these files to match your setup requirements. | 
| setup.iss | Main program entry for your setup. | 
| setup_define_dependencies.iss | Comment/uncomment all dependencies you want to install. | 
| `/src` | Source siles to install. | 
| `/images` | Images displayed during setup. | 
| `/bin` | Setup compilation result to distribute. | 
| `/bin/dependencies` | Place here setup dependencies you don't want to download. | 
| `/scripts` | Internal code to manage dependencies & products. | 
| MIDI.Core.iss | Core library. | 
| MIDI.Core.Base.iss | Core library. | 
| MIDI.Core.Debug.iss | Debug library. | 
| MIDI.Core.NativeMethods.iss | Win32 native methods. | 
| MIDI.Core.Registry.iss | Windows Registry library. | 
| MIDI.Core.Version.iss | Get Windows version. | 
| MIDI.Customize.iss | Customize application look. | 
| MIDI.Database.iss | Database utility. | 
| MIDI.Dependencies.Base.iss | Dependencies core. | 
| MIDI.Dependencies.DotNetFxVersion.iss | Manage .NET versions. | 
| MIDI.Dependencies.iss | Dependencies installation. | 
| MIDI.Drawing.iss | Drawing utility. | 
| MIDI.Messages.iss | Translations. | 
| MIDI.Office.iss | Microsoft Office detection. | 
| MIDI.Products.iss | Manage product installation. | 
| MIDI.System.iss |  System core library. | 
| `/scripts/dependencies` | Commons dependencies to manage. 1 file per product. | 
| `/scripts/dependencies/custom` | Add here if you have custom files to download in your setup. See 'custom1.iss' sample using define 'use_custom1'. | 
| `/scripts/idplang` | IDP additional language files. | 

History :
---------
2016-05-13 :
  - NEW : [Code] Add Is64BitProcess() function to determine if an executable file is for x64 architecture or not.
  - NEW : [Code] Add IsOfficeInstalled() function to check presence of Microsoft Office.
  - NEW : [Code] IDP - Add additional languages files (in folder .\scripts\idplang) that are not managed inside original product.
  - NEW : [Dependencies] Display already installed dependencies.
  - NEW : [Dependencies] Microsoft  Access Runtime 2016.
  - NEW : [Dependencies] SAP Crystal Reports 13 (support pack 16).
  - NEW : [Dependencies] Microsoft Visual Studio 2010 Tools for Office Runtime.
  - NEW : Check application upgrade and previous installation uninstall.
  - NEW : Add Welcome background image.
  - NEW : Add HTTPS support.
  - NEW : Add multilang installer.
  - UPDATE : [Dependencies] Update Microsoft .NET framework.
  - UPDATE : [Dependencies] Update Microsoft SQL Server Express.
  - UPDATE : [Dependencies] Update Microsoft Visual C++ Redistributable.

   
