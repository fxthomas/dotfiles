# This function configures the current PowerShell console for using Visual
# Studio command-line tools ("Developper Command Prompt").
#
# Example:
#
#   Set-VsCmd 2015 x64  # Use VS 2015 64-bit tools
#   Set-VsCmd 2015 x86  # Use VS 2015 32-bit tools
#
# See: http://putridparrot.com/blog/setup-powershell-to-use-the-visual-studio-paths-etc/
# See: https://stackoverflow.com/questions/2124753/how-can-i-use-powershell-with-the-visual-studio-command-prompt
# See: https://msdn.microsoft.com/en-us/library/f2ccy3wt.aspx

function Set-VsCmd
{
    param(
        [parameter(Mandatory=$true, HelpMessage="Enter VS version as 2010, 2012, 2013, 2015, 2017")]
        [ValidateSet(2010,2012,2013,2015,2017)]
        [int]$version,
        [parameter(Mandatory=$true, HelpMessage="Enter architecture as x86, x64")]
        [ValidateSet("x86","x64")]
        [string]$arch
    )

    $VS_VERSION = @{ 2010 = "10.0"; 2012 = "11.0"; 2013 = "12.0"; 2015 = "14.0"; 2017 = "15.0" }
    $targetDir = "c:\Program Files (x86)\Microsoft Visual Studio $($VS_VERSION[$version])\VC"
    $vcvars = "vcvarsall.bat"

    if (!(Test-Path (Join-Path $targetDir $vcvars))) {
        "Error: Visual Studio $version not installed"
        return
    }
    pushd $targetDir
    cmd /c "$vcvars $arch & set" |
    foreach {
      if ($_ -match "(.*?)=(.*)") {
        Set-Item -force -path "ENV:\$($matches[1])" -value "$($matches[2])"
      }
    }
    popd
    write-host "`nVisual Studio $version ($arch) Command Prompt variables set." -ForegroundColor Yellow
}

