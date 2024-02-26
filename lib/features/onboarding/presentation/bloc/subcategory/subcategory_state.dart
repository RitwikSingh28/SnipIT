import 'package:equatable/equatable.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_response_model.dart';

abstract class SubcategoryState extends Equatable {
  const SubcategoryState();

  @override
  List<Object> get props => [];
}

class SubcategoryInitial extends SubcategoryState {}

class SubcategoryButtonSelectedState extends SubcategoryState {
  final bool isSelected;

  SubcategoryButtonSelectedState({required this.isSelected});

  @override
  List<Object> get props => [isSelected];
}

class SubCategoriesLoadedState extends SubcategoryState {
  final List<SubcategoryModel> subCategoryResponse;
  const SubCategoriesLoadedState({required this.subCategoryResponse});
}

class SubCategoriesErrorState {}
