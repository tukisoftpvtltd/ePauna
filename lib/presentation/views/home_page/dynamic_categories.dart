import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import '/data/models/dynamic_services_model.dart';
import '/logic/services/dynamic_services.dart';
import '../../../data/repository/api/api.dart';
import '../../app_data/colors.dart';
import '../../custom_widgets/serviceCard.dart';
import '../hotel_desc/hotel_description.dart';

class DynamicCategories extends StatefulWidget {
  const DynamicCategories({super.key});

  @override
  State<DynamicCategories> createState() => _DynamicCategoriesState();
}

class _DynamicCategoriesState extends State<DynamicCategories> {
  List<DynamicServicesModel> dynamicService = [];
  DynamicServices services = DynamicServices();
  double baseWidth = 428;

  @override
  void initState() {
    super.initState();
    services.getDynamicServices().then((value) {
      setState(() {
        dynamicService = value ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dynamicService.length,
        itemBuilder: (context, index) {
          return (dynamicService[index].recods!.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      dynamicService[index].name.toString(),
                      style: TextStyle(
                        wordSpacing: ffem * 3,
                        fontSize: 21 * ffem,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),
                    SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          height: ffem * 265,
                          child: Row(
                            children: List.generate(
                                dynamicService[index].recods!.length, (val) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => hotelDiscription(
                                          rest_ID: dynamicService[index]
                                              .recods![val]
                                              .sid,
                                          category: dynamicService[index]
                                                  .recods![val]
                                                  .categoryName ??
                                              'N/A',
                                        ),
                                      ));
                                },
                                child: ServiceCard(
                                  image: baseUrl +
                                      "/ServiceProviderProfile/" +
                                      dynamicService[index].recods![val].logo!,
                                  index: index,
                                  location: dynamicService[index]
                                          .recods![val]
                                          .address ??
                                      'N/A',
                                  title: dynamicService[index]
                                          .recods![val]
                                          .fullName ??
                                      'N/A',
                                  ffem: ffem,
                                  category: dynamicService[index]
                                      .recods![val]
                                      .categoryName,
                                  maxPrice:
                                      dynamicService[index].recods![val].max,
                                  minPrice:
                                      dynamicService[index].recods![val].min,
                                ),
                              );
                            }),
                          ),
                        ))
                  ],
                )
              : SizedBox.shrink();
        });
  }
}
