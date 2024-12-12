import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/home_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/states/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ToggleBalanceVisibility>((event, emit) {
      final currentState = state as HomeInitial;
      emit(HomeInitial(isBalanceHidden: !currentState.isBalanceHidden));
    });
  }
}
