import 'package:equatable/equatable.dart';

import '../../../feed/data/models/news_model.dart';

class SearchNewsState extends Equatable{
  String? searchTerm;

  SearchNewsState({this.searchTerm=''});

  @override
  // TODO: implement props
  List<Object?> get props => [];

  SearchNewsState copyWith(String searchTerm){
    return SearchNewsState(searchTerm: searchTerm);
  }
}

class SearchNewsInitialState extends SearchNewsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class SearchQueryInvalidState extends SearchNewsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchNewsLoadingState extends SearchNewsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchNewsSuccessState extends SearchNewsState{
  final List<News> news;

  SearchNewsSuccessState({required this.news});

  @override
  // TODO: implement props
  List<Object?> get props => [news];

}