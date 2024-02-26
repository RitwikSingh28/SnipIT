part of 'feed_bloc.dart';

sealed class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class GetPreferencesEvent extends FeedEvent {}


class ChangeCategoryTabEvent extends FeedEvent {
  final int index;
  const ChangeCategoryTabEvent({required this.index});
  @override
  List<Object> get props => [index];
}

class GetNewsByCategoryEvent extends FeedEvent {
  final String category;
  const GetNewsByCategoryEvent({required this.category});
  List<Object> get props => [category];
}

class LikeNewsEvent extends FeedEvent {
  final LikeNewsByIdEntity entity;
  final int newsIndex;
  const LikeNewsEvent({required this.entity, required this.newsIndex});
}

class GetMyNewsEvent extends FeedEvent {}
class GetMyNewsLoadMoreEvent extends FeedEvent {}
