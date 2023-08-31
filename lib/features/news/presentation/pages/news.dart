import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/filter_container.dart';

import '../widgets/article_tile.dart';

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
        child: _buildBody(context),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => _showFilterBox(),
            barrierDismissible: false,
          );
        },
        tooltip: 'Filter News',
        child: const Icon(Icons.filter_alt),
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

  AlertDialog _showFilterBox() {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      content: FilterContainer(),
    );
  }
}
