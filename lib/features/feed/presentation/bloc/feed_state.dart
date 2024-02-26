part of 'feed_bloc.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

final class FeedInitial extends FeedState {}

class PreferencesLoadedState extends FeedState {
  final UserPreferenceModel userPreferenceModel;
  const PreferencesLoadedState({required this.userPreferenceModel});
  @override
  List<Object> get props => [userPreferenceModel];
}

class ChangeNewsTabSuccessState extends FeedState {
  final int index;
  @override
  List<Object> get props => [index];
  const ChangeNewsTabSuccessState({required this.index});
}

class GetNewsSuccessState extends FeedState {
  final List<News> news;
  const GetNewsSuccessState({required this.news});
  @override
  List<Object> get props => [news];
}

class LikeNewsSuccessState extends FeedState {
  final int newsIndex;
  final DateTime timestamp;
  final String newsId;
  /* 
    Including the timestamp in the props list ensures that each instance of LikeNewsSuccessState
    with the same newsIndex is considered distinct. This addition helps differentiate instances
    that may represent the same newsIndex but have different timestamps, preventing them from being
    treated as equal during equality comparisons.
  */
  const LikeNewsSuccessState(
      {required this.newsIndex, required this.timestamp, required this.newsId});

  @override
  List<Object> get props => [newsIndex, timestamp];
}
