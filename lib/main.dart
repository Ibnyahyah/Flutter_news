import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/article.dart';
import 'package:news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/app_theme.dart';
import 'features/news/presentation/pages/news.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl()..add(GetArticlesEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News',
        theme: theme(),
        home: const NewsPage(),
      ),
    );
  }
}
