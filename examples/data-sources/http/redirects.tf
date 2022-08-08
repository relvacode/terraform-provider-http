# The following example shows how to disable automatic following of HTTP redirects.
# The default behaviour is to recursively follow HTTP redirects until a response no longer returns a redirect 3XX response code.
data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Do not automatically follow HTTP redirects and instead return on the first HTTP response.
  no_follow_redirects = true
}


# Make another HTTP request, this time using the redirect location from the first request.
data "http" "example_redirected_location" {
  lifecycle {
    precondition {
      condition     = contains([302], data.http.example.status_code)
      error_message = "Server did not respond with a 302 Found HTTP redirect"
    }
  }

  url = data.http.example.location
}
