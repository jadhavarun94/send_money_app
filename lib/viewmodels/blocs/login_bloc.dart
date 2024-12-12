import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/models/user.dart';

import '../../repository/user_repository.dart';
import '../events/login_event.dart';
import '../states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc(this.userRepository) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await userRepository.authenticate(user: User(userName: event.user.userName, password: event.user.password),
        );

        if (user != null) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure("Invalid username or password."));
        }
      } catch (e) {
        emit(LoginFailure("An error occurred: ${e.toString()}"));
      }
    });
  }
}
