import 'package:send_money_app_assignment/models/user.dart';

class UserRepository {
  final Map<String, dynamic> _user = {
    'username': 'testuser',
    'password': 'password',
    'balance': 5000.00,
  };

  Future<Map<String, dynamic>?> authenticate({
    required User user,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_user['username'] == user.userName && _user['password'] == user.password) {
      return _user;
    }
    return null;
  }

  Future<Map<String, dynamic>> getUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _user;
  }

  Future<void> updateBalance(double newBalance) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _user['balance'] = newBalance;
  }
}
