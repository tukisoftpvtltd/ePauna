import '../../bargain/colors.dart';
import 'package:flutter/material.dart';

class CounterOffer extends StatefulWidget {

  final String label;
  final String image;
  final String amount;
  final String star;
  final String service;
  final String counterType;
  final String offer1;
  final String offer2;
  final String offer3;
  final IconData? icon;

   CounterOffer({
    required this.label,
    required this.image,
    required this.amount,
    required this.star,
    required this.service,
    required this.counterType,
    required this.offer1,
    required this.offer2,
    required this.offer3,
    this.icon,
    super.key,
  });

  @override
  State<CounterOffer> createState() => _CounterOfferState();
}

class _CounterOfferState extends State<CounterOffer> with TickerProviderStateMixin {
   
  late AnimationController controller;
   @override
  void initState() {
      // TODO: implement initState
    
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addListener(() {
        setState(() {});
      });
    controller.reverse(from: 1.0);
    super.initState();
  }

  void dispose(){
    // controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: [
          LinearProgressIndicator(
              value: controller?.value,
              semanticsLabel: 'Linear progress indicator',
            ),
          Row(
            children: [
              Container(
                height: widget.counterType =='counter'?90:65 ,
                width: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset(widget.image),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.label,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            widget.amount,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: PrimaryColors.primaryblue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(widget.icon, color: Colors.amber, size: 16),
                                Text(
                                  widget.star,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            Text(
                              '1.1 Km',
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                        Text(
                          widget.service,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey.shade500),
                        ),
                        widget.counterType == 'counter' ?
                        Text(
                          "Offer 1:  "+widget.offer1,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey.shade500),
                        ):Container(),
                        widget.counterType == 'counter' ?
                        Text(
                          "Offer 2:  "+widget.offer2,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey.shade500),
                        ):Container(),
                        widget.counterType == 'counter' ?
                        Text(
                          "Offer 3:  "+ widget.offer3,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey.shade500),
                        ):Container(),
                        
                        
                      ],
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
