import 'package:dartz/dartz.dart';

import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/feed/domain/repositories/feed-repository.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../data/models/add_interaction_response.dart';
import '../entity/interaction_entity.dart';

class AddInteractionUseCase extends UseCase<AddInteractionResponseModel,InteractionEntity>{

  final FeedRepository repository;
  AddInteractionUseCase({required this.repository});

  @override
  Future<Either<Failure, AddInteractionResponseModel>> call(InteractionEntity entity) async{
    // TODO: implement call
    return await repository.addInteraction(entity);
  }

}