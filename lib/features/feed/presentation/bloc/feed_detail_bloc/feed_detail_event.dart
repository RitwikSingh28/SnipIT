import 'package:snipit/features/feed/domain/entity/interaction_entity.dart';

abstract class FeedDetailEvent{}

class AddInteractionEvent extends FeedDetailEvent{
  InteractionEntity entity;
  AddInteractionEvent({required this.entity});
}