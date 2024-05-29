import "std/net/http" for Request
var req = Request.new("https://example.com")
System.print(req.send())
