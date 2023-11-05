import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail(this.article, {super.key});
  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.all(10),
            child: Text(
              article.title ?? 'NULL',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
          Hero(
            tag: article.urlToImage ?? '1',
            child: CachedNetworkImage(
              imageUrl:
                  article.urlToImage ?? "http://via.placeholder.com/350x150",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.width / 1.2,
              width: double.infinity,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return const CupertinoActivityIndicator();
              },
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      article.publishedAt!.isNotEmpty
                          ? DateFormat.yMMMMEEEEd()
                              .format(DateTime.parse(article.publishedAt!))
                          : 'NULL',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    article.author!.isNotEmpty
                        ? 'Author: ${article.author}'
                        : 'NULL',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.all(10),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: article.description ?? 'NULL',
                  ),
                  TextSpan(
                      text: 'Continue reading',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(article.url!));
                        }),
                ],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // BlocProvider.of<RemoteArticleBloc>(context, listen: false).add();
        },
        child: const Icon(
          Icons.bookmark_add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
