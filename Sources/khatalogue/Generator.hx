package khatalogue;

import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;

class Generator {
    public static function generate(path : String, htmlFiles : Array<String>) : Void {
        var fullPath = Path.addTrailingSlash(FileSystem.fullPath(path));

        if (!FileSystem.exists(fullPath)) FileSystem.createDirectory(fullPath);

        for (i in 0...htmlFiles.length) {
            File.saveContent('${fullPath}/${i}.html', htmlFiles[i]);
        }
    }
}
