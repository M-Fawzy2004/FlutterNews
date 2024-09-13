// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screen/webview_screen.dart';

class NewsTileCard extends StatelessWidget {
  const NewsTileCard({
    super.key,
    required this.size,
    required this.title,
    required this.imageUrl,
    required this.desc,
    required this.blogUrl,
  });

  final Size size;
  final String title;
  final String imageUrl;
  final String desc;
  final String blogUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6,
          ),

          // pressing go to WebViewScreen
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: blogUrl),
                ),
              );
            },
            child: Material(
              color: Theme.of(context).colorScheme.secondary,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // images news
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        height: size.height * .12,
                        width: size.width * .30,
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

                    // space width
                    SizedBox(
                      width: size.width * .02,
                    ),

                    // text news => title & subtitle
                    Column(
                      children: [
                        // title news
                        Container(
                          width: size.width * .5,
                          child: Text(
                            maxLines: 2,
                            title,
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        // space height
                        SizedBox(
                          height: size.height * .003,
                        ),

                        // subtitle news
                        Container(
                          width: size.width * .5,
                          child: Text(
                            maxLines: 3,
                            desc,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
