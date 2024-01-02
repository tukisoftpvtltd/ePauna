import 'package:flutter/material.dart';

import 'package:ePauna/bargain/colors.dart';
import 'package:ePauna/presentation/custom_widgets/ratings.dart';
import '../app_data/colors.dart';
import '../app_data/size.dart';

class ResultCard extends StatefulWidget {
  const ResultCard({
    super.key,
    // required this.ffem,
    required this.size,
    required this.index,
    required this.imageUrl,
    required this.fullName,
    required this.address,
    required this.serviceCategory,
    required this.priceRange,
    this.checkInDate,
    this.checkOutDate,
    required this.ratings,
  });

  // final dynamic ffem;
  final AppSize size;
  final int index;
  final dynamic imageUrl;
  final dynamic fullName;
  final dynamic address;
  final dynamic serviceCategory;
  final dynamic priceRange;
  final dynamic checkInDate;
  final dynamic checkOutDate;
  final dynamic ratings;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  double rate = 0.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IntrinsicHeight(
                child: Container(
                  color: textColor.withOpacity(0.2),
                  width: widget.size.width() * 0.17,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/nophoto.jpg',
                    image: widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${widget.fullName}',
                          style: TextStyle(
                              color: PrimaryColors.primaryblue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${widget.serviceCategory}',
                              style: TextStyle(color: blackColor, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: textColor,
                            ),
                            Flexible(
                              child: Text(
                                widget.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: (widget.checkInDate != null) ? true : false,
                        child: Text(
                          " Check In: ${widget.checkInDate}",
                          style: TextStyle(fontSize: 12, color: textColor),
                        ),
                      ),
                      Visibility(
                        visible: (widget.checkOutDate != null) ? true : false,
                        child: Text(
                          " Check Out: ${widget.checkOutDate}",
                          style: TextStyle(fontSize: 12, color: textColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                            Text(
                              '  Average',
                              style: TextStyle(
                                color: PrimaryColors.primaryblue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.grey[300],
                              thickness: 2,
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 1, bottom: 1, left: 8, right: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        'From: ',
                                        style: TextStyle(
                                          color: blackColor,
                                        ),
                                      ),
                                      Text(
                                        widget.priceRange.split('-')[0],
                                        style: TextStyle(
                                            color: PrimaryColors.primaryblue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Spacer()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
