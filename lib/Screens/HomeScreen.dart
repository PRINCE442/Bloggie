import 'dart:convert';
import 'package:bloggie/Screens/Aboutus.dart';
import 'package:bloggie/Screens/BreakingNews.dart';
import 'package:bloggie/Screens/Notifications.dart';
import 'package:bloggie/Screens/ProfilePage.dart';
import 'package:bloggie/Screens/RecomForYou.dart';
import 'package:bloggie/Screens/Settings.dart';
import 'package:bloggie/Widgets/recomCard.dart';
import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/Widgets/request_queue.dart';

import 'package:flutter/material.dart';
import 'package:bloggie/Widgets/newsCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.newsItems});

  final List<Article> newsItems;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'news';
  List<Article>? categoryNewsItems;
  List<dynamic> searchResults = [];
  bool _isFetching = false;
  late var requestQueue = RequestQueue();

  @override
  void initState() {
    super.initState();
    fetchCategoryNews(selectedCategory);
    requestQueue = RequestQueue();
  }

  void handleSearch(String query) async {
    final results = await searchNews(query);
    setState(() {
      searchResults = results;
    });
  }

  Future<List<dynamic>> searchNews(String query) async {
    final url = Uri.https('api.newscatcherapi.com', '/v2/search', {
      'q': query,
      'page_size': '10',
      'page': '1',
      'lang': 'en',
      'from': '2023/2/15',
      'countries': 'NG,US,FR,DE,IL,SA',
    });

    final response = await http.get(url, headers: {
      'x-api-key': 'pTicM1Rrp-AqsVAgkdh5_Rgqko8Md5A_COfpZ01qArU',
    });
    print('API Response44444: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = data['articles'];
      return articles;
    } else {
      // Handle error
      print('Error444444: ${response.statusCode}');
      return [];
    }
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
            'https://api.newscatcherapi.com/v2/latest_headlines?lang=en&countries=US&topic=${category.toLowerCase()}';
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

  Future<List<Article>> fetchNewsArticles() async {
    const url =
        'https://api.newscatcherapi.com/v2/latest_headlines?lang=en&countries=NG';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': 'pTicM1Rrp-AqsVAgkdh5_Rgqko8Md5A_COfpZ01qArU'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List newsArticles = jsonData['articles'];

        return newsArticles
            .map((article) => Article.fromJson(article))
            .toList();
      } else {
        print('Failed to fetch news: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching news: $e');
      return [];
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to Log Out?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();

                  Navigator.of(context).pop();
                },
                child: const Text('Proceed'),
              ),
            ],
          );
        });
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    List<Article> _fetchedArticles = [];
    List<Article> _fetchedCategoryNews = [];
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 34.0),
            ),
          ),
          ListTile(
            title: const Text(
              ' Profile',
              style: TextStyle(fontSize: 20),
            ),
            leading: const Icon(
              Icons.person_2_sharp,
              color: //Theme.of(context).colorScheme.primary
                  Colors.blue,
              size: 24,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen()));
            },
          ),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
            leading: const Icon(
              Icons.settings,
              color: Colors.blue,
              size: 24,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ));
            },
          ),
          ListTile(
            title: const Text(
              'About Us',
              style: TextStyle(fontSize: 20),
            ),
            leading: const Icon(
              Icons.info_outline,
              color: Colors.blue,
              size: 24,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AboutUs(),
              ));
            },
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.blue,
              size: 24,
            ),
            onTap: () {
              _showConfirmationDialog(context);
            },
          ),
        ]),
      ),
      appBar: AppBar(
        title: const Text('Bloggie'),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final List<Article> refreshedArtiicles = await fetchNewsArticles();
          final List<Article>? refreshedCategoryNews =
              await fetchCategoryNews(selectedCategory);
          setState(() {
            _fetchedArticles = refreshedArtiicles;
            _fetchedCategoryNews = refreshedCategoryNews!;
          });
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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
                        icon: const Icon(Icons.menu),
                        onPressed: _openDrawer,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 229.0,
                  ),
                  Container(
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
                              onPressed: () async {
                                searchResults = await searchNews('');
                                showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(
                                    searchCallback: handleSearch,
                                    searchResults: searchResults,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.search)),
                        ),
                        CircularIcon(
                          iconButton: IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationPage(),
                                ));
                              },
                              icon: const Icon(Icons.notifications_none)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Breaking News',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 135,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BreakingNewsPage(
                              articles: _fetchedArticles,
                            ),
                          ));
                        },
                        child: const Text(
                          'Show More',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<Article>>(
                future: fetchNewsArticles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Failed to fetch news. Please refresh.'),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No news available. Please refresh.'),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: const Text('Refresh'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final newsItems = snapshot.data!;
                      _fetchedArticles = newsItems;
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: newsItems.length,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, index) {
                                final article = newsItems[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: NewsCard(article),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              const SizedBox(
                height: 18.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
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
                            print('hello world $category');
                            _handleCategoryButtonPress(category);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text(
                        'Recommended for You.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 50.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => CategoryButtonTest(),
                          ));
                        },
                        child: const Text(
                          'Show more',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 0.1,
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
      ),
    );
  }
}

class CircularIcon extends StatefulWidget {
  final IconButton iconButton;

  const CircularIcon({
    required this.iconButton,
    Key? key,
  }) : super(key: key);

  @override
  State<CircularIcon> createState() => _CircularIconState();
}

class _CircularIconState extends State<CircularIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: widget.iconButton,
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  List<dynamic> searchResults = [];
  final Function(String) searchCallback;
  final Article? article;
  String _searchQuery = '';

  CustomSearchDelegate({
    required this.searchCallback,
    required this.searchResults,
    this.article,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            _searchQuery = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  String get query => _searchQuery;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    searchCallback(_searchQuery);
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final result = searchResults[index];
        return RecomCard(result);
      },
    );
  }

  @override
  String get searchFieldLabel => "Let's help you find an article";

  @override
  Widget buildSuggestions(BuildContext context) {
    searchCallback(_searchQuery);

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final result = searchResults[index];
        return RecomCard(result);
      },
    );
  }
}
