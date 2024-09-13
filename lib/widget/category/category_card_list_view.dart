import 'package:flutter/material.dart';
import '../../model/category_model.dart';
import 'category_card.dart';

class CategoryCardListView extends StatelessWidget {
  const CategoryCardListView({
    super.key,
    required this.size,
    required this.categories,
  });

  final Size size;
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .09,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryCard(
            title: categories[index].name!,
            image: categories[index].image!,
          );
        },
      ),
    );
  }
}
