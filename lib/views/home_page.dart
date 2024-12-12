import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/events/home_event.dart';

import '../viewmodels/blocs/home_bloc.dart';
import '../viewmodels/blocs/wallet_bloc.dart';
import '../viewmodels/events/wallet_event.dart';
import '../viewmodels/states/home_state.dart';
import '../viewmodels/states/wallet_state.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WalletBloc>(context).add(FetchBalance());

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade400,
        title: const Center(child:  Text("Home")),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                if (state is WalletLoaded) {
                  return BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, homeState) {
                      bool isBalanceHidden = false;
                      if (homeState is HomeInitial) {
                        isBalanceHidden = homeState.isBalanceHidden;
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         const Text(
                            "Wallet Balance:",
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            children: [
                              Text(
                                isBalanceHidden ? "******" : "${state.balance} PHP",
                                style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(
                                  isBalanceHidden ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(ToggleBalanceVisibility());
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                } else if (state is WalletError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
           const SizedBox(height: 40),
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushNamed(context, '/send-money');
              },
              child: const Text("Send Money"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushNamed(context, '/transactions');
              },
              child: const Text("View Transactions"),
            ),
          ],
        ),
      ),
    );
  }
}
