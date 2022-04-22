Param(
  [string] $aaptPath,
  [string] $api
)

$apkPath = "build/app/outputs/flutter-apk/app-release.apk"

if (-not $api) {
  $api = ":8100/api"
}

if (-not $aaptPath) {
  $aaptPath = "D:\Android\SDK\build-tools\32.0.0\aapt2.exe"
}

# 获取apk的current版本
function getCurrentVersion {
  param ($parms)

  $_aaptPath = $parms[0]
  $_apkPath = $parms[1]

  $_array = 0, "1.0.0"
  $_codereg = "versionCode='(?<code>\d+)'"
  $_namereg = "versionName='(?<name>[\d.]+)'"

  if (Test-Path $_apkPath) {
    $_result = Invoke-Expression "$_aaptPath dump badging $_apkPath"

    if ($_result[0] -match $_codereg) {
      $_array[0] = [int]::Parse($Matches.code);
    }

    if ($_result[0] -match $_namereg) {
      $_array[1] = $Matches.name ;
    }
  }

  return $_array
}

# 获取apk的latest版本
function getLatestVersion {
  $_result = http get "$api/apkversion/latest"

  $_codereg = """VersionCode"":(?<code>\d+)"
  $_namereg = """VersionName"":""(?<name>[\d.]+)"""

  $_array = 0, ""

  if ($_result -match $_codereg) {
    $_array[0] = $Matches.code;
  }

  if ($_result -match $_namereg) {
    $_array[1] = $Matches.name;
  }

  return $_array
}

# 生成下个版本号
function GenNextVersionCode {
  param ($versionCode)
  return [int]::Parse($versionCode) + 1
}

# 生成下一个版本名
function GenNextVersionName {
  param ($_versionName)
  $_versionNameLastCode = $_versionName.Split('.', [System.StringSplitOptions]::RemoveEmptyEntries) | Select-Object -Last 1;
  $_name = $_versionName.Substring(0, $_versionName.Length - $_versionNameLastCode.Length) + ([int]::Parse($_versionNameLastCode) + 1);
  return $_name;
}

$currentVersion = getCurrentVersion($aaptPath, $apkPath)

$currentCode = $currentVersion[0]
$currentName = $currentVersion[1]
Write-Output "current version code: $currentCode"
Write-Output "current version name: $currentName"

$latestVersion = getLatestVersion;
$latestCode = $latestVersion[0]
$latestName = $latestVersion[1]
Write-Output "latest version code: $latestCode"
Write-Output "latest version name: $latestName"

if ($currentVersion.Length -eq 2) {

  $nextCode = GenNextVersionCode($latestCode)
  $nextName = GenNextVersionName($latestName)
    
  Write-Output "next version code $nextCode"
  Write-Output "next version name $nextName"

  # 编译项目
  Write-Output "flutter: flutter build apk"
  flutter build apk --build-number $nextCode --build-name $nextName --target-platform=android-arm64 --obfuscate --split-debug-info=./symbols
  
  # 获取cookie
  $cookie = ./get_cookie.ps1 $api

  if (-not $cookie) {
    Write-Output "没有获取到cookie"
    return
  }

  # 上传文件
  Write-Output "upload apk to server"

  $result = http -f post "$api/file" Cookie:$cookie "file@$apkPath"

  $idreg = """Result"":""(?<id>\d+)"""

  if ($result -match $idreg) {
    $id = $Matches.id
    Write-Output "apk upload success. id is $id"

    # 合并apk
    $result = http -j PUT "$api/apkVersion/merge/$id" Cookie:$cookie

    if ($result -match $idreg) {
      $id = $Matches.id

      # 激活apk
      Write-Output "updating apkversion to actived"
      http -j PUT "$api/apkVersion/$id/actived" Cookie:$cookie --raw=true

      Write-Output "success"
    }
    else {
      Write-Output "apk merge failure. message is $result"
    }
  }
  else {
    Write-Output "apk upload failure. message is $result"
  }
}
else {
  Write-Output "没有解析到app-release.apk的版本号"
  return
}
