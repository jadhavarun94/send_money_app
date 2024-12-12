class TransactionRepository {
  final List<Map<String, dynamic>> _transactions = [];

  Future<List<Map<String, dynamic>>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _transactions;
  }

  Future<void> saveTransaction(Map<String, dynamic> transaction) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _transactions.add(transaction);
  }
}
