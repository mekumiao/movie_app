$cookie = ./get_cookie.ps1 :8100/api

$cookie

http -v -j get :8100/api/movie Cookie:$cookie
