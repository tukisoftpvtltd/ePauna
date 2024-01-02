import '../bargain/colors.dart';
import '../bargain/components/appbar.dart';
import '../bargain/components/buttons.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
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
            width: double.infinity,
            color: PrimaryColors.primarywhite,
            margin: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Text(
                  'Pay Through Different Means',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                PaymentMethod(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodd extends StatefulWidget {
  const PaymentMethodd({super.key});

  @override
  State<PaymentMethodd> createState() => _PaymentMethoddState();
}

class _PaymentMethoddState extends State<PaymentMethodd> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'PAY AT HOTEL',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: Radio(
            value: 'PAY AT HOTEL',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
        ),
        ListTile(
          title: Image.asset(
            'assets/images/esewa.png',
            height: 52,
            alignment: Alignment.centerLeft,
          ),
          leading: Radio(
            value: 'assets/images/esewa.png',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
        ),
        ListTile(
          title: Image.asset(
            'assets/images/khalti.png',
            height: 36,
            alignment: Alignment.centerLeft,
          ),
          leading: Radio(
            value: 'assets/images/khalti.png',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(right: 15, bottom: 20),
          alignment: Alignment.centerRight,
          child: CustomButton(
            onpressed: () {},
            label: 'Submit',
          ),
        )
      ],
    );
  }
}
