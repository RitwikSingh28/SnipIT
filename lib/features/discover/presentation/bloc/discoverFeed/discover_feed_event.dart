part of 'discover_feed_bloc.dart';

sealed class DiscoverFeedEvent extends Equatable {
  const DiscoverFeedEvent();

  @override
  List<Object> get props => [];
}

class GetDiscoverNewsEvent extends DiscoverFeedEvent {}
