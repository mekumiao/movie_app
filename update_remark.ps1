Param(
  [string] $remark,
  [string] $api
)

if (-not $remark) {
  $remark = "1.发布新版本`n"
}

if (-not $api) {
  $api = ":8100/api"
}

function getLatestId {
  $_result = http get "$api/apkversion/latest"

  $_idreg = """Id"":""(?<id>\d+)"""

  if ($_result -match $_idreg) {
    return $Matches.id
  }
}

$id = getLatestId;

$cookie = ./get_cookie.ps1 $api

Write-Output "updating apkversion remark to $remark"
http -v -j PUT "$api/apkVersion/$id" "remark=$remark" Cookie:$cookie
