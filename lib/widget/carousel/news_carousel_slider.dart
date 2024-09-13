import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../model/slider_model.dart';
import '../../screen/webview_screen.dart';

class NewsCarouselSlider extends StatefulWidget {
  const NewsCarouselSlider({super.key, required this.slider});

  final List<SliderModel> slider;

  @override
  State<NewsCarouselSlider> createState() => _NewsCarouselSliderState();
}

class _NewsCarouselSliderState extends State<NewsCarouselSlider> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // carousel slider builder
        CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, index, realIndex) {
            String? resImage = widget.slider[index].urlToImage;
            String? resName = widget.slider[index].title;
            String? resUrl = widget.slider[index].url;

            return buildImage(resImage, index, resName, resUrl);
          },
          // add options slider
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),

        // space height
        SizedBox(
          height: MediaQuery.of(context).size.height * .012,
        ),
        // animated smooth indicator => change to index slider
        AnimatedSmoothIndicator(
          count: 5,
          effect: WormEffect(
            dotWidth: 12.0,
            dotHeight: 12.0,
            dotColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          activeIndex: activeIndex,
        ),
      ],
    );
  }

  // Method image && text => slider
  Widget buildImage(String image, int index, String name, String blogUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: blogUrl),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // slider image
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                errorWidget: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error));
                },
              ),
            ),
          ),

          // text bottom slider
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Theme.of(context).colorScheme.tertiary.withOpacity(.7),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 7),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              maxLines: 2,
              name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
