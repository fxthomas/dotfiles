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

# This function configures the current PowerShell console for using Visual
# Studio command-line tools ("Developper Command Prompt").
#
# Example:
#
#   Set-VsCmd 2015 x64 8.1  # Use VS 2015 64-bit tools with the 8.1 SDK
#   Set-VsCmd 2015 x86 8.1  # Use VS 2015 32-bit tools with the 8.1 SDK
#
# See: http://putridparrot.com/blog/setup-powershell-to-use-the-visual-studio-paths-etc/
# See: https://stackoverflow.com/questions/2124753/how-can-i-use-powershell-with-the-visual-studio-command-prompt
# See: https://msdn.microsoft.com/en-us/library/f2ccy3wt.aspx
function Set-VsCmd
{
    param(
        [parameter(Mandatory=$true, HelpMessage="Enter VS version as 2008, 2010, 2012, 2013, 2015, 2017")]
        [ValidateSet(2008,2010,2012,2013,2015,2017)]
        [int]$version,
        [parameter(Mandatory=$true, HelpMessage="Enter architecture as x86, x64")]
        [ValidateSet("x86","x64")]
        [string]$arch,
        [parameter(Mandatory=$true, HelpMessage="Enter Windows SDK version as 8.1 or 10")]
        [ValidateSet("8.1")]
        [string]$winsdkver
    )

    if ($version -lt 2017) {
      $VS_VERSION = @{ 2008 = "9.0"; 2010 = "10.0"; 2012 = "11.0"; 2013 = "12.0"; 2015 = "14.0"; 2017 = "15.0" }
      $targetDir = "c:\Program Files (x86)\Microsoft Visual Studio $($VS_VERSION[$version])\VC"
      $vcvars = "vcvarsall.bat"
    } else {
      $targetDir = "C:\Program Files (x86)\Microsoft Visual Studio\$version\BuildTools\VC\Auxiliary\Build"
      $vcvars = "vcvarsall.bat"
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
