import 'package:flutter/material.dart';
import 'package:bloggie/Models/NewsList.dart';

class NewsProvider extends ChangeNotifier {
  Article _newsContent = Article(
      newsAuthor: '',
      newsDate: '',
      media: '',
      newsTitle: '',
      content: '',
      id: '',
      newsUrl: '',
      newsTopic: '');

  Article get article => _newsContent;

  void setNewsContent(Article article) {
    _newsContent = article;
    print('News content set: $article');
    notifyListeners();
  }

  void fetchAndSetNewsContent(Article article) async {
    try {
      setNewsContent(article);
    } catch (error) {
      print('Error fetching news: $error');
    }
  }
}

class NewsImageProvider extends ChangeNotifier {
  late String _newsImage;

  String get newsImage => _newsImage;

  void setNewsImage(String imageUrl) {
    _newsImage = imageUrl;
    notifyListeners();
  }
}
