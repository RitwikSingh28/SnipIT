import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryButtonSelectedEvent extends CategoryEvent {
  final bool isSelected;

  CategoryButtonSelectedEvent(this.isSelected);

  @override
  List<Object> get props => [isSelected];
}

class GetCategoryEvent extends CategoryEvent {}
