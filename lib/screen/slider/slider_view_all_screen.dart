import 'package:flutter/material.dart';
import 'package:newsapp/screen/slider/slider_list_view_builder.dart';

import '../../model/slider_model.dart';
import '../../service/news/slider_news.dart';
import '../../widget/search_app.dart';

class SliderViewAllScreen extends StatefulWidget {
  const SliderViewAllScreen({super.key});

  @override
  State<SliderViewAllScreen> createState() => _SliderViewAllScreenState();
}

class _SliderViewAllScreenState extends State<SliderViewAllScreen> {
  List<SliderModel> slider = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchSlider();
  }

  // Get news slider API with error handling
  Future<void> fetchSlider() async {
    try {
      GetNewsSlider sliderNews = GetNewsSlider();
      await sliderNews.getNews();
      setState(() {
        slider = sliderNews.slider;
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
            SliderListViewBuilder(
              size: size,
              slider: slider,
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
        'Breaking News',
        style: TextStyle(fontSize: 17, color: Colors.blueAccent),
      ),
      centerTitle: true,
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
