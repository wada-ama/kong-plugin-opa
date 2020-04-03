package httpapi.authz

default allow = false

# Allows users to access '/status' endpoints
allow {
  input.method == "GET"
  glob.match("/status**", ["/"], input.path)
  input.token.payload.role == "user"
}