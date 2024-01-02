import '../../bargain/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function()? onpressed;

  const CustomAppBar({
    required this.onpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border(
        bottom: BorderSide(
          width: 1.5,
          color: Colors.grey.shade300,
        ),
      ),
      backgroundColor: PrimaryColors.primarywhite,
      shadowColor: Colors.transparent,
      leading: IconButton(
        onPressed: onpressed,
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 28,
          color: Colors.black,
        ),
      ),
    );
  }
}
