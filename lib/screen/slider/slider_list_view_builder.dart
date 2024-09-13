import 'package:flutter/material.dart';
import '../../model/slider_model.dart';
import '../view/categories_view.dart';

class SliderListViewBuilder extends StatelessWidget {
  const SliderListViewBuilder({
    super.key,
    required this.size,
    required this.slider,
  });

  final Size size;
  final List<SliderModel> slider;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: slider.length,
        (context, index) {
          return CategoriesView(
            size: size,
            imageUrl: slider[index].urlToImage,
            title: slider[index].title,
            desc: slider[index].description,
            blogUrl: slider[index].url,
          );
        },
      ),
    );
  }
}
