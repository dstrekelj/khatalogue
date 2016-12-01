package khatalogue;

class Khatalogue {
    static function main() : Void {
        var content = Reader.read('./Articles/');
        content = Parser.parse(content);
        Generator.generate('./gh-pages/', content);
    }
}
