import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app_assignment/models/user.dart';

import '../viewmodels/blocs/login_bloc.dart';
import '../viewmodels/events/login_event.dart';
import '../viewmodels/states/login_state.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade400,
        title:  const Center(child: Text("Login")),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
             const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
             const SizedBox(height: 20),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                      padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                    onPressed: () {
                      final username = _usernameController.text;
                      final password = _passwordController.text;
                      if (username.isNotEmpty && password.isNotEmpty) {
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginSubmitted(User(userName:username ,password:password )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please fill in all fields.")),
                        );
                      }
                    },
                    child: const Text("Login"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
