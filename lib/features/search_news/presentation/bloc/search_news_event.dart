import 'package:equatable/equatable.dart';

abstract class SearchNewsEvent extends Equatable{}

class SearchNews extends SearchNewsEvent{
  final String searchTerm;
  SearchNews({required this.searchTerm});

  @override
  // TODO: implement props
  List<Object?> get props => [searchTerm];
}

class RefreshEvent extends SearchNewsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}