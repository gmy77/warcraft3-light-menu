$ErrorActionPreference = 'Stop'

$patchRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$source = Join-Path $patchRoot 'war3.w3mod\webui\webms'
$target = 'C:\Warcraft III\_retail_\webui\webms'

New-Item -ItemType Directory -Path $target -Force | Out-Null
Get-ChildItem -LiteralPath $source -File | Copy-Item -Destination $target -Force

New-Item -Path 'HKCU:\Software\Blizzard Entertainment\Warcraft III' -Force | Out-Null
New-ItemProperty -Path 'HKCU:\Software\Blizzard Entertainment\Warcraft III' `
    -Name 'Allow Local Files' -PropertyType DWord -Value 1 -Force | Out-Null

Get-ChildItem -LiteralPath $target | Select-Object Name, Length
Write-Host 'Light menu override applicato.'

