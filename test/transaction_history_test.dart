import 'package:bloc_test/bloc_test.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/transaction_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app_assignment/repository/transaction_repository.dart';
import 'package:send_money_app_assignment/viewmodels/events/transaction_event.dart';
import 'package:send_money_app_assignment/viewmodels/states/transaction_state.dart';

import 'transaction_history_test.mocks.dart';


@GenerateMocks([TransactionRepository])
void main() {
  late MockTransactionRepository mockTransactionRepository;
  late TransactionsBloc transactionsBloc;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    transactionsBloc = TransactionsBloc(mockTransactionRepository);
  });

  group('TransactionsBloc Tests', () {
    test('initial state is TransactionsInitial', () {
      expect(transactionsBloc.state, TransactionsInitial());
    });

    blocTest<TransactionsBloc, TransactionsState>(
      'emits [TransactionsLoaded] when FetchTransactions is added and succeeds',
      build: () {
        when(mockTransactionRepository.getTransactions())
            .thenAnswer((_) async => [
          {'id': '1', 'amount': 100, 'date': '2023-01-01T12:00:00Z'},
          {'id': '2', 'amount': 200, 'date': '2023-01-02T12:00:00Z'},
        ]);
        return transactionsBloc;
      },
      act: (bloc) => bloc.add(FetchTransactions()),
      expect: () => [
        TransactionsLoaded([
          {'id': '1', 'amount': 100, 'date': '2023-01-01T12:00:00Z'},
          {'id': '2', 'amount': 200, 'date': '2023-01-02T12:00:00Z'},
        ])
      ],
      verify: (_) {
        verify(mockTransactionRepository.getTransactions()).called(1);
      },
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'emits [TransactionsError] when FetchTransactions fails',
      build: () {
        when(mockTransactionRepository.getTransactions())
            .thenThrow(Exception('Failed to fetch transactions'));
        return transactionsBloc;
      },
      act: (bloc) => bloc.add(FetchTransactions()),
      expect: () => [
        TransactionsError('Failed to fetch transactions.')
      ],
      verify: (_) {
        verify(mockTransactionRepository.getTransactions()).called(1);
      },
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'emits [TransactionsLoaded] when AddTransaction is added and succeeds',
      build: () {
        when(mockTransactionRepository.saveTransaction(any))
            .thenAnswer((_) async => true);
        when(mockTransactionRepository.getTransactions())
            .thenAnswer((_) async => [
          {'id': '1', 'amount': 100, 'date': '2023-01-01T12:00:00Z'},
          {'id': '2', 'amount': 200, 'date': '2023-01-02T12:00:00Z'},
          {'id': '3', 'amount': 300, 'date': '2023-01-03T12:00:00Z'},
        ]);
        return transactionsBloc;
      },
      act: (bloc) => bloc.add(AddTransaction(300)),
      expect: () => [
        TransactionsLoaded([
          {'id': '1', 'amount': 100, 'date': '2023-01-01T12:00:00Z'},
          {'id': '2', 'amount': 200, 'date': '2023-01-02T12:00:00Z'},
          {'id': '3', 'amount': 300, 'date': '2023-01-03T12:00:00Z'},
        ])
      ],
      verify: (_) {
        verify(mockTransactionRepository.saveTransaction(any)).called(1);
        verify(mockTransactionRepository.getTransactions()).called(1);
      },
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'emits [TransactionsError] when AddTransaction fails',
      build: () {
        when(mockTransactionRepository.saveTransaction(any))
            .thenThrow(Exception('Failed to add transaction'));
        return transactionsBloc;
      },
      act: (bloc) => bloc.add(AddTransaction(300)),
      expect: () => [
        TransactionsError('Failed to add transaction.')
      ],
      verify: (_) {
        verify(mockTransactionRepository.saveTransaction(any)).called(1);
      },
    );
  });
}
