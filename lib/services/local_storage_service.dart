import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveBalance(double balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('walletBalance', balance);
  }

  Future<double> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('walletBalance') ?? 5000.0;
  }

  Future<void> saveTransactions(List<Map<String, dynamic>> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('transactions', transactions.toString());
  }

  Future<String?> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('transactions');
  }
}
