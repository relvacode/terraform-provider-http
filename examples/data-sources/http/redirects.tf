# The following example shows how to disable automatic following of HTTP redirects.
# The default behaviour is to recursively follow HTTP redirects until a response no longer returns a redirect 3XX response code.
data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Do not automatically follow HTTP redirects and instead return on the first HTTP response.
  no_follow_redirects = true
}

locals {
  # The redirect URL location can usually be found in the 'Location' response header.
  example_redirect_uri = data.http.example.response_headers["Location"]
}