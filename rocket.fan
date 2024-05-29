import "std/encoding" for Markdown
import "std/fs" for Fs, Path
import "std/os" for Env, Process
import "ai.fan" for Gemini

// Load the local .env file if it exists
Env.loadDotEnv(null)
// Set a variable to the API key
var GEMINI_KEY = Env.get("GEMINI_KEY")

var client = Gemini.client(GEMINI_KEY, "gemini-1.5-flash")
var msg = client.text("What's the formula for the circumferance of a circle. Calculate the circumferance of a circle with r=3")
var bodyJSON = msg.split("\n\n")[1]
System.print(bodyJSON)

// TODO: Extract the text field
// var output = Process.exec("echo", ["-n", "%(bodyJSON)", "|", "jq", "'.candidates[0].content.parts[0].text'"])

// System.print(output)

//var files = Fs.listAllRecursive(Fs.cwd())
//
//// List of markdown files in the directory
//var mdFiles = []
//
//for (i in files) {
//    if (Path.ext(i) == "md") {
//        System.print(i)
//        mdFiles.add(i)
//    }
//}
//
//System.print(mdFiles.count)
