import 'package:intl/intl.dart';

class Article {
  Article({
    required this.newsTitle,
    required this.newsAuthor,
    required this.media,
    required this.content,
    required this.newsDate,
    required this.newsTopic,
    required this.newsUrl,
    this.id,
  });
  final String? id;
  final String newsTitle;
  final String newsAuthor;
  final String media;
  final String content;
  final String newsDate;
  final String newsTopic;
  final String newsUrl;

  factory Article.fromJson(Map<String, dynamic> json) {
    final link = json['link'] ?? '';
    final uri = Uri.tryParse(link);
    String newsUrl;

    if (uri != null) {
      newsUrl = uri.toString();
    } else {
      newsUrl = 'https://example.com/placeholder';
    }

    final publishedDateString = json['published_date'] ?? '';
    final publishedDate = DateTime.tryParse(publishedDateString);

    String formattedNewsDate;
    if (publishedDate != null) {
      formattedNewsDate = DateFormat('MMM d, yyyy').format(publishedDate);
    } else {
      formattedNewsDate = 'No date available';
    }

    return Article(
      newsTitle: json['title'] ?? 'Error fetching title',
      newsAuthor: json['author'] ?? 'Unknown',
      newsDate: formattedNewsDate,
      newsTopic: json['topic'] ?? 'Unknown',
      newsUrl: newsUrl,
      media: json['media'] ??
          'https://c8.alamy.com/comp/2JA6BFB/no-image-vector-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder-2JA6BFB.jpg',
      content: json['summary'] ?? 'No news data found',
    );
  }
}
