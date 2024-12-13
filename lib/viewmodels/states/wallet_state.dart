import 'package:equatable/equatable.dart';

abstract class WalletState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletBalanceLoaded extends WalletState {
  final double balance;

  WalletBalanceLoaded(this.balance);

  @override
  List<Object?> get props => [balance];
}

class WalletError extends WalletState {
  final String error;

  WalletError(this.error);

  @override
  List<Object?> get props => [error];
}
