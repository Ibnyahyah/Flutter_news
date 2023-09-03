import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';

import '../widgets/article_tile.dart';
import '../widgets/categories.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<void> _onRefresh() async {
    return BlocProvider.of<RemoteArticleBloc>(context, listen: false)
        .add(GetArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          children: [
            Categories(),
            Expanded(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      toolbarHeight: 70,
      title: const Text('News'),
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark, color: Colors.amber),
          onPressed: () {},
        ),
      ],
    );
  }

  _buildBody(context) {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return Center(
            child: InkWell(
              onTap: () {
                BlocProvider.of<RemoteArticleBloc>(context, listen: false).add(
                  GetArticlesEvent(),
                );
              },
              child: const Icon(Icons.refresh),
            ),
          );
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) =>
                state.articles![index].title!.isNotEmpty &&
                        state.articles![index].urlToImage!.isNotEmpty
                    ? ArticleTile(state.articles![index])
                    : const SizedBox.shrink(),
            itemCount: state.articles!.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
