import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticle();
}
