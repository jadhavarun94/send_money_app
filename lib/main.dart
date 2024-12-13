import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/models/post_model.dart';
import 'package:send_money_app_assignment/repository/post_repository.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/login_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/post_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/transaction_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/wallet_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/events/home_event.dart';
import 'package:send_money_app_assignment/viewmodels/events/wallet_event.dart';
import 'package:send_money_app_assignment/views/home_page.dart';
import 'package:send_money_app_assignment/views/login_page.dart';
import 'package:send_money_app_assignment/views/post_page.dart';
import 'package:send_money_app_assignment/views/send_money_screen.dart';
import 'package:send_money_app_assignment/views/transaction_history_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


import 'repository/user_repository.dart';
import 'repository/transaction_repository.dart';


void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<Post>('postsBox');


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final TransactionRepository transactionRepository = TransactionRepository();
  final PostRepository postRepository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(userRepository)),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => WalletBloc()..add(LoadWalletBalance())),
        BlocProvider(create: (_) => TransactionsBloc(transactionRepository)),
        BlocProvider(create: (_) => PostBloc(postRepository)),
      ],
      child: MaterialApp(
        title: 'Send Money App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (_) => LoginScreen(),
          '/home': (_) => const HomePage(),
          '/send-money': (_) => SendMoneyScreen(),
          '/transactions': (_) => TransactionHistoryScreen(),
          '/post-page': (_) => const PostScreen(),
        },
      ),
    );
  }
}
