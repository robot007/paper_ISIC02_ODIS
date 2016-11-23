# Microsoft Developer Studio Project File - Name="CPPfit" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=CPPfit - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "CPPfit.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "CPPfit.mak" CFG="CPPfit - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "CPPfit - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "CPPfit - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "CPPfit - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "CPPfit - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "CPPfit - Win32 Release"
# Name "CPPfit - Win32 Debug"
# Begin Source File

SOURCE=.\Bandmat.cpp
# End Source File
# Begin Source File

SOURCE=.\Boolean.h
# End Source File
# Begin Source File

SOURCE=.\Cholesky.cpp
# End Source File
# Begin Source File

SOURCE=.\Controlw.h
# End Source File
# Begin Source File

SOURCE=.\CPPfit.cpp
# End Source File
# Begin Source File

SOURCE=.\Evalue.cpp
# End Source File
# Begin Source File

SOURCE=.\Fft.cpp
# End Source File
# Begin Source File

SOURCE=.\Fits.cpp
# End Source File
# Begin Source File

SOURCE=.\Fits.h
# End Source File
# Begin Source File

SOURCE=.\Hholder.cpp
# End Source File
# Begin Source File

SOURCE=.\Include.h
# End Source File
# Begin Source File

SOURCE=.\Jacobi.cpp
# End Source File
# Begin Source File

SOURCE=.\Myexcept.cpp
# End Source File
# Begin Source File

SOURCE=.\Myexcept.h
# End Source File
# Begin Source File

SOURCE=.\Newmat.h
# End Source File
# Begin Source File

SOURCE=.\Newmat1.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmat2.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmat3.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmat4.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmat5.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmat6.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmat7.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmat8.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmat9.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmatap.h
# End Source File
# Begin Source File

SOURCE=.\Newmatex.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmatio.h
# End Source File
# Begin Source File

SOURCE=.\Newmatnl.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmatnl.h
# End Source File
# Begin Source File

SOURCE=.\Newmatrc.h
# End Source File
# Begin Source File

SOURCE=.\Newmatrm.cpp
# End Source File
# Begin Source File

SOURCE=.\Newmatrm.h
# End Source File
# Begin Source File

SOURCE=.\Precisio.h
# End Source File
# Begin Source File

SOURCE=.\Solution.cpp
# End Source File
# Begin Source File

SOURCE=.\Solution.h
# End Source File
# Begin Source File

SOURCE=.\Sort.cpp
# End Source File
# Begin Source File

SOURCE=.\Submat.cpp
# End Source File
# Begin Source File

SOURCE=.\Svd.cpp
# End Source File
# End Target
# End Project
