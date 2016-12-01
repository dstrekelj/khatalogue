package khatalogue;

import khatalogue.Models.Content;

class Parser {
    public static function parse(content : Content) : Content {
        for (item in content.items) {
            item.title = parseTitle(item.title);
        }

        for (article in content.articles) {
            article.title = parseTitle(article.title);
            article.content = parseScripts(article.content);
            article.content = Markdown.markdownToHtml(article.content);
        }

        return content;
    }

    static function parseTitle(title : String) : String {
        return ~/(\d+)(_+)([a-zA-Z0-9_]*)(\.*\w*)+/gi
            .replace(title, '$3')
            .split('_')
            .join(' ');
    }

    static function parseScripts(content : String) : String {
        return ~/(\[khatalogue-sample\])(\()(.+?)(\))/g
            .replace(
                content,
                '<canvas id="$3" width="640" height="240"></canvas>\n'+
                '<script src="../js/$3.js"></script>'
            );
    }
}
