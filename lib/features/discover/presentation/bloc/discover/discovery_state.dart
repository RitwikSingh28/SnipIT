part of 'discovery_bloc.dart';

sealed class DiscoveryState extends Equatable {
  const DiscoveryState();

  @override
  List<Object> get props => [];
}

final class DiscoveryInitial extends DiscoveryState {}

class DiscoverOptionsLoadedState extends DiscoveryState {
  final List<DiscoverThemeModel> discoveries;
  const DiscoverOptionsLoadedState({required this.discoveries});
}

class DiscoverOptionUpdatedState extends DiscoveryState {
  final PreferenceResponseModel response;
  const DiscoverOptionUpdatedState({required this.response});
}
