import 'package:equatable/equatable.dart';

abstract class TransactionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTransactions extends TransactionsEvent {}

class AddTransaction extends TransactionsEvent {
  final double amount;

  AddTransaction(this.amount);

  @override
  List<Object?> get props => [amount];
}
