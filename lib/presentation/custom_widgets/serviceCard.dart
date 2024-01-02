import 'package:flutter/material.dart';
import 'package:ePauna/bargain/colors.dart';
import 'package:ePauna/presentation/custom_widgets/ratings.dart';
import '../app_data/colors.dart';

class ServiceCard extends StatefulWidget {
  final dynamic index;
  final dynamic image;
  final dynamic title;
  final dynamic location;
  final dynamic ffem;
  final dynamic minPrice;
  final dynamic maxPrice;
  final dynamic category;
  final dynamic ratings;
  const ServiceCard({
    super.key,
    required this.index,
    required this.image,
    required this.title,
    required this.location,
    required this.maxPrice,
    required this.minPrice,
    required this.category,
    required this.ffem,
    this.ratings,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: widget.ffem * 250,
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(width: 0.1, color: greyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  color: appBackgroundColor,
                  // height: 150,
                  width: double.maxFinite,
                  child: FadeInImage.assetNetwork(
                    filterQuality: FilterQuality.high,
                    placeholder: 'assets/images/imageLoader.png',
                    image: widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        ' ${widget.title}',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF276BAE),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' ${widget.category},',
                            style: TextStyle(fontSize: 10),
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            size: 15,
                          ),
                          Flexible(
                            child: Text(
                              widget.location ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 2,
                      height: 4,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: PrimaryColors.primaryblue,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(0.0),
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${widget.ratings ?? 0}',
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '/5',
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: Colors.grey[300],
                              thickness: 2,
                              endIndent: 0,
                              indent: 0,
                            ),
                            Visibility(
                              visible: (widget.minPrice != null ||
                                      widget.maxPrice != null)
                                  ? true
                                  : false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'From: ',
                                    style: TextStyle(
                                        color: blackColor, fontSize: 11),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, right: 3),
                                      child: Text(
                                        "Rs. ${widget.minPrice ?? ""}",
                                        style: TextStyle(
                                            color: PrimaryColors.primaryblue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Container(
              //       color: errorColor,
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 3, right: 3),
              //         child: Text(
              //           "$minPrice-$maxPrice",
              //           style: TextStyle(color: whiteColor, fontSize: 10),
              //         ),
              //       )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
