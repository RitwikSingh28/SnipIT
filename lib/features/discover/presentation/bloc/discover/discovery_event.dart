part of 'discovery_bloc.dart';

sealed class DiscoveryEvent extends Equatable {
  const DiscoveryEvent();

  @override
  List<Object> get props => [];
}

class GetDiscoverOptionsEvent extends DiscoveryEvent {}

class SelectUnselectDiscoverOptionEvent extends DiscoveryEvent {
  final String discoverId;
  const SelectUnselectDiscoverOptionEvent({required this.discoverId});
}

class UpdateDiscoverOptionsEvent extends DiscoveryEvent {
  final List<String> discoverIds;
  const UpdateDiscoverOptionsEvent({required this.discoverIds});
}
