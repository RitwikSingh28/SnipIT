import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryButtonSelectedState extends CategoryState {
  final bool isSelected;

  CategoryButtonSelectedState({required this.isSelected});

  @override
  List<Object> get props => [isSelected];
}