// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mainpage_cubit.dart';

class MainpageState {
  bool searchVisible;
  dynamic result;
  MainpageState({
    required this.searchVisible,
    this.result,
  });
}

class UserData {
  String user_id;
  UserData({
    required this.user_id,
  });
}
