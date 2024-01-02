// import 'package:flutter/material.dart';
// import '/presentation/app_data/size.dart';
// import '../../app_data/colors.dart';
// import 'top_destination.dart';

// class MainContainer extends StatefulWidget {
//   const MainContainer({super.key});

//   @override
//   State<MainContainer> createState() => _MainContainerState();
// }

// class _MainContainerState extends State<MainContainer> {
//   @override
//   Widget build(BuildContext context) {
//     AppSize size = AppSize(context: context);
//     return GestureDetector(
//       onTap: FocusManager.instance.primaryFocus?.unfocus,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 7.0),
//               child: Text(
//                 'Top Destination',
//                 style: TextStyle(
//                     wordSpacing: size.ex_small() * 3,
//                     fontSize: 21 * size.ex_small(),
//                     fontWeight: FontWeight.w600,
//                     color: blackColor,
//                     fontFamily: 'Poppins'),
//               ),
//             ),
//             TopDesination(),
//           ],
//         ),
//       ),
//     );
//   }
// }
