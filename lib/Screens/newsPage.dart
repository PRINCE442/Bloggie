import 'package:bloggie/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';


class NewsPage extends StatefulWidget {
  final Article article;
  const NewsPage(this.article);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<NewsProvider>(
      builder: (context, newsProvider, _) {
        final article = newsProvider.article;
        return SingleChildScrollView(
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
                          border: Border.all(
                              color: Colors.grey.shade300, width: 5.0),
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
                                  onPressed: () {},
                                  icon: const Icon(Icons.ios_share_rounded)),
                            ),
                            CircularIcon(
                              iconButton: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.save)),
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
                        backgroundImage: NetworkImage(widget.article.newsImage),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.article.newsAuthor,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Text(
                        '.',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '25th Feb 2024',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Text(
                        '.',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'World',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                  widget.article.newsTitle,
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
                    child: Image.network(
                      widget.article.newsImage,
                      fit: BoxFit.cover,
                    ),
                  )),
              const SizedBox(
                height: 45,
              ),
              Text(parse(widget.article.content).outerHtml)
            ],
          ),
        );
      },
    ));
  }
}
