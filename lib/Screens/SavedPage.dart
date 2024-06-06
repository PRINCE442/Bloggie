import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/Navigations/BottomTabBar.dart';
import 'package:bloggie/Widgets/recomCard.dart';
import 'package:bloggie/provider/favoritesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteArticles = ref.watch(favoriteArticleProvider);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 50, 150, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                  'Saved News Article',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          favoriteArticles.isEmpty
              ? const Center(
                  child: Text(
                    'No saved Articles yet!',
                    style: TextStyle(fontSize: 25.0),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoriteArticles.length,
                  itemBuilder: (context, index) {
                    final article = favoriteArticles[index];
                    return RecomCard(article);
                  },
                ),
        ],
      ),
    );
  }
}
