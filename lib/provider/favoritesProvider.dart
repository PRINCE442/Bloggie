import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloggie/Models/NewsList.dart';

class FavoriteArticleNotifier extends StateNotifier<List<Article>> {
  FavoriteArticleNotifier() : super([]);

  bool getMealFavoriteStatus(Article savenews) {
    final articleIsFavorite = state.contains(savenews);

    if (articleIsFavorite) {
      state = state.where((m) => m.id != savenews.id).toList();
      return false;
    } else {
      state = [...state, savenews];
      return true;
    }
  }
}

final favoriteArticleProvider =
    StateNotifierProvider<FavoriteArticleNotifier, List<Article>>((ref) {
  return FavoriteArticleNotifier();
});
