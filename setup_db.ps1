param(
    [string]$RootPassword
)

# MySQL executable path
$MYSQL_PATH = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"

# Check for .env file
if (-not (Test-Path .env)) {
    Write-Host "❌ ERROR: .env file not found." -ForegroundColor Red
    exit 1
}

# Parse and evaluate .env variables
Get-Content .env | ForEach-Object {
    if ($_ -match "^(?<key>[A-Z0-9_]+)=(?<val>.*)$") {
        $key = $matches['key']
        $val = $matches['val'].Trim()

        # Evaluate PowerShell expressions like $(...)
        if ($val -match '^\$\((.*)\)$') {
            $evaluated = Invoke-Expression $matches[1]
            Set-Variable -Name $key -Value $evaluated
        } else {
            Set-Variable -Name $key -Value $val
        }
    }
}

# Test MySQL root connection
$TestConnection = & $MYSQL_PATH -u root -p$RootPassword -e "SELECT 1" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ ERROR: Failed to connect to MySQL." -ForegroundColor Red
    Write-Host $TestConnection -ForegroundColor Yellow
    exit 1
}

# Load and inject values into SQL
$sqlTemplate = Get-Content -Raw -Path "04_user_permissions.sql"
$sql = $sqlTemplate `
    -replace "{{DB_ADMIN_USER}}", $DB_ADMIN_USER `
    -replace "{{DB_ADMIN_PASSWORD}}", $DB_ADMIN_PASSWORD `
    -replace "{{DB_APP_USER}}", $DB_APP_USER `
    -replace "{{DB_APP_PASSWORD}}", $DB_APP_PASSWORD `
    -replace "{{DB_ANALYST_USER}}", $DB_ANALYST_USER `
    -replace "{{DB_ANALYST_PASSWORD}}", $DB_ANALYST_PASSWORD

# Write temporary SQL file
$tempSqlPath = "$env:TEMP\temp_setup_users.sql"
$sql | Set-Content -Path $tempSqlPath

# Execute it
$Output = Get-Content -Raw -Path $tempSqlPath | & $MYSQL_PATH -u root -p$RootPassword 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ SUCCESS: Users created and configured." -ForegroundColor Green
} else {
    Write-Host "❌ ERROR: SQL execution failed." -ForegroundColor Red
    Write-Host $Output -ForegroundColor Yellow
}
