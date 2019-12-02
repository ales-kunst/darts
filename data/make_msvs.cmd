@rem set qtdir=C:\\drive_d\\programming\\ide\\lang\\qt\\5\.13\.1\\msvc2017_64
@rem set qtdirforw=C:/drive_d/programming/ide/lang/qt/5.13.1/msvc2017_64
@call qt_env.cmd
@set msvs_build_path=bin\\$\(ProjectName\)_$\(Platform\)_$\(Configuration\)
@set msvs_forw_build_path=bin/$\(ProjectName\)_$\(Platform\)_$\(Configuration\)
@set msvs_rel_build_path=bin\\$\(ProjectName\)_$\(Platform\)_Release
@set msvs_deb_build_path=bin\\$\(ProjectName\)_$\(Platform\)_Debug
@set rel_build_path=bin\gui_x64_Release
@set deb_build_path=bin\gui_x64_Debug
@premake5.exe --os=windows --verbose vs2017
@if exist .\qt (@rd /s /q .\qt)
@md .\qt
@copy /y /v darts_gui.pro .\qt
@copy /y /v darts_resources.qrc .\qt
@pushd .\qt
@qmake.exe -tp vc darts_gui.pro
@popd

@call :change_vcxproj

@call :change_vcxproj_filter

@call :create_build_folders


@del /f /q .\qt\gui.vcxproj.changed
@copy /y /v .\qt\gui.vcxproj ..\build\msvs\projects
@copy /y /v .\qt\gui.vcxproj.filters ..\build\msvs\projects
@copy /y /v .\darts_resources.qrc ..\build\msvs\projects
@robocopy .\resources ..\build\msvs\projects\resources /E /COPY:DAT

@call :build_project

@goto:eof

@rem ---------------------------------------------------------------------------------------------------------------------

:build_project
    @setlocal
    @pushd ..\build\msvs
    ::@msbuild Darts.sln -t:Rebuild -p:Configuration=Release -p:Platform=x64
    @MSBuild.exe Darts.sln /m /nologo /t:Build /p:Configuration="Release" /p:Platform="x64"
    @pushd ..\%rel_build_path%
    @windeployqt.exe --release gui.exe
    @popd
    ::@msbuild Darts.sln -t:Rebuild -p:Configuration=Debug -p:Platform=x64
    @MSBuild.exe Darts.sln /m /nologo /t:Build /p:Configuration="Debug" /p:Platform="x64"
    @pushd ..\%deb_build_path%
    @windeployqt.exe --debug gui.exe
    @popd
    @popd
    @endlocal
    @goto:eof
@rem ---------------------------------------------------------------------------------------------------------------------

:create_build_folders
    @setlocal

    @rd /s /q ..\build\%deb_build_path%
    @rd /s /q ..\build\%rel_build_path%
    @md ..\build\%deb_build_path% 
    @md ..\build\%rel_build_path%

    @echo "This is a dummy file needed to create release/moc_predefs.h" > ..\build\%rel_build_path%\moc_predefs.h.cbt
    @echo "This is a dummy file needed to create debug/moc_predefs.h" > ..\build\%deb_build_path%\moc_predefs.h.cbt

    @endlocal
    @goto:eof

@rem ---------------------------------------------------------------------------------------------------------------------

:change_vcxproj_filter
    @setlocal
    @pushd .\qt
    @copy gui.vcxproj.filters gui.vcxproj.filters.changed
    @copy gui.vcxproj.filters gui.vcxproj.filters.unchanged

    @..\..\tools\sed.exe -r "s|\.\.\\\.\.\\src\\|\.\.\\\.\.\\\.\.\\src\\|g" < gui.vcxproj.filters.changed > gui.vcxproj.filters
    @copy /y /v gui.vcxproj.filters gui.vcxproj.filters.changed

    @..\..\tools\sed.exe -r "s|release\\moc_|$\(SolutionDir\)\.\.\\%msvs_rel_build_path%\\moc_|g" < gui.vcxproj.filters.changed > gui.vcxproj.filters
    @copy /y /v gui.vcxproj.filters gui.vcxproj.filters.changed

    @..\..\tools\sed.exe -r "s|debug\\moc_|$\(SolutionDir\)\.\.\\%msvs_deb_build_path%\\moc_|g" < gui.vcxproj.filters.changed > gui.vcxproj.filters
    @copy /y /v gui.vcxproj.filters gui.vcxproj.filters.changed 
    @popd

    @endlocal
    @goto:eof

@rem ---------------------------------------------------------------------------------------------------------------------

:change_vcxproj
    @setlocal
    @pushd .\qt
    @set sedpattern="s|(<RootNamespace>gui</RootNamespace>)|\1\n    <QtLibDir>%qtdir%</QtLibDir>|g"

    @copy gui.vcxproj gui.vcxproj.changed
    @copy gui.vcxproj gui.vcxproj.unchanged

    @..\..\tools\sed.exe -r "s|%qtdir%|$(QtLibDir)|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r %sedpattern% < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|%qtdirforw%|$(QtLibDir)|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|\.\.\\\.\.\\src\\|\.\.\\\.\.\\\.\.\\src\\|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|>release\\<|>$\(SolutionDir\)\.\.\\%msvs_build_path%\\<|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|>debug\\<|>$\(SolutionDir\)\.\.\\%msvs_build_path%\\<|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s| release\\| $\(SolutionDir\)\.\.\\%msvs_build_path%\\|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s| debug\\| $\(SolutionDir\)\.\.\\%msvs_build_path%\\|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|>release\\|>$\(SolutionDir\)\.\.\\%msvs_build_path%\\|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|>debug\\|>$\(SolutionDir\)\.\.\\%msvs_build_path%\\|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|release\\moc_|$\(SolutionDir\)\.\.\\%msvs_rel_build_path%\\moc_|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|debug\\moc_|$\(SolutionDir\)\.\.\\%msvs_deb_build_path%\\moc_|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|release\\qrc_|$\(SolutionDir\)\.\.\\%msvs_rel_build_path%\\qrc_|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|debug\\qrc_|$\(SolutionDir\)\.\.\\%msvs_deb_build_path%\\qrc_|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|data/qt/release|build/%msvs_forw_build_path%|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|data/qt/debug|build/%msvs_forw_build_path%|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|;release;|;$\(SolutionDir\)\.\.\\%msvs_build_path%;|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed

    @..\..\tools\sed.exe -r "s|;debug;|;$\(SolutionDir\)\.\.\\%msvs_build_path%;|g" < gui.vcxproj.changed > gui.vcxproj
    @copy /y /v gui.vcxproj gui.vcxproj.changed
    @popd

    @endlocal
    @goto:eof

@rem ---------------------------------------------------------------------------------------------------------------------
