import 'package:flutter/material.dart';

class CustomRowText extends StatelessWidget {
  const CustomRowText({
    super.key,
    required this.title,
    required this.titleView,
    this.onTap,
  });

  final String title;
  final String titleView;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              titleView,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
