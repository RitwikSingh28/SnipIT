import 'package:equatable/equatable.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryButtonSelectedState extends CategoryState {
  final bool isSelected;
  const CategoryButtonSelectedState({required this.isSelected});
  @override
  List<Object> get props => [isSelected];
}

class CategoryLoadedState extends CategoryState {
  final List<CategoryModel> categories;
  const CategoryLoadedState({required this.categories});
}
