import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List<String> categories;

  @override
  void initState() {
    categories = [
      "Business",
      "Entertainment",
      "General",
      "Health",
      "Science",
      "Sports",
      "Technology"
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteArticleBloc, RemoteArticleState>(
      listener: (context, state) {},
      builder: (BuildContext context, RemoteArticleState state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories
                  .map(
                    (ct) => _singleCategory(
                      ct,
                      active: state.category != null
                          ? state.category!.toLowerCase() == ct.toLowerCase()
                          : false,
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _singleCategory(
    String ct, {
    bool active = false,
  }) {
    return InkWell(
      onTap: () {
        BlocProvider.of<RemoteArticleBloc>(context, listen: false).add(
          GetArticlesEvent(
            category: ct.toLowerCase(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Text(
          ct,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
