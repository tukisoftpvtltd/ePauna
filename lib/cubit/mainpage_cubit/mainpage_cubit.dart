import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'mainpage_state.dart';

class MainpageCubit extends Cubit<MainpageState> {
  MainpageCubit() : super(MainpageState(searchVisible: false));

  search() {
    emit(MainpageState(searchVisible: true));
  }

  searchEmpty() {
    emit(MainpageState(searchVisible: false));
  }
}

class UserDataCubit extends Cubit<UserData> {
  UserDataCubit() : super(UserData(user_id: ''));

  data() async {
    SharedPreferences user_Id = await SharedPreferences.getInstance();
    var userID = user_Id.getString("UserId")!;
    emit(UserData(user_id: userID));
  }
}
