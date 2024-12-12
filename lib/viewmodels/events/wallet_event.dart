import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchBalance extends WalletEvent {}

class UpdateBalance extends WalletEvent {
  final double newBalance;

  UpdateBalance(this.newBalance);

  @override
  List<Object?> get props => [newBalance];
}
