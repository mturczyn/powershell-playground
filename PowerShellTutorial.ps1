# =============================================================================
# PowerShell Learning Script
# =============================================================================

# Variables
$anotherTestVariable = 2

# Functions ===================================================================
function MyPrint {
    Write-Host 'print print'
}

# Subexpression Operator $()
$name = "World"
"Hello $name"        # → Hello World
"Hello $(Get-Date)"  # → Hello <current date/time>

function MyPrint2 {
    Write-Host 'print print'
}

# Dot sourcing ================================================================
# Assume script has function Do-Stuff defined. Then the command:
#   .\ScriptWithMethod.ps1
# would run the script, but the function would not be available afterward.
#
# However:
#   . .\ScriptWithMethod.ps1
# (note the extra dot and space) runs the script in the current scope,
# making its functions available in the current context.
#
# This works like importing the script into the current session.

# Call Operator ===============================================================
$name = 'Michal'
$cmd  = 'Write-Host'

& $cmd $name
& $cmd "hello again $name"

# Arrays ======================================================================
cls

function Print-Array {
    param([object]$arr)

    if ($arr -is [array]) {
        foreach ($item in $arr) {
            Write-Host $item
        }
    } else {
        Write-Host "Not an array"
    }
}

Print-Array ( ,1 )      # Force single-element array
Print-Array (1..5)

# Array Subexpression @()
Print-Array @(10)       # Forces array
Print-Array 10          # Not an array

# Functions, Filters, and Script Blocks as Parameters =========================
cls
filter Get-BigFiles {
    if ($_.Length -gt 0KB) { $_ }
}

Get-ChildItem | Get-BigFiles

# Custom Objects ==============================================================
cls
$report = @()
$report += [PSCustomObject]@{
    Name   = "ServiceA"
    Status = "Running"
    Time   = Get-Date
}

Write-Host $report.Status

# Pipeline and Parallelism ====================================================
cls
1..10 | ForEach-Object -Parallel {
    "Processing $_ on $([System.Environment]::ProcessorCount) cores"
}
