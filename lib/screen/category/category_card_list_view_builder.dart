import 'package:flutter/cupertino.dart';
import '../../model/article_model.dart';
import '../view/categories_view.dart';

class CategoryCardListViewBuilder extends StatelessWidget {
  const CategoryCardListViewBuilder({
    super.key,
    required this.size,
    required this.articles,
  });

  final Size size;
  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: articles.length,
        (context, index) {
          return CategoriesView(
            size: size,
            imageUrl: articles[index].urlToImage,
            title: articles[index].title,
            desc: articles[index].description,
            blogUrl: articles[index].url,
          );
        },
      ),
    );
  }
}
