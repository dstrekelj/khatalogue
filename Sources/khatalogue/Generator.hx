package khatalogue;

import haxe.io.Path;
import khatalogue.Models.Article;
import khatalogue.Models.Content;
import khatalogue.Models.Item;
import sys.io.File;
import sys.FileSystem;

class Generator {
    public static function generate(path : String, content : Content) : Void {
        var fullPath = Path.addTrailingSlash(FileSystem.fullPath(path));

        if (!FileSystem.exists(fullPath)) FileSystem.createDirectory(fullPath);
        if (!FileSystem.exists('${fullPath}/${content.articlesPath}')) FileSystem.createDirectory('${fullPath}/${content.articlesPath}');

        var indexTemplate = new haxe.Template(haxe.Resource.getString('templateIndex'));
        var indexContent = indexTemplate.execute(content);
        File.saveContent('${fullPath}/index.html', indexContent);

        var articleTemplate = new haxe.Template(haxe.Resource.getString('templateArticle'));

        for (article in content.articles) {
            File.saveContent('${fullPath}/${content.articlesPath}/${article.path}.html', articleTemplate.execute({ article: article }));
        }
    }
}
