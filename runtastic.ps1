# Setup Variables
$appKey = "at.runtastic.gpssportapp"
$clientSecret = "QO3wOdHttnMamWEdtyziWfhUXY4A0jQQ3YV1xOT1UBro4w2V4SxMnjbias8vqRXE"

$headers = @{
    "X-App-Version" = "11.19.1"
    "X-App-Key" = $appKey
    "Content-Type" = "application/json"
}

# Functions
Function make_auth_token($appKey, $appSecret, $str_now) {
    # Not directly translatable to PowerShell, you may need to import additional modules for SHA1 hashing
    # Placeholder return value
    Return "auth_token"
}

Function make_request_header($header) {
    $str_now = Get-Date -Format "yyyy-MM-dd'T'HH:mm:ss"
    $auth_token = make_auth_token $appKey $clientSecret $str_now
    $header["X-Date"] = $str_now
    $header["X-Auth-Token"] = $auth_token
    Return $header
}

Function login($username, $password) {
    $headers = make_request_header $headers
    $loginRequestBody = @{
        "clientSecret" = $clientSecret
        "password" = $password
        "grantType" = "password"
        "username" = $username
        "clientId" = "L51fb74143ae7db04b45c174306eaed92da04af60b61d3a77a19315047ae5a65"
    } | ConvertTo-Json

    $loginResponse = Invoke-RestMethod -Uri 'https://appws.runtastic.com/webapps/services/auth/v2/login/runtastic' -Method Post -Body $loginRequestBody -Headers $headers
    $headers["Authorization"] = "Bearer " + $loginResponse.accessToken

    Return $loginResponse
}

# Call the login function with your credentials
$loginResponse = login "your-username" "your-password"

# Print the login response to check if it's working
$loginResponse