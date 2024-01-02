// import 'package:flutter/material.dart';
// import 'package:ePauna/presentation/custom_widgets/shimmer.dart';
// import '../../../data/urls/urls.dart';
// import '../../../data/models/model.dart';
// import '../../../logic/services/services.dart';
// import '../../custom_widgets/serviceCard.dart';
// import '../hotel_desc/hotel_description.dart';

// class TopDesination extends StatefulWidget {
//   const TopDesination({
//     super.key,
//   });

//   @override
//   State<TopDesination> createState() => _TopDesinationState();
// }

// class _TopDesinationState extends State<TopDesination> {
//   List<Model> topDestination = <Model>[];
//   Services services = Services();
//   bool isLoaded_b = false;
//   double baseWidth = 428;

//   @override
//   void initState() {
//     super.initState();
//     services.getHotels(apiUrl: topdestination()).then((top) {
//       setState(() {
//         topDestination = top!;
//         isLoaded_b = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.91;
//     return Visibility(
//       visible: isLoaded_b,
//       replacement: Column(
//         children: [
//           TopDestinationShimmer(),
//           TopDestinationShimmer(),
//         ],
//       ),
//       child: GridView.builder(
//         physics: BouncingScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, childAspectRatio: 90 / 110),
//         itemCount: topDestination.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => hotelDiscription(
//                       rest_ID: topDestination[index].sid,
//                       category: topDestination[index].categoryName ?? 'N/A',
//                     ),
//                   ));
//             },
//             child: ServiceCard(
//                 image:
//                     '${baseUrl + "ServiceProviderProfile/" + topDestination[index].logo!}',
//                 index: index,
//                 location: topDestination[index].address ?? 'N/A',
//                 title: topDestination[index].fullName ?? 'N/A',
//                 ffem: ffem,
//                 category: topDestination[index].categoryName,
//                 maxPrice: topDestination[index].max,
//                 minPrice: topDestination[index].min),
//           );
//         },
//       ),
//     );
//   }
// }
