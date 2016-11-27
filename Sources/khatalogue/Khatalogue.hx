package khatalogue;

class Khatalogue {
    static function main() : Void {
        var contents = Reader.read('./Articles/');
        var articles = Parser.parse(contents);
        Generator.generate('./out/', articles);
    }
}
