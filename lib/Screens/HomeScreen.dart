import 'dart:convert';
import 'package:bloggie/Screens/Aboutus.dart';
import 'package:bloggie/Screens/BreakingNews.dart';
import 'package:bloggie/Screens/Notifications.dart';
import 'package:bloggie/Screens/ProfilePage.dart';
import 'package:bloggie/Screens/RecomForYou.dart';
import 'package:bloggie/Screens/Settings.dart';
import 'package:bloggie/Widgets/recomCard.dart';
import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/constants.dart';
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
  @override
  void initState() {
    super.initState();

    fetchNewsArticles();
  }

  Future<List<Article>> fetchNewsArticles() async {
    const apikey = '08e65243a1ea41c1bbb42024495014b0';

    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=08e65243a1ea41c1bbb42024495014b0'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> newsArticles = jsonData['articles'];

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate());
                            },
                            icon: const Icon(Icons.search)),
                      ),
                      CircularIcon(
                        iconButton: IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const NotificationPage(),
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const BreakingNewsPage(),
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
                  return Text('Error: ${snapshot.error}');
                } else {
                  final newsItems = snapshot.data ?? [];
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
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, index) {
                            final article = newsItems[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: NewsCard(article),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              },
            ),

            // Container(
            //   height: 200,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     physics: const AlwaysScrollableScrollPhysics(),
            //     itemCount: widget.newsItems.length,
            //     itemBuilder: (context, index) {
            //       final article = widget.newsItems[index];
            //       return NewsCard(
            //         imagepath: article.newsImage,
            //         title: article.newsTitle,
            //         category: 'Tech',
            //       );
            //     },
            //     // child: Row(
            //     //   children: [
            //     //     NewsCard(
            //     //       imagepath:
            //     //           'https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-1845882546.jpg?c=16x9&q=h_653,w_1160,c_fill/f_webp',
            //     //       title:
            //     //           'Elon Musk says Tesla shareholders will vote ‘immediately’ on quitting Delaware for Texas',
            //     //       category: 'Tech',
            //     //     ),
            //     //     SizedBox(
            //     //       width: 30.0,
            //     //     ),
            //     //     NewsCard(
            //     //       imagepath:
            //     //           'https://e0.365dm.com/24/01/768x432/skysports-mohamed-salah-liverpool_6426155.jpg?20240118225944',
            //     //       title:
            //     //           'MO SALAH CRASHES OUT OF THE AFCON DUE TO INJURY',
            //     //       category: 'Sports',
            //     //     ),
            //     //     SizedBox(
            //     //       width: 30.0,
            //     //     ),
            //     //     NewsCard(
            //     //       imagepath:
            //     //           'https://e0.365dm.com/21/01/2048x1152/skysports-rod-laver-arena-australian-open_5254947.jpg?20210130071317',
            //     //       title: 'WIMBLEDON TENNIS FINAL CLASH',
            //     //       category: 'Sports',
            //     //     ),
            //     //   ],
            //     // ),
            //   ),
            // ),
            const SizedBox(
              height: 18.0,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CategoryCard(category: 'All'),
                    SizedBox(
                      width: 10.0,
                    ),
                    CategoryCard(category: 'Politics'),
                    SizedBox(
                      width: 10.0,
                    ),
                    CategoryCard(category: 'Sports'),
                    SizedBox(
                      width: 10.0,
                    ),
                    CategoryCard(category: 'Education'),
                    SizedBox(
                      width: 10.0,
                    ),
                    CategoryCard(category: 'Gaming'),
                    SizedBox(
                      width: 10.0,
                    ),
                    CategoryCard(category: 'Socials'),
                  ],
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const RecomForYouPage(),
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
            getArticleList(),
            getArticleList(),
            getArticleList(),
            getArticleList(),
            getArticleList(),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchArticles = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var articles in searchArticles) {
      if (articles.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(articles);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var results = matchQuery[index];
        return ListTile(
          title: Text(results),
        );
      },
    );
  }

  @override
  String get searchFieldLabel => "Let's help you find an article";

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var articles in searchArticles) {
      if (articles.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(articles);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var results = matchQuery[index];
        return ListTile(
          title: Text(results),
        );
      },
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
