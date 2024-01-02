import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ePauna/bargain/MapPage.dart';
import 'package:ePauna/bloc/bargain/bloc/bargain_bloc.dart';

class InputTextField extends StatelessWidget {
  TextEditingController controller;
  final String hinttext;
  final IconData icon;
  InputTextField({
    required this.controller,
    required this.hinttext,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BargainBloc, BargainState>(
      builder: (context, state) {
        Color widgetColor = Colors.grey;
        if (state is BargainErrorState) {
          if (state.errorName == "Location Error" &&
              hinttext == 'Select your Location') {
            widgetColor = Colors.red;
          } else if (state.errorName == "Rate Error" && hinttext == 'Rate') {
            widgetColor = Colors.red;
          } else {
            widgetColor = Colors.grey;
          }
        }
        return Container(
          height: 55,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            border:
                Border.all(color: widgetColor), // Change the border color here
            borderRadius: BorderRadius.circular(
                10.0), // You can adjust the border radius as well
          ),
          child: TextField(
              controller: controller,
              readOnly: hinttext == 'Select your Location' ? true : false,
              decoration: InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                prefixIcon: Icon(icon),
                hintText: hinttext,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                ),
                border: InputBorder.none,
              ),
              onTap: () {}),
        );
      },
    );
  }
}
