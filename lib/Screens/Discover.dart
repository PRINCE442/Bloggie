import 'dart:convert';

import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/Navigations/BottomTabBar.dart';
import 'package:bloggie/Widgets/newsCard.dart';
import 'package:bloggie/Widgets/recomCard.dart';
import 'package:bloggie/Widgets/request_queue.dart';
import 'package:http/http.dart' as http;

import 'package:bloggie/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  final Article? article;

  const DiscoverScreen({super.key, this.article});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String selectedCategory = 'news';
  List<Article>? categoryNewsItems;

  bool _isFetching = false;
  late var requestQueue = RequestQueue();

  @override
  void initState() {
    super.initState();
    fetchCategoryNews(selectedCategory);
    requestQueue = RequestQueue();
  }

  List<Article> _filterDuplicateArticles(List<Article> articles) {
    final uniqueArticles = <Article>{};
    final seenTitles = <String>{};

    for (final article in articles) {
      if (!seenTitles.contains(article.newsTitle)) {
        seenTitles.add(article.newsTitle);
        uniqueArticles.add(article);
      }
    }

    return uniqueArticles.toList();
  }

  Future<List<Article>?> fetchCategoryNews(String category) async {
    print('fetchCategoryNews called with category: $category');
    return requestQueue.enqueue(() async {
      if (_isFetching ||
          category == selectedCategory && categoryNewsItems != null) {
        return categoryNewsItems;
      }
      setState(() {
        _isFetching = true;
      });

      try {
        await Future.delayed(const Duration(seconds: 2));

        final url =
            'https://api.newscatcherapi.com/v2/latest_headlines?lang=en&countries=FR,DE,IL,SA&topic=${category.toLowerCase()}';
        final response = await http.get(
          Uri.parse(url),
          headers: {'x-api-key': 'pTicM1Rrp-AqsVAgkdh5_Rgqko8Md5A_COfpZ01qArU'},
        );

        print('API Response: ${response.body}');

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = json.decode(response.body);
          final List<dynamic> newsArticles = jsonData['articles'];
          categoryNewsItems = _filterDuplicateArticles(newsArticles
              .map((article) =>
                  Article.fromJson(article as Map<String, dynamic>))
              .toList());

          setState(() {
            selectedCategory = category;

            _isFetching = false;
          });
          print('Fetched news articles: ${categoryNewsItems!.length}');
          for (var article in categoryNewsItems!) {
            print('Article Category: ${article.newsTopic}');
          }
          return categoryNewsItems!;
        } else if (response.statusCode == 429) {
          // Rate limit exceeded, introduce a delay before retrying
          await Future.delayed(const Duration(seconds: 4));
          return fetchCategoryNews(category);
        } else {
          print('Failed to fetch news: ${response.statusCode}');
          print('Fetching news for category: $category');
          return [];
        }
      } catch (e) {
        print('Error fetching news: $e');
        return [];
      } finally {
        setState(() {
          _isFetching = false;
        });
      }
    });
  }

  void _handleCategoryButtonPress(String category) async {
    final categoryNews = await fetchCategoryNews(category);
    setState(() {
      categoryNewsItems = categoryNews;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 60, 0, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 330, 0),
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 5.0),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 20.0,
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const BottomTabBar(),
                    ));
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
              child: Text(
                'Discover',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 180, 0),
              child: Text(
                'News from all around the world',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 45.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    spellCheckConfiguration: const SpellCheckConfiguration(),
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Discover whats best for you',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    'News',
                    'Politics',
                    'Sport',
                    'World',
                    'Gaming',
                    'Finance',
                    'Tech',
                    'Entertainment',
                    'Business',
                    'Economics',
                    'Music',
                    'Science',
                    'Travel',
                    'Beauty',
                    'Food',
                    'Energy'
                  ].map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CategoryCard(
                        category: category,
                        onTap: () {
                          print('hellow orld $category');
                          _handleCategoryButtonPress(category);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 22.0,
            ),
            if (_isFetching)
              const Center(child: CircularProgressIndicator())
            else if (categoryNewsItems == null || categoryNewsItems!.isEmpty)
              const Center(child: Text('No articles found'))
            else
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: categoryNewsItems!.length,
                  itemBuilder: (context, index) {
                    final article = categoryNewsItems![index];
                    return RecomCard(article);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
