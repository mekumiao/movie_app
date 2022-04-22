Param(
  [string] $api
)

if (-not $api) {
  $api = ":8100/api"
}

$_result = http -v -j post "$api/account/login" username=admin password=123123

foreach ($item in $_result) {
  $_cookiereg = "Set-Cookie: (?<cookie>[\w\d\s.=-]*)"
  if ($item -match $_cookiereg) {
    $Matches.cookie
    return
  }
}

