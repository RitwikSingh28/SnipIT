import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/features/feed/domain/usecases/get_preference_usecase.dart';
import 'package:snipit/utils/overlay-manager.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetPreferenceUseCase getPreferenceUseCase;
  DashboardBloc({required this.getPreferenceUseCase})
      : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
