import "std/net/http" for Request

class Gemini {
    construct client(apiKey, model) {
        _key = apiKey

        if (model == null || !(model is String)) {
            _model = "gemini-1.5-flash"
        } else if (model is String) {
            _model = model
        }

        _url = "https://generativelanguage.googleapis.com/v1beta/models/%(_model):generateContent?key=%(_key)"
    }

    text(message) {
        var req = Request.new(_url)
        req.header("Content-Type", "application/json")
        req.method("POST")
        var content = "{\"contents\":[{\"parts\":[{\"text\":\"%(message)\"}]}]}"
        req.body(content)

        var resp = req.send()

        return resp
    }
}
