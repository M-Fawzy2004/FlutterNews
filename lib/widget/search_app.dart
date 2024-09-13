import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screen/webview_screen.dart';

import '../model/article_model.dart';
import '../service/news/get_news.dart';

class CustomSearchDelegate extends SearchDelegate {
  // call get news
  final GetNews getNewsService = GetNews();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 18,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // clear input text
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  // back icon
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: getNewsService.getNews(q: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching news'));
        } else if (!snapshot.hasData ||
            (snapshot.data as List<ArticleModel>).isEmpty) {
          return const Center(child: Text('No news found'));
        } else {
          var news = snapshot.data as List<ArticleModel>;
          // return list view builder new card => image & title & subtitle
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return Card(
                color: Theme.of(context).colorScheme.secondary,
                child: ListTile(
                  leading: news[index].urlToImage.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: news[index].urlToImage,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : const Icon(
                          Icons.image,
                          size: 70,
                        ),
                  title: Text(
                    news[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Text(
                    news[index].description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                          url: news[index].url,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'Search for news...',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    } else {
      // use future builder
      return FutureBuilder(
        future: getNewsService.getNews(q: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching news'));
          } else if (!snapshot.hasData ||
              (snapshot.data as List<ArticleModel>).isEmpty) {
            return const Center(child: Text('No suggestions found'));
          } else {
            var suggestions = snapshot.data as List<ArticleModel>;
            // return list view builder new card => image & title & subtitle
            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: ListTile(
                    leading: suggestions[index].urlToImage.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: suggestions[index].urlToImage,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const Icon(
                            Icons.image,
                            size: 50,
                          ),
                    title: Text(
                      suggestions[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      suggestions[index].description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onTap: () {
                      query = suggestions[index].title;
                      showResults(context);
                    },
                  ),
                );
              },
            );
          }
        },
      );
    }
  }
}
