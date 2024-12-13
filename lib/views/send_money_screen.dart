import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/transaction_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/events/transaction_event.dart';

import '../viewmodels/blocs/wallet_bloc.dart';
import '../viewmodels/events/wallet_event.dart';

class SendMoneyScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  SendMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade400,
        title: const Center(child: Text('Send Money')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
              onPressed: () {
                final amount = double.tryParse(_amountController.text);
                if (amount != null && amount > 0) {
                  BlocProvider.of<WalletBloc>(context)
                      .add(UpdateWalletBalance(amount));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Transaction Successful!")),
                  );

                  BlocProvider.of<TransactionsBloc>(context)
                      .add(AddTransaction(amount));
                  Future.delayed(const Duration(seconds: 2)).then((value) {
                    Navigator.pop(context);
                   // Navigator.pop(context);
                  });

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid Amount!")),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
