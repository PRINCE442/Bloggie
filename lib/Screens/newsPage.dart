import 'package:bloggie/Screens/HomeScreen.dart';
import 'package:bloggie/Screens/SavedPage.dart';
import 'package:bloggie/provider/favoritesProvider.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsPage extends ConsumerWidget {
  final Article article;
  const NewsPage(this.article, {super.key});

  Future<void> shareNewsArticle(Article article) async {
    try {
      print('News URL: ${article.newsUrl}');

      const shareMessage =
          'I just found this news article on the Bloggie app. Check it out:';
      final shareUrl = article.newsUrl;
      await Share.share('$shareMessage\n$shareUrl', subject: 'BLOGGIE');
    } catch (e) {
      print('Error sharing: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteArticle = ref.watch(favoriteArticleProvider);
    final isFavorite = favoriteArticle.contains(article);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 60, 0, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 5.0),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 20.0,
                        icon: const Icon(Icons.arrow_back_ios_new_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 240.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      height: 50.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircularIcon(
                            iconButton: IconButton(
                                onPressed: () {
                                  shareNewsArticle(article);
                                },
                                icon: const Icon(Icons.ios_share_rounded)),
                          ),
                          CircularIcon(
                            iconButton: IconButton(
                                onPressed: () {
                                  final wasAdded = ref
                                      .read(favoriteArticleProvider.notifier)
                                      .getMealFavoriteStatus(article);
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        wasAdded
                                            ? 'Article has been added as a favorite'
                                            : 'Article has been removed as favorite',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: Colors.blue.shade400,
                                      padding: const EdgeInsets.all(12.0),
                                      elevation: 50,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.settings)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(article.media),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    article.newsAuthor.isNotEmpty
                        ? article.newsAuthor
                        : 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Text(
                      '.',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    article.newsDate,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Text(
                      '.',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    article.newsTopic,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.newsTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              height: 220,
              width: 390,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(40.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          child: Stack(
                            children: [
                              InteractiveViewer(
                                panEnabled: true,
                                child: Image.network(
                                  article.media.isNotEmpty ? article.media : '',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'Assets/images/logo.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 20.0,
                                right: 20.0,
                                child: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 220,
                    width: 390,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        article.media,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.content,
                style: const TextStyle(fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
