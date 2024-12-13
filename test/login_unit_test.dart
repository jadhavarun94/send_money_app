import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:send_money_app_assignment/viewmodels/blocs/login_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/events/login_event.dart';
import 'package:send_money_app_assignment/viewmodels/states/login_state.dart';
import 'package:send_money_app_assignment/repository/user_repository.dart';
import 'package:send_money_app_assignment/models/user.dart';

import 'login_unit_test.mocks.dart';


@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late LoginBloc loginBloc;

  setUp(() {
    mockUserRepository = MockUserRepository();
    loginBloc = LoginBloc(mockUserRepository);
  });

  group('LoginBloc Tests', () {
    test('initial state is LoginInitial', () {
      expect(loginBloc.state, LoginInitial());
    });
/*
    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login is successful',
      build: () {
        when(mockUserRepository.authenticate(
            user: anyNamed('user')))
            .thenAnswer((_) async => User(userName: 'testuser', password: 'password'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(User(userName: 'testuser', password: 'password'))),
      expect: () => [LoginLoading(), LoginSuccess()],
      verify: (_) {
        verify(mockUserRepository.authenticate(
          user: User(userName: 'testuser', password: 'password'),
        )).called(1);
      },
    );*/

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when login fails due to invalid credentials',
      build: () {
        when(mockUserRepository.authenticate(
            user: anyNamed('user')))
            .thenAnswer((_) async => null);
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(User(userName: 'wrong', password: 'wrong'))),
      expect: () => [LoginLoading(), LoginFailure('Invalid username or password.')],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when login throws an exception',
      build: () {
        when(mockUserRepository.authenticate(
            user: anyNamed('user')))
            .thenThrow(Exception('Network error'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(User(userName: 'error', password: 'error'))),
      expect: () => [LoginLoading(), LoginFailure('An error occurred: Exception: Network error')],
    );
  });
}
