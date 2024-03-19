import 'package:bloggie/Navigations/BottomTabBar.dart';
import 'package:bloggie/Widgets/newsCard.dart';
import 'package:bloggie/Widgets/recomCard.dart';
import 'package:bloggie/constants.dart';

import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
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
              height: 22.0,
            ),
            getArticleList(),
            getArticleList(),
            getArticleList(),
            getArticleList(),

            // RecomCard(
            //     imagepath:
            //         'https://www.channelstv.com/wp-content/uploads/2024/02/nwabali-1-1.jpg',
            //     author: 'Channels',
            //     category: 'Sports',
            //     newsTitle:
            //         "‘Disappointing End,’ Tearful Nwabali Apologises To Nigerian Fans After AFCON Loss",
            //     authorPic:
            //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5MufvetN3MjDpfScmp-BwI3Idb4IgOy0CYQ&usqp=CAU',
            //     date: DateTime(DateTime.daysPerWeek)),
            // RecomCard(
            //     imagepath:
            //         'https://ichef.bbci.co.uk/news/976/cpsprodpb/D84B/production/_132617355_gettyimages-1235465347.jpg.webp',
            //     author: 'BBC News',
            //     category: 'Politics',
            //     newsTitle:
            //         'Herbert Wigwe: Nigerian bank chief killed in US helicopter crash',
            //     authorPic:
            //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIjXgWZk1TCbW6pKaPu_x0lgTL4mPHxF-RSQ&usqp=CAU',
            //     date: DateTime(DateTime.daysPerWeek)),
            // RecomCard(
            //     imagepath:
            //         'https://ichef.bbci.co.uk/news/976/cpsprodpb/FDEA/production/_132620056_crgettyimages-2003966267.jpg.webp',
            //     author: 'BBC News',
            //     category: 'Entertainment',
            //     newsTitle:
            //         'Usher joined by Alicia Keys and william Shines at Super Bowl half-time show',
            //     authorPic:
            //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIjXgWZk1TCbW6pKaPu_x0lgTL4mPHxF-RSQ&usqp=CAU',
            //     date: DateTime(DateTime.daysPerWeek)),
            // RecomCard(
            //     imagepath:
            //         'https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-1996273368.jpg?q=w_1110,c_fill/f_webp',
            //     author: 'CNN News',
            //     category: 'World',
            //     newsTitle:
            //         'Israeli airstrikes kill more than 100 in Rafah as international alarm mounts over anticipated ground offensive',
            //     authorPic:
            //         'https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/CNN_International_logo.svg/600px-CNN_International_logo.svg.png',
            //     date: DateTime(DateTime.daysPerWeek)),
            // RecomCard(
            //     imagepath:
            //         'https://e0.365dm.com/24/02/1600x900/skysports-raducanu-tennis_6453179.jpg?20240212141159',
            //     author: 'Sky Sports',
            //     category: 'Sports',
            //     newsTitle: 'Emma Raducanu slips to straight sets loss in Qatar',
            //     authorPic:
            //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNKi1PGe69CXH5kdj-OW5R2u1xJuqdr6l-nQ&usqp=CAU',
            //     date: DateTime(DateTime.daysPerWeek)),
          ],
        ),
      ),
    );
  }
}
