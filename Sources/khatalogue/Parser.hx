package khatalogue;


class Parser {
    public static function parse(contents : Array<String>) : Array<String> {
        var htmlFiles = [];

        for (content in contents) {
            htmlFiles.push(Markdown.markdownToHtml(content));
        }

        return htmlFiles;
    }
}
