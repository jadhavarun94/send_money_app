import 'package:equatable/equatable.dart';
import 'package:send_money_app_assignment/models/user.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final User user;


  LoginSubmitted(this.user);

  @override
  List<Object?> get props => [user];
}
