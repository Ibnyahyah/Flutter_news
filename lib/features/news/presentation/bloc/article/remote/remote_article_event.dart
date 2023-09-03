part of 'remote_article_bloc.dart';

abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetArticlesEvent extends RemoteArticleEvent {
  final String category;
  GetArticlesEvent({this.category = "general"});
}
