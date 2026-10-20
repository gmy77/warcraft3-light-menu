$ErrorActionPreference = 'Stop'

$target = 'C:\Warcraft III\_retail_\webui'
if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Recurse -Force
}

Remove-ItemProperty `
    -Path 'HKCU:\Software\Blizzard Entertainment\Warcraft III' `
    -Name 'Allow Local Files' -ErrorAction SilentlyContinue

Write-Host 'Override locale rimosso; Warcraft III torna ai file CASC originali.'

