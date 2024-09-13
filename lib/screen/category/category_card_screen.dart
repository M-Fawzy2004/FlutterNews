import 'package:flutter/material.dart';
import '../../model/article_model.dart';
import '../../service/news/get_news.dart';
import '../../widget/search_app.dart';
import 'category_card_list_view_builder.dart';

class CategoryCardScreen extends StatefulWidget {
  const CategoryCardScreen({super.key, required this.name});

  final String name;

  @override
  State<CategoryCardScreen> createState() => _CategoryCardScreenState();
}

class _CategoryCardScreenState extends State<CategoryCardScreen> {
  List<ArticleModel> articles = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  // Get news API with error handling
  Future<void> fetchNews() async {
    try {
      GetNews newsClass = GetNews();
      await newsClass.getNews(q: widget.name);
      setState(() {
        articles = newsClass.news;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to fetch news. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Show loading or error message if present
          if (isLoading)
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 700,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          else if (errorMessage.isNotEmpty)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 700,
                child: Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ),
            )
          else
            CategoryCardListViewBuilder(
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
      title: Text(
        widget.name,
        style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
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
