// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:newsapp/component/custom_drawer.dart';
import 'package:newsapp/screen/slider/slider_view_all_screen.dart';
import 'package:newsapp/service/category_model_data.dart';
import 'package:newsapp/service/news/get_news.dart';
import 'package:newsapp/service/news/slider_news.dart';
import '../widget/carousel/news_carousel_slider.dart';
import '../component/custom_row_text.dart';
import '../model/article_model.dart';
import '../model/category_model.dart';
import '../model/slider_model.dart';
import '../widget/category/category_card_list_view.dart';
import '../widget/news/new_tile_card_list_view.dart';
import '../widget/search_app.dart';
import 'new_tile_view_all_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  List<SliderModel> slider = [];
  List<ArticleModel> articles = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    fetchSliderData();
    fetchNewsData();
  }

  // Fetch news data
  Future<void> fetchNewsData() async {
    try {
      GetNews newsService = GetNews();
      await newsService.getNews(q: 'general');
      setState(() {
        articles = newsService.news;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error fetching news: $e');
    }
  }

  // Fetch slider data
  Future<void> fetchSliderData() async {
    try {
      GetNewsSlider sliderService = GetNewsSlider();
      await sliderService.getNews();
      setState(() {
        slider = sliderService.slider;
      });
    } catch (e) {
      // Handle error
      print('Error fetching slider: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // build app bar
      appBar: buildAppBar(),
      // custom drawer
      drawer: const CustomDrawer(),
      // home screen body
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : buildContent(size),
    );
  }

  // Build main content
  Widget buildContent(Size size) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Category card list view
        SliverToBoxAdapter(
          child: CategoryCardListView(size: size, categories: categories),
        ),
        buildSpace(size),
        // Breaking News section
        buildSectionTitle('Breaking News!', () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SliderViewAllScreen()),
          );
        }),
        buildSpace(size),
        // News Carousel Slider
        SliverToBoxAdapter(child: NewsCarouselSlider(slider: slider)),
        buildSpace(size),
        // Trending News section
        buildSectionTitle('Trending News!', () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NewTileViewAllScreen()),
          );
        }),
        // News tile card list view
        NewsTileCardListView(childCount: 10, articles: articles, size: size),
      ],
    );
  }

  // Build space
  SliverToBoxAdapter buildSpace(Size size) {
    return SliverToBoxAdapter(
      child: SizedBox(height: size.height * .02),
    );
  }

  // Build section title with "View All"
  SliverToBoxAdapter buildSectionTitle(String title, VoidCallback onTap) {
    return SliverToBoxAdapter(
      child: CustomRowText(title: title, titleView: 'View All', onTap: onTap),
    );
  }

  // Method for building AppBar
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Flutter',
            style: TextStyle(fontSize: 20, color: Colors.grey[800]),
          ),
          const Text(
            'News',
            style: TextStyle(fontSize: 20, color: Colors.blueAccent),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
          icon: const Icon(Icons.search, size: 25),
        ),
      ],
    );
  }
}
