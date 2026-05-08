#!/usr/bin/env pwsh
Get-ChildItem `
| Where-Object { $_.extension -eq ".webm" } `
| Where-Object { -not [IO.File]::Exists($_.Basename + ".en.vtt") -and -not [IO.File]::Exists($_.Basename + ".vtt") } `
| & {
    begin {
        "#!/bin/dash"
        "set -e"
    }
    process {
        $_ = $_.Name -replace '([$"])', '\$1'
        ("~/opt/llmscripts/whisper3.sh `"" + $_ + "`"")
    }
} > whisper.sh
chmod +x whisper.sh
