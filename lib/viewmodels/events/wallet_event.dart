import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWalletBalance extends WalletEvent {}

class UpdateWalletBalance extends WalletEvent {
  final double sentAmount;

  UpdateWalletBalance(this.sentAmount);

  @override
  List<Object?> get props => [sentAmount];
}
