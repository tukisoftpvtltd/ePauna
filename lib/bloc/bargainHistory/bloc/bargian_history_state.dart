part of 'bargian_history_bloc.dart';

@immutable
class BargainHistoryState {}

class BargainHistoryInitial extends BargainHistoryState {}

class BargainHistoryLoadingState extends BargainHistoryState {}

class BargainHistoryLoadedState extends BargainHistoryState {
  List<BargainHistoryModel> model;
   BargainHistoryLoadedState(this.model);
}