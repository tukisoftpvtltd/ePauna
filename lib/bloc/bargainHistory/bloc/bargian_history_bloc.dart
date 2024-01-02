import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ePauna/data/repository/bargain_repository/bargainHistoryRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/bargain_history_model.dart';

part 'bargian_history_event.dart';
part 'bargian_history_state.dart';

class BargainHistoryBloc
    extends Bloc<BargainHistoryEvent, BargainHistoryState> {
  BargainHistoryBloc() : super(BargainHistoryInitial()) {
    on<BargainHistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<BargainHistoryLoading>((event, emit) async {
      // TODO: implement event handler
      emit(BargainHistoryLoadingState());
      BargainHistoryRepository repo = new BargainHistoryRepository();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = await prefs.getString("uid")!;
      List<BargainHistoryModel> model = await repo.getBargainHistory(userId);
      emit(BargainHistoryLoadedState(model));
    });
  }
}
