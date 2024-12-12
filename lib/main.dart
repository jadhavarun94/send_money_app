import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/login_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/transaction_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/wallet_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/events/home_event.dart';
import 'package:send_money_app_assignment/views/home_page.dart';
import 'package:send_money_app_assignment/views/login_page.dart';
import 'package:send_money_app_assignment/views/send_money_screen.dart';
import 'package:send_money_app_assignment/views/transaction_history_screen.dart';

import 'repository/user_repository.dart';
import 'repository/transaction_repository.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final TransactionRepository transactionRepository = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(userRepository)),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => WalletBloc(userRepository)),
        BlocProvider(create: (_) => TransactionsBloc(transactionRepository)),
      ],
      child: MaterialApp(
        title: 'Send Money App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (_) => LoginScreen(),
          '/home': (_) => HomeScreen(),
          '/send-money': (_) => SendMoneyScreen(),
          '/transactions': (_) => TransactionHistoryScreen(),
        },
      ),
    );
  }
}
