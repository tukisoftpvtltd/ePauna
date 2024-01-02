import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends StatelessWidget {
  const AppData({super.key});

  userId() async {
    String userId = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = await prefs.getString("uid")!;
    return userId;
  }

  username() async {
    String username = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = await prefs.getString("username")!;
    String name = username;
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

dynamic user_id;
DateTime pickedStartDate = DateTime.now();
DateTime pickedEndDate = DateTime.now().add(Duration(days: 1));
getMonth(int mo) {
  List<String> month = [
    "Jan",
    "Feb",
    "March",
    "April",
    "May",
    "June",
    "July",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec"
  ];
  return month[mo - 1];
}

getWeekDay(int day) {
  List<String> weekDay = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thur",
    "Fri",
    "Sat",
    "Sun"
  ];
  return weekDay[day];
}

List<String> searchHistory = [];

List<String> searchHistoryDate = [];
