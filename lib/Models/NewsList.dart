class Article {
  Article({
    required this.newsAuthor,
    required this.newsDate,
    required this.newsImage,
    required this.newsTitle,
    required this.content,
  });

  final String newsTitle;
  final String newsAuthor;
  final String newsImage;
  final String content;
  final String newsDate;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      newsTitle: json['title'] ?? '',
      newsAuthor: json['name'] ?? '',
      newsDate: json['publishedAt'] ?? '',
      newsImage: json['urlToImage'] ??
          'https://c8.alamy.com/comp/2JA6BFB/no-image-vector-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder-2JA6BFB.jpg',
      content: json['content'] ?? '',
    );
  }
}
