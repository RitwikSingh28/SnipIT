import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:snipit/features/onboarding/domain/entities/get-subcategories-entity.dart';

abstract class SubcategoryEvent extends Equatable {
  const SubcategoryEvent();

  @override
  List<Object> get props => [];
}

class SubcategoryButtonSelectedEvent extends SubcategoryEvent {
  final bool isSelected;

  SubcategoryButtonSelectedEvent(this.isSelected);

  @override
  List<Object> get props => [isSelected];
}

class GetSubCategoryEvent extends SubcategoryEvent {
  final GetSubCategoryEntity entity;
  const GetSubCategoryEvent({required this.entity});
}
