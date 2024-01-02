import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/bargain/bloc/bargain_bloc.dart';
import 'colors.dart';

class CustomeLoader extends StatefulWidget {
  Function callback;
  CustomeLoader({super.key, required this.callback});

  @override
  State<CustomeLoader> createState() => _CustomeLoaderState();
}

class _CustomeLoaderState extends State<CustomeLoader> {
  // Initial value for 1 minute

  @override
  void initState() {
    super.initState();
    // Timer myTimer = Timer(Duration(seconds: 30), () {});
    // BlocProvider.of<BargainBloc>(context).add(StartTimerEvent(myTimer));
    startTimer();
    // showBottomSheet();
  }

   @override
  void dispose() {
    print("Timer disposed");
    myTimer?.cancel();
    super.dispose();
  }
  // void dispose(){
   
    
  //   dispose();

  // }

  int secondsRemaining = 65;
  Timer? myTimer;
   void startTimer() {
    print("the time started");
    myTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
  if (secondsRemaining == 0) {
    timer.cancel();
    setState(() {
      secondsRemaining = 65;
    });
    // BlocProvider.of<BargainBloc>(context).add(CancelTimerEvent(timer));
    BlocProvider.of<BargainBloc>(context).add(BargainNoDataEvent());
    showBottomSheet();
  } else {
    print('here');
    
    setState(() {
      secondsRemaining--;
      print(secondsRemaining.toString() + "remaining");
    });
  }
});

  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = Get.width;
        return Container(
          height: 220,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Didnt find your offer?',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: PrimaryColors.primaryblue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                      onPressed: () {
                        myTimer?.cancel();
                        Navigator.of(context).pop();
                        BlocProvider.of<BargainBloc>(context)
                                          .add(sendData(context));
                      },
                      child: Text(
                        "Get more offer",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: PrimaryColors.primaryred,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                      onPressed: () {
                        myTimer?.cancel();
                        widget.callback();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel Request",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      myTimer?.cancel();
                      BlocProvider.of<BargainBloc>(context)
                          .add(BargainNoDataEvent());
                    },
                    child: Icon(
                      Icons.cancel,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            Center(
                child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      height: 100,
                      width: 100,
                      child: ClipRect(
                        child: Image.asset(
                          'assets/images/animation.gif',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
