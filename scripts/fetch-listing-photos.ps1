$ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
$outDir = "C:\src\sodemanrealty\docs\src\assets\img\listings"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$props = @(
  @{ id = "1407-hayes-muir"; url = "https://homefinder.com/realestateandhomes-detail/1407-Hayes-Rd_Muir_MI_48860_M37761-70622" },
  @{ id = "312-rockford-lansing"; url = "https://homefinder.com/realestateandhomes-detail/312-W-Rockford-Rd_Lansing_MI_48910_M48595-22356" },
  @{ id = "9215-clinton-eaton-rapids"; url = "https://homefinder.com/realestateandhomes-detail/9215-S-Clinton-Trl_Eaton-Rapids_MI_48827_M37700-33450" },
  @{ id = "3119-norwich-lansing"; url = "https://homefinder.com/realestateandhomes-detail/3119-Norwich-Rd_Lansing_MI_48911_M46633-54434" },
  @{ id = "3648-meadows-okemos"; url = "https://homefinder.com/realestateandhomes-detail/3648-E-Meadows-Ct_Okemos_MI_48864_M31864-42707" }
)

function Get-PrimaryPhotoUrl([string]$html) {
  $m = [regex]::Match($html, 'https://ap\.rdcpix\.com/[a-f0-9]+l-m\d+rd-w1280_h960\.webp')
  if ($m.Success) { return $m.Value }
  $m = [regex]::Match($html, 'https://ap\.rdcpix\.com/[a-f0-9]+l-m\d+od-w\d+_h\d+\.jpg')
  if ($m.Success) { return $m.Value }
  $m = [regex]::Match($html, 'https://ap\.rdcpix\.com/[^"''\s>]+\.(?:jpg|webp)')
  if ($m.Success) { return $m.Value }
  return $null
}

foreach ($p in $props) {
  Write-Output "---- $($p.id) ----"
  try {
    $r = Invoke-WebRequest -Uri $p.url -UserAgent $ua -UseBasicParsing -TimeoutSec 40
  } catch {
    Write-Output "  page fail: $($_.Exception.Message)"
    continue
  }

  $photo = Get-PrimaryPhotoUrl $r.Content
  Write-Output "  photo: $photo"
  if (-not $photo) {
    Write-Output "  NO PHOTO"
    continue
  }

  $destJpg = Join-Path $outDir "$($p.id).jpg"
  $destWebp = Join-Path $outDir "$($p.id).webp"

  try {
    if ($photo -match '\.webp') {
      Invoke-WebRequest -Uri $photo -OutFile $destWebp -UserAgent $ua -UseBasicParsing
      $jpgUrl = $photo -replace 'rd-w1280_h960\.webp', 'od-w1280_h960.jpg'
      try {
        Invoke-WebRequest -Uri $jpgUrl -OutFile $destJpg -UserAgent $ua -UseBasicParsing
      } catch {
        $jpgUrl2 = $photo -replace 'rd-w1280_h960\.webp', 'od-w640_h480.jpg'
        try {
          Invoke-WebRequest -Uri $jpgUrl2 -OutFile $destJpg -UserAgent $ua -UseBasicParsing
        } catch {}
      }
    } else {
      Invoke-WebRequest -Uri $photo -OutFile $destJpg -UserAgent $ua -UseBasicParsing
    }

    Get-ChildItem (Join-Path $outDir "$($p.id).*") | ForEach-Object {
      Write-Output "  saved $($_.Name) $($_.Length)"
    }
  } catch {
    Write-Output "  download fail: $($_.Exception.Message)"
  }

  Start-Sleep -Milliseconds 900
}
