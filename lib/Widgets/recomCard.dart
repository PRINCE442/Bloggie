import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/Screens/newsPage.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/provider/provider.dart';
import 'package:provider/provider.dart';

class RecomCard extends StatelessWidget {
  final Article article;
  RecomCard(this.article);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => NewsPage(article)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
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
                  article.newsImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(article.newsImage),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Text(
                            article.newsAuthor,
                            style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '.',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        const Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Text(
                            'category',
                            style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        article.newsTitle,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Feb 4th 2024'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
