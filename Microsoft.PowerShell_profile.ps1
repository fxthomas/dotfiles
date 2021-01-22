$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
Import-Module 'C:\Users\fxthomas\Documents\WindowsPowerShell\Modules\ListProjectTasks.psm1'
Import-Module posh-git

# This function configures the current PowerShell console for using Visual
# C++ builds for Python extensions on the command line.
#
# Example:
#
#   Set-PyVsCmd 2.7
#
function Set-PyVsCmd
{
    param(
        [parameter(Mandatory=$true, HelpMessage="Enter Python version as 2.7")]
        [ValidateSet("2.7")]
        [string]$version,
        [parameter(Mandatory=$true, HelpMessage="Enter architecture as x86, x64")]
        [ValidateSet("x86","x64")]
        [string]$arch
    )

    switch ($arch)
    {
      "x86" { $vcvars = "vcvars32.bat" }
      "x64" { $vcvars = "vcvars64.bat" }
      default { $vcvars = "vcvarsall.bat" }
    }

    $VS_VERSION = @{ "2.7" = "9.0" }
    switch ($version)
    {
      "2.7" { $targetDir = "c:\Program Files (x86)\Microsoft Visual Studio $($VS_VERSION[$version])\VC\bin" }
    }

    if (!(Test-Path (Join-Path $targetDir $vcvars))) {
        "Error: Visual Studio $version not installed"
        return
    }
    pushd $targetDir
    cmd /c "$vcvars $arch $winsdkver & set" |
    foreach {
      if ($_ -match "(.*?)=(.*)") {
        Set-Item -force -path "ENV:\$($matches[1])" -value "$($matches[2])"
      }
    }
    popd

    # See: https://stackoverflow.com/a/29461265/821995
    Set-Item -force -path "ENV:DISTUTILS_USE_SDK" -value "1"
    Set-Item -force -path "ENV:MSSdk" -value "1"

    write-host "`nVisual Studio for Python $version ($arch) Command Prompt variables set." -ForegroundColor Yellow
}

function Set-VsCmd
{
    param(
        [parameter(Mandatory=$true, HelpMessage="Enter VS version as 2008, 2010, 2012, 2013, 2015, 2017, 2019")]
        [ValidateSet(2008,2010,2012,2013,2015,2017,2019)]
        [int]$version,
        [parameter(Mandatory=$true, HelpMessage="Enter architecture as x86, x64")]
        [ValidateSet("x86", "x64")]
        [string]$arch,
        # See folders located at: C:\Program Files (x86)\Windows Kits\10\bin
        [parameter(Mandatory=$true, HelpMessage="Enter Windows SDK version as 8.1 or 10")]
        [ValidateSet("8.0", "8.1", "10.0.10150.0", "10.0.10240.0", "10.0.16299.0", "10.0.17134.0", "10.0.18362.0", "10.0.19041.0")]
        [string]$winsdkver,
        [parameter(Mandatory=$false, HelpMessage="Display environment variables being set")]
        [switch]$showvariables
    )

    # See: https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=vs-2019
    if ($version -lt 2017) {
      $VS_VERSION = @{ 2008 = "9.0"; 2010 = "10.0"; 2012 = "11.0"; 2013 = "12.0"; 2015 = "14.0"; 2017 = "15.0" }
      $targetDir = "c:\Program Files (x86)\Microsoft Visual Studio $($VS_VERSION[$version])\VC"
      $vcvars = "vcvarsall.bat"
    } elseif ($version -lt 2019) {
      $targetDir = "C:\Program Files (x86)\Microsoft Visual Studio\$version\BuildTools\VC\Auxiliary\Build"
      $vcvars = "vcvarsall.bat"
    } else {
      # https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/how-to-set-environment-variables-for-the-visual-studio-command-line
      $targetDir = "C:\Program Files (x86)\Microsoft Visual Studio\$version\Professional\Common7\Tools"
      $vcvars = "VsDevCmd.bat"
    }

    if (!(Test-Path (Join-Path $targetDir $vcvars))) {
        "Error: Visual Studio $version not installed"
        return
    }
    pushd $targetDir
    cmd /c "$vcvars $arch $winsdkver & set" |
    foreach {
      if ($_ -match "(.*?)=(.*)") {
        if ($showvariables) {
          Write-Host "Environment variable '$($matches[1])' set to '$($matches[2])'"
        }
        Set-Item -force -path "ENV:\$($matches[1])" -value "$($matches[2])"
      }
    }
    popd

    # See: https://stackoverflow.com/a/29461265/821995
    Set-Item -force -path "ENV:DISTUTILS_USE_SDK" -value "1"
    Set-Item -force -path "ENV:MSSdk" -value "1"

    write-host "`nVisual Studio $version ($arch) Command Prompt variables set." -ForegroundColor Yellow
}

# Load developper tools for VS 2015 64-bits, with Windows SDK 8.1
# Set-VsCmd 2015 x64 8.1

# Load developper tools for Python compilation
# Set-PyVsCmd 2.7 x64

# Set aliases for python
function python2() { py -2 $args }
function python2() { py -2 $args }
function python3() { py -3 $args }
function python2_64() { py -2.7-64 $args }
function python3_64() { py -3.6-64 $args }
function pip2() { py -2 -mpip $args }
function pip3() { py -3 -mpip $args }
function pip2_64() { py -2.7-64 -mpip $args }
function pip3_64() { py -3.6-64 -mpip $args }
function ipython2() { py -2 -mIPython $args }
function ipython3() { py -3 -mIPython $args }
function ipython2_64() { py -2.7-64 -mIPython $args }
function ipython3_64() { py -3.6-64 -mIPython $args }
function lrt() { Get-ChildItem $args | Sort-Object LastWriteTime }

# Use Ctrl-D to exit Powershell
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
# Use Ctrl-W to delete the last word
Set-PSReadlineKeyHandler -Key Ctrl+w -Function BackwardKillWord
# Make Tab completion show a menu
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
