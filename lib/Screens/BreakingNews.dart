import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/Navigations/BottomTabBar.dart';
import 'package:flutter/material.dart';

import 'package:bloggie/Widgets/newsCard.dart';

class BreakingNewsPage extends StatefulWidget {
  final List<Article> articles;
  const BreakingNewsPage({Key? key, required this.articles}) : super(key: key);

  @override
  State<BreakingNewsPage> createState() => _BreakingNewsPageState();
}

class _BreakingNewsPageState extends State<BreakingNewsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 55, 0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BottomTabBar(),
                          ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Breaking News',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                    ),
                  ]),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.articles.length,
                itemBuilder: (context, index) {
                  final article = widget.articles[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NewsCard(article),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
