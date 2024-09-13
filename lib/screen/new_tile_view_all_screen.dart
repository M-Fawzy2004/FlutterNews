import 'package:flutter/material.dart';
import 'package:newsapp/model/article_model.dart';
import 'package:newsapp/screen/category/category_card_list_view_builder.dart';
import 'package:newsapp/service/news/get_news.dart';

import '../widget/search_app.dart';

class NewTileViewAllScreen extends StatefulWidget {
  const NewTileViewAllScreen({super.key});

  @override
  State<NewTileViewAllScreen> createState() => _NewTileViewAllScreenState();
}

class _NewTileViewAllScreenState extends State<NewTileViewAllScreen> {
  List<ArticleModel> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  // get news api
  getNews() async {
    GetNews newsclass = GetNews();
    await newsclass.getNews(q: 'general');
    articles = newsclass.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // is loading (complete)=> circular : CategoryCardListViewBuilder
          isLoading
              ? const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 700,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : CategoryCardListViewBuilder(
                  // childCount: articles.length,
                  size: size,
                  articles: articles,
                ),
        ],
      ),
    );
  }

  // Method AppBar
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: const Text(
        'Trending News',
        style: TextStyle(fontSize: 17, color: Colors.blueAccent),
      ),
      centerTitle: true,
      // add icon search
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
          icon: const Icon(
            Icons.search,
            size: 25,
          ),
        ),
      ],
    );
  }
}
