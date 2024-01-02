import '../bargain/colors.dart';
import '../bargain/components/appbar.dart';
import '../bargain/components/buttons.dart';
import '../bargain/components/counter.dart';
import 'package:flutter/material.dart';

class CustomerCunter extends StatelessWidget {
  CustomerCunter({super.key});
  

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: PrimaryColors.backgroundcolor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(onpressed: () {
            Navigator.pop(context);
          }),
        ),
        body: SingleChildScrollView(
          child: Container(
                  margin: const EdgeInsets.all(10),
                  color: PrimaryColors.primarywhite,
                  child: Column(
                    children: [
                      CounterOffer2(
                        label: 'Pawan Sigdel',
                        image: 'assets/images/profile.jpg',
                        amount: '4,000',
                        Checked_in: DateTime.now(),
                        Checked_out: DateTime.now(),
                        roomquantity: '1',
                        noofguest: '2',
                        distance: 1.2,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AcceptDecline(
                              onpressed: () {},
                              bgcolor: PrimaryColors.primaryred,
                              label: 'Decline',
                            ),
                            const SizedBox(width: 10),
                            AcceptDecline(
                              onpressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CounterDialogBox();
                                  },
                                );
                              },
                              bgcolor: PrimaryColors.primaryblue,
                              label: 'Counter',
                            ),
                            const SizedBox(width: 10),
                            AcceptDecline(
                              onpressed: () {},
                              bgcolor: PrimaryColors.primarygreen,
                              label: 'Accept',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );   
              }
            
  }


class CounterOffer2 extends StatelessWidget {
  final String label;
  final String image;
  final String amount;
  final DateTime Checked_in;
  final DateTime Checked_out;
  final String? roomquantity;
  final String? noofguest;
  final double? distance;

  const CounterOffer2(
      {required this.label,
      required this.image,
      required this.amount,
      required this.Checked_in,
      required this.Checked_out,
      this.roomquantity,
      this.noofguest,
      super.key,
      this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                ),
                // child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       padding: EdgeInsets.zero,
                //     ),
                child: Image.asset(image),
              ),
              // ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          amount,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: PrimaryColors.primaryblue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Checked In:  ${Checked_in.toString().split(' ')[0]}',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              ),
                              Text('$distance Km',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.green))
                            ],
                          ),
                          Text(
                            'Checked Out:  ${Checked_out.toString().split(' ')[0]}',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey.shade500),
                          ),
                          Text(
                            'Room Quantity: $roomquantity ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey.shade500),
                          ),
                          Text(
                            'No of Guest: $noofguest ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
