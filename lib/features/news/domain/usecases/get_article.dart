import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, String> {
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);
  @override
  Future<DataState<List<ArticleEntity>>> call({String? params}) {
    return _articleRepository.getNewsArticle(params!);
  }
}
