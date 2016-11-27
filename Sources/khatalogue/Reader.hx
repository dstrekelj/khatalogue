package khatalogue;

import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;

class Reader {
    public static function read(path : String) : Array<String> {
        var fullPath = Path.addTrailingSlash(FileSystem.fullPath(path));
        var files = FileSystem.readDirectory(fullPath);
        
        var fileContents = [];

        for (file in files) {
            if (hasExtension(file, 'md')) {
                fileContents.push(File.getContent(fullPath + file));
            }
        }

        return fileContents;
    }

    static function hasExtension(file : String, ext : String) : Bool {
        return file.split('.').pop() == ext;
    }
}
