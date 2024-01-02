import '../bargain/colors.dart';
import '../bargain/components/appbar.dart';
import '../bargain/components/buttons.dart';
import '../bargain/components/counter.dart';
import 'package:flutter/material.dart';

class CustomerCounter2 extends StatefulWidget {
  CustomerCounter2({super.key});

  @override
  State<CustomerCounter2> createState() => _CustomerCounter2State();
}

class _CustomerCounter2State extends State<CustomerCounter2>  with TickerProviderStateMixin {
  List notificationList =[
    {"name":"1"},{"name":"2"},{"name":"3"},{"name":"4"}
  ];

  delete(int index){
    setState(() {
      notificationList.removeAt(index);
    });
    
   // animationControllers.removeAt(index);

  }

  //List<AnimationController> animationControllers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  for (int i = 0; i < notificationList.length; i++) {
    //   // AnimationController controller = AnimationController(
    //   //   vsync: this,
    //   //   duration: Duration(seconds: 30),
    //   // );
    //   if(i==0){
    //      AnimationController controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 60),
    // )..addListener(() {
    //     setState(() {});
    //   });
    //   controller.reverse(from: 1.0);
    //   animationControllers.add(controller);
    //   }
    //   else{
    //   AnimationController controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 30),
    // )..addListener(() {
    //     setState(() {});
    //   });
    //   controller.reverse(from: 1.0);
    //   animationControllers.add(controller);
    // }
    // }

  }
  // List<AnimationController> animationController;
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
            height: screenHeight,
            child: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index){
                return   Container(
                  margin: const EdgeInsets.all(10),
                  color: PrimaryColors.primarywhite,
                  child: Column(
                    children: [
                      // LinearProgressIndicator(
                      //   value: animationControllers[index].value,
                      // ),
                      CounterOffer2(
                        label: notificationList[index]['name'].toString(),
                        image: 'assets/images/profile.jpg',
                        amount: 'Rs. 4,000',
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
                              onpressed: () {
                                delete(index);
                              },
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
                );
              
              }
            ),
          ),
        ),
      ),
    );
  }
}



class CounterOffer2 extends StatefulWidget {
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
  State<CounterOffer2> createState() => _CounterOffer2State();
}

class _CounterOffer2State extends State<CounterOffer2> with TickerProviderStateMixin{
    late AnimationController? controller; 
  @override
  Widget build(BuildContext context) {
    
    void initState(){
       controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addListener(() {
        setState(() {
          
        });
      });
    controller?.reverse(from: 1.0);
    }
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
                child: Image.asset(widget.image),
              ),
              // ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: controller?.value,
                    ),
                    Row(
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
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Checked In:  ${widget.Checked_in.toString().split(' ')[0]}',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              ),
                              Text('${widget.distance} Km',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.green))
                            ],
                          ),
                          Text(
                            'Checked Out:  ${widget.Checked_out.toString().split(' ')[0]}',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey.shade500),
                          ),
                          Text(
                            'Room Quantity: ${widget.roomquantity} ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey.shade500),
                          ),
                          Text(
                            'No of Guest: ${widget.noofguest} ',
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
