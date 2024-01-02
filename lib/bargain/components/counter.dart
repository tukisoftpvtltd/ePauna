import '../../bargain/colors.dart';
import '../../bargain/components/inputfields.dart';
import '../../bargain/payment.dart';
import 'package:flutter/material.dart';

class CounterDialogBox extends StatelessWidget {
   CounterDialogBox({super.key});
  TextEditingController rateContoller = new TextEditingController();
  TextEditingController offer1Contoller = new TextEditingController();
  TextEditingController offer2Contoller = new TextEditingController();
  TextEditingController offer3Contoller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: PrimaryColors.primarywhite,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 450,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Counter rate :',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.dangerous_rounded,
                      size: 35,
                      color: PrimaryColors.primaryblue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
             InputTextField(
              controller: rateContoller,
              hinttext: 'Rate', icon: Icons.attach_money),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Offers :',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
             InputTextField(controller: offer1Contoller, hinttext: 'offer 1', icon: Icons.clean_hands),
            const SizedBox(height: 10),
             InputTextField(controller: offer2Contoller, hinttext: 'offer 2', icon: Icons.clean_hands),
            const SizedBox(height: 10),
             InputTextField(controller: offer3Contoller, hinttext: 'offer 3', icon: Icons.clean_hands),
            const SizedBox(height: 10),
            Container(
              height: 35,
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColors.primaryblue,
                  alignment: Alignment.centerRight,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const PaymentMethodd();
                    }),
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
