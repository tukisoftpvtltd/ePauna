import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/internet_bloc.dart';
import '/cubit/transactions_cubit/transaction_cubit.dart';
import '/data/user_data/data.dart';
import '/presentation/app_data/size.dart';
import '/presentation/internet_lost/error_state.dart';
import '/presentation/internet_lost/not_connection.dart';
import '../../../bloc/internet_state.dart';
import '../../../cubit/transactions_cubit/transactions_states.dart';
import '../../../data/models/transactions.dart';
import '../../app_data/colors.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  AppData data = AppData();
  String name = '';

  List tableHeadings = [
    "Total Amount",
    "Date",
    "Name",
    "Transaction Time",
  ];

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  getUsername() async {
    String username = await data.username();
    setState(() {
      name = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetLostState) {
          return InternetLostScreen();
        }
        if (state is InternetGainedState) {
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
                  "Transactions",
                  style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      fontSize: 25),
                ),
              ),
              body: SingleChildScrollView(
                child: BlocBuilder<TransactionsCubit, TransactionsState>(
                  builder: (context, state) {
                    if (state is TransactionsLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is TransactionsLoadedState) {
                      return Container(
                        child: Padding(
                          padding: EdgeInsets.only(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Card(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(15.0),
                              //     child: Row(
                              //       children: [
                              //         Spacer(),
                              //         Container(
                              //           decoration: BoxDecoration(
                              //             color: mainColor,
                              //             borderRadius:
                              //                 BorderRadius.circular(20),
                              //           ),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(2.0),
                              //             child: Icon(
                              //               Icons.person_outline,
                              //               color: whiteColor,
                              //             ),
                              //           ),
                              //         ),
                              //         Padding(
                              //           padding: const EdgeInsets.only(left: 4),
                              //           child: Text(
                              //             '$name',
                              //             overflow: TextOverflow.ellipsis,
                              //             style: TextStyle(
                              //               fontSize: 19 * size.ex_small(),
                              //               fontWeight: FontWeight.w500,
                              //               height: 1.5 *
                              //                   size.ex_small() /
                              //                   size.small(),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Card(
                                child: addTableRow(
                                    ex_small: size.ex_small(),
                                    small: size.small(),
                                    transactions: state.transactions),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Text('An Error Occured !');
                  },
                ),
              ));
        }
        return const InternetErrorScreen();
      },
    );
  }

  addTableRow(
      {required var small,
      required var ex_small,
      required List<TransactionsModel> transactions}) {
    List<TableRow> rows = [];
    for (int i = 0; i <= transactions.length; i++) {
      (i == 0)
          ? rows.add(TableRow(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: appBackgroundColor))),
              children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      "Total Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tableTextColor,
                          fontSize: small * 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      "Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tableTextColor,
                          fontSize: small * 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tableTextColor,
                          fontSize: small * 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Text(
                      "Transaction Time",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tableTextColor,
                          fontSize: small * 15),
                    ),
                  ),
                ]))
          : rows.add(TableRow(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: appBackgroundColor))),
              children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                    child: Text(
                      transactions[i - 1].totalAmount.toString(),
                      style: TextStyle(
                          color: tableTextColor,
                          fontSize: small * 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                    child: Text(
                      '${transactions[i - 1].checkIn.year}-${transactions[i - 1].checkIn.month}-${transactions[i - 1].checkIn.day}',
                      style: TextStyle(
                          color: tableTextColor,
                          fontSize: small * 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                    child: Text(
                      transactions[i - 1].fullName.toString(),
                      style: TextStyle(
                          color: tableTextColor,
                          fontSize: small * 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 12, left: 10, right: 10, bottom: 10),
                    child: Text(
                      "${transactions[i - 1].checkIn.year}/${transactions[i - 1].checkIn.month}/${transactions[i - 1].checkIn.day} - ${transactions[i - 1].checkOut.year}/${transactions[i - 1].checkOut.month}/${transactions[i - 1].checkOut.day}",
                      style: TextStyle(
                          color: tableTextColor,
                          fontSize: small * 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ]));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        defaultColumnWidth: IntrinsicColumnWidth(),
        children: rows,
      ),
    );
  }
}
