import '/data/models/transactions.dart';

abstract class TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsLoadedState extends TransactionsState {
  final List<TransactionsModel> transactions;

  TransactionsLoadedState(this.transactions);
}

class TransactionsErrorState extends TransactionsState {
  final String error;
  TransactionsErrorState(this.error);
}
