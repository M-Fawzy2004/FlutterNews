import 'package:flutter/cupertino.dart';
import '../../model/article_model.dart';
import 'news_title_card.dart';

class NewsTileCardListView extends StatelessWidget {
  const NewsTileCardListView({
    super.key,
    required this.articles,
    required this.size,
    this.childCount,
  });

  final List<ArticleModel> articles;
  final Size size;
  final int? childCount;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: childCount,
        (context, index) {
          return NewsTileCard(
            size: size,
            title: articles[index].title,
            imageUrl: articles[index].urlToImage,
            desc: articles[index].description,
            blogUrl: articles[index].url,
          );
        },
      ),
    );
  }
}
