part of 'bargain_bloc.dart';

@immutable
 class BargainState {}

class BargainInitial extends BargainState {}

class BargainErrorState extends BargainState {
  String errorName ='';
  BargainErrorState(this.errorName);
}

class BargainLoadingState extends BargainState {

}
class BargainNoDataState extends BargainState {

}
class TimerStartedState extends BargainState {

}
class TimerCancelledState extends BargainState {

}