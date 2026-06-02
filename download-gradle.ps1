$cacheDir = "$env:USERPROFILE\.gradle\wrapper\dists\gradle-7.5.1-all"
New-Item -ItemType Directory -Path $cacheDir -Force -ErrorAction SilentlyContinue | Out-Null
$zipPath = "$cacheDir\gradle-7.5.1-all.zip"
Write-Host "Downloading Gradle 7.5.1 to $zipPath..."
Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-7.5.1-all.zip' -OutFile $zipPath -TimeoutSec 600
Write-Host "Download complete at $zipPath"
