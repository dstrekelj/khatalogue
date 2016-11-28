package khatalogue;

typedef Article = {
    var path : String;
    var content : String;
    var title : String;
}

typedef Content = {
    var articlesPath : String;
    var articles : Array<Article>;
    var items : Array<Item>;
}

typedef Item = {
    var path : String;
    var title : String;
}
