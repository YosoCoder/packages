@echo off
setlocal

:: Define the package folder name and location
set "PackageFolder=MyProfilePackage"
set "OutputFolder=%USERPROFILE%\Desktop"

:: Create the package folder
mkdir "%OutputFolder%\%PackageFolder%"

:: Copy files and folders to the package folder
copy "profile.ini" "%OutputFolder%\%PackageFolder%"
xcopy "profile_data" "%OutputFolder%\%PackageFolder%\profile_data" /E /I

:: Create a batch script to install the profile
(
  echo @echo off
  echo echo Installing My Profile...
  echo copy "%~dp0profile.ini" "%USERPROFILE%\Documents\MyProfile\profile.ini"
  echo xcopy /I /E /H "%~dp0profile_data" "%USERPROFILE%\Documents\MyProfile\profile_data"
  echo echo Profile installation complete.
  echo pause
) > "%OutputFolder%\%PackageFolder%\InstallProfile.bat"

:: Create a README file with instructions
(
  echo Installation Instructions:
  echo ------------------------
  echo 1. Run InstallProfile.bat to install the profile.
  echo 2. Follow on-screen prompts, if any.
) > "%OutputFolder%\%PackageFolder%\README.txt"

:: Create a ZIP archive of the package folder
powershell Compress-Archive -Path "%OutputFolder%\%PackageFolder%" -DestinationPath "%OutputFolder%\%PackageFolder%.zip" -Force

echo Package created successfully in "%OutputFolder%\%PackageFolder%.zip"

endlocal
