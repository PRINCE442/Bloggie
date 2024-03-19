// ignore_for_file: prefer_null_aware_operators

import 'dart:ui';

import 'package:bloggie/Models/NewsList.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/Screens/newsPage.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  const NewsCard(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => NewsPage(article)));
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 20,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  article.newsImage,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.9)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                      child: Text(
                        article.newsTitle,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool selectedColor = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = !selectedColor;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: selectedColor ? Colors.blue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const ImageIcon(
                    AssetImage('Assets/images/ballicon2.jpg'),
                    size: 10.0,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  widget.category,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
