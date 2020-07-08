class News {
  String title;
  String text;
  String img;
  String url;

  News(this.title, this.text, this.img, this.url);
}

class NewsCategory {
  String category;
  List<News> news;

  NewsCategory(this.category, this.news);
}
