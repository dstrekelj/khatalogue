package khatalogue;

import haxe.io.Path;
import khatalogue.Models.Article;
import khatalogue.Models.Content;
import khatalogue.Models.Item;
import sys.io.File;
import sys.FileSystem;

class Reader {
    public static function read(path : String) : Content {
        var fullPath = Path.addTrailingSlash(FileSystem.fullPath(path));
        var files = FileSystem.readDirectory(fullPath);
        
        var articlesPath = 'articles/';
        var articles : Array<Article> = [];
        var items : Array<Item> = [];

        for (file in files) {
            if (hasExtension(file, 'md')) {
                var titleArray = file.split('_');
                titleArray.shift();
                titleArray = titleArray.join(' ').split('.');
                titleArray.pop();
                var title = titleArray.join(' ');
                var path = file.split('.').shift();

                items.push({ path: articlesPath + path + '.html', title: title });
                
                var content = Markdown.markdownToHtml(replaceKhatalogueTags(File.getContent(fullPath + file)));

                articles.push({ content: content, path: path, title: title });
            }
        }

        return { articlesPath: articlesPath, articles: articles, items: items };
    }

    static function hasExtension(file : String, ext : String) : Bool {
        return file.split('.').pop() == ext;
    }

    static function replaceKhatalogueTags(content : String) : String {
        return ~/(\[khatalogue-sample\])(\()(.+?)(\))/g.replace(content, '<canvas id="$3" width="640" height="240"></canvas><script src="./js/$3.js"></script>');
    }
}
