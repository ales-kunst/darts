workspace "Darts"
  location "../build/msvs"
  configurations { "Debug", "Release" }
  platforms { "x64" }
  filter { "platforms:x64" }
    system "Windows"
    architecture "x86_64"
    buildoptions { "/std:c++latest", "/Qpar" }

project "gui"
  language "C++"
  kind "WindowedApp"
  location "../build/msvs/projects"
  targetdir "$(SolutionDir)../bin/$(ProjectName)_$(Platform)_$(Configuration)/"
  objdir "!$(SolutionDir)../bin/obj/$(ProjectName)_$(Platform)_$(Configuration)/"
--[[
  characterset 'Unicode'
  rtti "On"
  flags { "MultiProcessorCompile", "NoPCH" }
  includedirs { "$(QtLibDir)\\include",
                "$(QtLibDir)\\include\\QtWidgets",
                "$(QtLibDir)\\include\\QtGui",
                "$(QtLibDir)\\include\\QtANGLE",
                "$(QtLibDir)\\include\\QtCore",
                "$(QtLibDir)\\mkspecs\\win32-msvc"
              }
  files { "../src/**.h", "../src/**.cpp", "../src/**.cbt" }
  vpaths {
    ["Generated Files"] = {"../src/gui/**.cbt"},
    ["Header Files"] = { "../src/**.h" },
    ["Source Files"] = { "../src/**.cpp" }
  }

  filter "configurations:Debug"
    defines { "_WINDOWS", "UNICODE", "_UNICODE", "WIN32", "_ENABLE_EXTENDED_ALIGNED_STORAGE", "WIN64", "QT_WIDGETS_LIB", "QT_GUI_LIB", "QT_CORE_LIB" }
    runtime "Debug"
    buildoptions { "-Zc:rvalueCast", "-Zc:inline", "-Zc:strictStrings", "-Zc:throwingNew", "-Zc:referenceBinding", "-w34100", "-w34189", "-w44996", "-w44456", "-w44457", "-w44458" }
    links { "$(QtLibDir)\\lib\\Qt5Widgetsd.lib",
            "$(QtLibDir)\\lib\\Qt5Guid.lib",
            "$(QtLibDir)\\lib\\Qt5Cored.lib",
            "$(QtLibDir)\\lib\\qtmaind.lib" 
          }

  filter "configurations:Release"
    defines { "_WINDOWS", "UNICODE", "_UNICODE", "WIN32", "_ENABLE_EXTENDED_ALIGNED_STORAGE", "WIN64", "QT_NO_DEBUG", "QT_WIDGETS_LIB", "QT_GUI_LIB", "QT_CORE_LIB", "NDEBUG" }
    buildoptions { "-Zc:rvalueCast", "-Zc:inline", "-Zc:strictStrings", "-Zc:throwingNew", "-Zc:referenceBinding", "-w34100", "-w34189", "-w44996", "-w44456", "-w44457", "-w44458" }
    runtime "Release"
    optimize "Speed"
    links { "$(QtLibDir)\\lib\\Qt5Widgets.lib";
            "$(QtLibDir)\\lib\\Qt5Gui.lib";
            "$(QtLibDir)\\lib\\Qt5Core.lib";
            "$(QtLibDir)\\lib\\qtmain.lib" 
          }
  
  filter {"files:../src/gui/moc_predefs_deb.cbt", "configurations:Debug"}
    buildmessage 'Generate moc_predefs.h'
    buildcommands {
       'cl -Bx$(QtLibDir)\\bin\\qmake.exe -nologo -Zc:wchar_t -FS -Zc:rvalueCast -Zc:inline -Zc:strictStrings -Zc:throwingNew -Zc:referenceBinding -Zi -MDd -W3 -w34100 -w34189 -w44996 -w44456 -w44457 -w44458 -wd4577 -wd4467 -E $(QtLibDir)\\mkspecs\\features\\data\\dummy.cpp 2>NUL > $(SolutionDir)../bin/$(ProjectName)_$(Platform)_$(Configuration)/moc_predefs.h'
    }
    buildoutputs { '$(SolutionDir)../bin/$(ProjectName)_$(Platform)_$(Configuration)/moc_predefs.h' }
    buildinputs { "$(QtLibDir)\\mkspecs\\features\\data\\dummy.cpp" }

  filter {"files:../src/gui/moc_predefs_rel.cbt", "configurations:Release"}
    buildmessage 'Generate moc_predefs.h'
    buildcommands {
      'cl -Bx$(QtLibDir)\\bin\\qmake.exe -nologo -Zc:wchar_t -FS -Zc:rvalueCast -Zc:inline -Zc:strictStrings -Zc:throwingNew -Zc:referenceBinding -O2 -MD -W3 -w34100 -w34189 -w44996 -w44456 -w44457 -w44458 -wd4577 -wd4467 -E $(QtLibDir)\\mkspecs\\features\\data\\dummy.cpp 2>NUL > $(SolutionDir)../bin/$(ProjectName)_$(Platform)_$(Configuration)/moc_predefs.h'
    }
    buildoutputs { '$(SolutionDir)../bin/$(ProjectName)_$(Platform)_$(Configuration)/moc_predefs.h' }
    buildinputs { "$(QtLibDir)\\mkspecs\\features\\data\\dummy.cpp" }
--]]
  filter {}