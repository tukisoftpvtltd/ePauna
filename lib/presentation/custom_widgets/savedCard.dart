import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ePauna/bargain/colors.dart';
import 'package:ePauna/presentation/custom_widgets/ratings.dart';
import '../app_data/colors.dart';
import '../app_data/size.dart';

class CardListing extends StatelessWidget {
  CardListing(
      {super.key,
      // required this.ffem,
      required this.size,
      required this.index,
      required this.ratings,
      required this.imageUrl,
      required this.fullName,
      required this.address,
      required this.serviceCategory,
      required this.priceRange,
      this.checkInDate,
      this.sId,
      this.checkOutDate});

  // final dynamic ffem;
  final AppSize size;
  final int index;
  dynamic sId;
  final dynamic imageUrl;
  final dynamic fullName;
  final dynamic address;
  final dynamic serviceCategory;
  final dynamic priceRange;
  final dynamic checkInDate;
  final dynamic checkOutDate;
  final dynamic ratings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
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
                  width: size.width() * 0.17,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                          '${fullName}',
                          style: TextStyle(
                              color: PrimaryColors.primaryblue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                                address,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${serviceCategory}',
                              style: TextStyle(color: greyColor, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: (checkInDate != null) ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Check In: ${checkInDate}",
                            style: TextStyle(fontSize: 12, color: textColor),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (checkOutDate != null) ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Check Out: ${checkOutDate}",
                            style: TextStyle(fontSize: 12, color: textColor),
                          ),
                        ),
                      ),

                      Divider(
                        color: Colors.grey[300],
                        thickness: 2,
                        height: 4,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 1, left: 8, right: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              priceRange,
                              style: TextStyle(
                                  color: PrimaryColors.primaryblue,
                                  fontWeight: FontWeight.bold),
                            ),
                            IgnorePointer(
                              ignoring: false,
                              child: CustomRatings(
                                rate:
                                    ratings == null ? 0.0 : ratings.toDouble(),
                                size: 26,
                                sId: sId,
                              ),
                            )
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
