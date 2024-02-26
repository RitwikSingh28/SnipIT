import 'package:equatable/equatable.dart';

class GetMyNewsEntity extends Equatable {
  final int skip;
  final int limit;

  const GetMyNewsEntity({
    this.skip = 0,
    this.limit = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      "skip": skip,
      "limit": limit,
    };
  }

  @override
  List<Object?> get props => [skip, limit];
}