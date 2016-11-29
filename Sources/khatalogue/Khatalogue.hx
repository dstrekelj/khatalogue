package khatalogue;

class Khatalogue {
    static function main() : Void {
        var content = Reader.read('./Articles/');
        Generator.generate('./gh-pages/', content);
    }
}
