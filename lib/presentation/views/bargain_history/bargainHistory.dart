import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/bargainHistory/bloc/bargian_history_bloc.dart';
import '../../app_data/colors.dart';

class BargainHistory extends StatefulWidget {
  BargainHistory({super.key});

  @override
  State<BargainHistory> createState() => _BargainHistoryState();
}

class _BargainHistoryState extends State<BargainHistory> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BargainHistoryBloc>(context).add(BargainHistoryLoading());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        centerTitle: true,
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarIconBrightness: Brightness.light,
        //   statusBarColor: mainColor,
        // ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColor,
            )),
        title: Text(
          "Bargain History",
          style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              fontSize: 25),
        ),
      ),
      body: BlocBuilder<BargainHistoryBloc, BargainHistoryState>(
          builder: (context, state) {
        if (state is BargainHistoryLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is BargainHistoryLoadedState) {
          return state.model.length == 0
              ? Container(
                  child: Center(
                      child: Text(
                    "No Bargain History",
                    style: TextStyle(fontSize: 16),
                  )),
                )
              : Container(
                  height: height - 100,
                  color: Colors.white,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.model.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          width: width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Text(
                                    "${state.model[index].checkinDate}",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${state.model[index].fullName}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Rs. ${state.model[index].total}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Number Of Guest : ${state.model[index].noOfGuest}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Status :  ${state.model[index].status == 0 ? "Canceled" : "Accepted"}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: state.model[index].status == 0
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Stay Duration : From ${state.model[index].checkinDate} to \n ${state.model[index].checkoutDate}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                )
                              ]),
                        );
                      }),
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
