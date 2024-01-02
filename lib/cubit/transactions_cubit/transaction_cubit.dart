import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/transactions_cubit/transactions_states.dart';
import '/data/models/transactions.dart';
import '/data/repository/transactions_repository.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(TransactionsLoadingState()) {
    fetchTransactions();
  }

  TransactionsRepository postRepository = TransactionsRepository();

  void fetchTransactions() async {
    try {
      List<TransactionsModel> transactions =
          await postRepository.fetchTransactions();
      emit(TransactionsLoadedState(transactions));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.unknown) {
        emit(TransactionsErrorState(
            'Can\'t fetch the data, please check your internet connection'));
      } else {
        emit(TransactionsErrorState(ex.type.toString()));
      }
    }
  }
}
