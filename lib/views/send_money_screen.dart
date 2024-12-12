import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/blocs/transaction_bloc.dart';
import 'package:send_money_app_assignment/viewmodels/events/transaction_event.dart';
import 'package:send_money_app_assignment/viewmodels/states/transaction_state.dart';

class SendMoneyScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade400,
        title: const Text("Send Money"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter amount",
                border: OutlineInputBorder(),
              ),
            ),
           const SizedBox(height: 20),
            BlocListener<TransactionsBloc, TransactionsState>(
              listener: (context, state) {
                if (state is TransactionsLoaded) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Transaction Successful!"),
                    ),
                  );
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    Navigator.pop(context);
                  });

                } else if (state is TransactionsError) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(state.message),
                    ),
                  );
                }
              },
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
                onPressed: () {
                  final amount = double.tryParse(_amountController.text);
                  if (amount != null) {
                    BlocProvider.of<TransactionsBloc>(context)
                        .add(AddTransaction(amount));
                    Future.delayed(const Duration(seconds: 2)).then((value) {
                      Navigator.pop(context);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid amount!")),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
