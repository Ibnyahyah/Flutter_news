import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/news/data/repository/article_repository_implement.dart';
import 'package:news_app/features/news/domain/repository/article_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_article.dart';
import 'package:news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiServices>(NewsApiServices(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImplement(sl()));

  // UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  // Bloc
  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));
}
