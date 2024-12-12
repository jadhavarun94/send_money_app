import 'package:equatable/equatable.dart';

abstract class WalletState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoaded extends WalletState {
  final double balance;

  WalletLoaded(this.balance);

  @override
  List<Object?> get props => [balance];
}

class WalletError extends WalletState {
  final String message;

  WalletError(this.message);

  @override
  List<Object?> get props => [message];
}
