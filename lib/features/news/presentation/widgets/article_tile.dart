import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

import '../pages/news_detail.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile(
    this.article, {
    super.key,
  });

  final ArticleEntity article;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => NewsDetail(article)),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 2.2,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            const SizedBox(width: 20),
            _buildTitleAndDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title ?? 'NULL',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                article.description ?? 'NULL',
                maxLines: 2,
              ),
            ),
          ),
          Text(
            article.publishedAt!.isNotEmpty
                ? DateFormat.yMMMMEEEEd()
                    .format(DateTime.parse(article.publishedAt!))
                : 'NULL',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Container _buildImage(context) {
    return Container(
      height: double.maxFinite,
      width: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: article.urlToImage ?? "http://via.placeholder.com/350x150",
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return const CupertinoActivityIndicator();
          },
          errorWidget: (context, url, error) {
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}
