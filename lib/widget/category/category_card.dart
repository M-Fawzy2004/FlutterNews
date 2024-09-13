import 'package:flutter/material.dart';
import '../../screen/category/category_card_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    // pressing go to => CategoryCardScreen
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryCardScreen(name: title),
          ),
        );
      },
      // add image && text
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade900,
              shadows: const [
                Shadow(
                  color: Colors.white,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
