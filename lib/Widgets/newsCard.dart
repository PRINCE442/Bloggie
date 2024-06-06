// ignore_for_file: prefer_null_aware_operators

import 'dart:ui';

import 'package:bloggie/Models/NewsList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/Screens/newsPage.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  const NewsCard(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    if (article.media.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NewsPage(article)));
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            height: 75,
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
                    article.media,
                    fit: BoxFit.cover,
                    height: 100,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container();
                    },
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
                            fontSize: 15,
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
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
    this.initialCategory,
  }) : super(key: key);

  final String category;
  final Function() onTap;
  final String? initialCategory;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  static final ValueNotifier<String?> _selectedCategory =
      ValueNotifier<String?>(null);
  late String _initialCategory;

  _CategoryCardState({String? initialCategory}) {
    _initialCategory = initialCategory ?? 'News';
    _selectedCategory.value = _initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _selectedCategory,
      builder: (context, selectedCategory, child) {
        final isSelected = selectedCategory == widget.category;
        return GestureDetector(
          onTap: () {
            _selectedCategory.value = isSelected ? null : widget.category;
            if (!isSelected) {
              widget.onTap();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade200,
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
                    const ImageIcon(
                      AssetImage('Assets/images/ballicon2.jpg'),
                      size: 10.0,
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
      },
    );
  }
}
