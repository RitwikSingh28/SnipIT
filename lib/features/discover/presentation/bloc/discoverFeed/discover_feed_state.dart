part of 'discover_feed_bloc.dart';

sealed class DiscoverFeedState extends Equatable {
  const DiscoverFeedState();

  @override
  List<Object> get props => [];
}

final class DiscoverFeedInitial extends DiscoverFeedState {}

final class DiscoverNewsLoadedState extends DiscoverFeedState {
  final NewsByCategoryResponse response;
  const DiscoverNewsLoadedState({required this.response});
}
