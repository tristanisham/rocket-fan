import "std/encoding" for Markdown
import "std/fs" for Fs, Path
import "std/os" for Env, Process
import "ai.fan" for Gemini
import "renderer.fan" for Renderer, SITE_DIR


// Load the local .env file if it exists
Env.loadDotEnv(null)
// Set a variable to the API key
var GEMINI_KEY = Env.get("GEMINI_KEY")
Fs.mkdir(SITE_DIR)

var client = Gemini.client(GEMINI_KEY, "gemini-1.5-flash")

var files = Fs.listAllRecursive(Fs.cwd())

for (i in files) {
    var rp = Renderer.outPath(i)
    var rpstr = rp.toString()
    var ext = Path.ext(i)

    if (ext == ".md") {
        System.print(rp.toString())
        var data = Fs.read(i)
        if (data == null) {
          continue
        }
        var out = Markdown.toHTML(data)
        Fs.write(rp.replaceExt(".html"), out)
    } else if (ext == ".ts" || ext == ".py" || ext == ".js" || ext == ".php") {
        var data = Fs.read(i)
        if (data == null) {
          continue
        }

        var sending = "You are a code analyzer, designed to write precise, helpful, and accurate documentation
            for code. Please describe the general overview of the purpose of the following code, and describe what each
            defined function does. Please rereference the code you are describing in each answer. Return your response
            in Markdown.

            '%(data)'
            "
        // System.print(sending)

        // Send the message to the AI
        var msg = client.text(sending)
        var body = msg.split("\n\n")[1]

        // Extract the text from the AI.
        // TODO: Replace with native JSON API after it's developed
        var output = Process.exec("echo", ["-n", "'%(body)'", "|", "jq", ".candidates[0].content.parts[0].text"])
        if (output == null || output.trim() == "null") {
            var err = Process.exec("echo", ["-n", "'%(body)'", "|", "jq", ".error.message"])
            System.print("ERROR: %(err)")
            
        } else {
            System.print("OUTPUT:")
            System.print(output)
        }
    }
}