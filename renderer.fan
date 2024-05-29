import "std/fs" for Path, Fs

var SITE_DIR = "_site"

class Renderer {
    static outPath(i) {
        var basename = Path.basename(i)
        var relativePath = basename
        var cwd = Fs.cwd()

        if (basename.startsWith(cwd)) {
            relativePath = basename.trimStart(cwd)
        }

        var filename = Path.filename(i)
        var realPath = Path.join([cwd, SITE_DIR, relativePath, filename])

        return realPath
    }

}