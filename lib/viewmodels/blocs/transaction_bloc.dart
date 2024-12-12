import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/repository/transaction_repository.dart';
import 'package:send_money_app_assignment/viewmodels/events/transaction_event.dart';
import 'package:send_money_app_assignment/viewmodels/states/transaction_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository transactionRepository;

  TransactionsBloc(this.transactionRepository) : super(TransactionsInitial()) {
    on<FetchTransactions>((event, emit) async {
      try {
        final transactions = await transactionRepository.getTransactions();
        emit(TransactionsLoaded(transactions));
      } catch (e) {
        emit(TransactionsError("Failed to fetch transactions."));
      }
    });

    on<AddTransaction>((event, emit) async {
      try {
        await transactionRepository.saveTransaction({
          'id': DateTime.now().toString(),
          'amount': event.amount,
          'date': DateTime.now().toIso8601String(),
        });

        // Fetch updated transactions
        final transactions = await transactionRepository.getTransactions();
        emit(TransactionsLoaded(transactions));
      } catch (e) {
        emit(TransactionsError("Failed to add transaction."));
      }
    });
  }
}
