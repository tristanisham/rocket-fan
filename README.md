# Rocket

Rocket is an AI powered static site generator written in [Fan](https://github.com/tristanisham/fan).

## Installing
Fan is a very alpha language, and thus requires you to compile it on your own machine. It works with GCC > 10 and Clang > 13 on Linux, but theoretically it can support any POSIX compiler that can compile C++20. Go to the [Fan GitHub](https://github.com/tristanisham/fan) for installation instructions.

## Using
Fan requires the `FAN_LIB` environment variable to be set pointing to the standard library. Please modify your environment or the provided `fan.sh` script to properly use this program. 

Navigate to your code's repository. Rocket will scan over each files, and if it detects code, it will use Google's Gemini Flash model to summarize your code and its purpose in order to generate useful documentation. Useful is relative, and nothing's less useful than no docs at all. That summary will rendered from Markdown into HTML in the `_site` directory. You can serve this as it's all static HTML. If your project has Markdown, that will be rendered as well into the `_site` dir, where your static site will live.
