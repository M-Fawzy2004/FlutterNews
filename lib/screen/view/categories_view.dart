// ignore_for_file: avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screen/webview_screen.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
    required this.size,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.blogUrl,
  });

  final Size size;
  final String imageUrl;
  final String title;
  final String desc;
  final String blogUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: blogUrl),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: Material(
          color: Theme.of(context).colorScheme.secondary,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // images news
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    height: size.height * .30,
                    width: double.infinity,
                    errorWidget: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      );
                    },
                  ),
                ),

                // title news
                Text(
                  maxLines: 2,
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),

                // description news
                Text(
                  maxLines: 2,
                  desc,
                  style: TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
