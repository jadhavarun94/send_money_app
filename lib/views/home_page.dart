import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodels/blocs/home_bloc.dart';
import '../viewmodels/events/home_event.dart';
import '../viewmodels/states/home_state.dart';
import '../viewmodels/blocs/wallet_bloc.dart';
import '../viewmodels/states/wallet_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade400,
        title: const Center(child: Text('Home')),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, walletState) {
                if (walletState is WalletBalanceLoaded) {
                  return BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, homeState) {
                      bool isBalanceVisible = true;

                      if (homeState is HomeInitial) {
                        isBalanceVisible = homeState.isBalanceHidden;
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isBalanceVisible
                                ? "Balance: ${walletState.balance.toStringAsFixed(2)} PHP"
                                : "Balance: ******",
                            style: const TextStyle(fontSize: 24),
                          ),
                          IconButton(
                            onPressed: () {
                              // Dispatch the ToggleBalanceVisibility event
                              context.read<HomeBloc>().add(ToggleBalanceVisibility());
                            },
                            icon: Icon(
                              isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (walletState is WalletError) {
                  return Text(
                    "Error: ${walletState.error}",
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushNamed(context, '/send-money');
              },
              child: const Text('Send Money'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushNamed(context, '/transactions');
              },
              child: const Text('View Transactions'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushNamed(context, '/post-page');
              },
              child: const Text('Offline Support'),
            ),
          ],
        ),
      ),
    );
  }
}
