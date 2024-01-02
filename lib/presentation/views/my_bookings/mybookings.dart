import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../hotel_desc/hotel_description.dart';
import '/presentation/custom_widgets/savedCard.dart';
import '/cubit/bookings_cubit/bookings_cubit.dart';
import '/cubit/bookings_cubit/bookings_state.dart';
import '/cubit/canceledBooking_cubit/canceled_cubit.dart';
import '/presentation/app_data/colors.dart';
import '/presentation/app_data/size.dart';
import '../../../data/models/bookings.dart';
import '../../../data/urls/urls.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  bool completed = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: whiteColor,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        completed = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: (completed) ? mainColor : whiteColor,
                        foregroundColor: (completed) ? whiteColor : mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: mainColor)),
                    child: Text("Completed"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        completed = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: (completed) ? mainColor : whiteColor,
                        backgroundColor: (completed) ? whiteColor : mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: mainColor)),
                    child: Text("Canceled"),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: completed,
            replacement:
                BlocBuilder<CanceledBookingsCubit, CanceledBookingState>(
              builder: (context, state) {
                if (state is CancelBookingInitial) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (state is CancelBookingLoaded) {
                  return canceledBookings(state.bookings);
                }
                return Center(child: Text('Something went Wrong'));
              },
            ),
            child: BlocBuilder<BookingsCubit, BookingsState>(
              builder: (context, state) {
                if (state is BookingsLoaded) {
                  return bookedPage(state.bookings);
                }
                if (state is BookingsError) {
                  Center(child: Text('Error Loading the Data'));
                }
                return Expanded(
                    child: Center(child: CupertinoActivityIndicator()));
              },
            ),
          )
        ],
      ),
    );
  }

  canceledBookings(List<BookingsModel> bookings) {
    AppSize size = AppSize(context: context);
    return Expanded(
        child: (bookings.isEmpty)
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/images/unavailable.png",
                      ),
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: Text('Not Available'),
                    )
                  ],
                ),
              )
            : RefreshIndicator.adaptive(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1), () {
                   // print("Hello");
                  });
                },
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: bookings.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        // child: CardListing(
                        //   size: size,
                        //   index: index,
                        //   imageUrl: baseUrl +
                        //       "ServiceProviderProfile/" +
                        //       bookings[index].logo,
                        //   fullName: bookings[index].fullName,
                        //   address: bookings[index].address,
                        //   serviceCategory: bookings[index].serviceTitle,
                        //   priceRange: ' ${bookings[index].totalAmount}',
                        //   checkInDate:
                        //       '${bookings[index].checkIn.year}-${bookings[index].checkIn.month}-${bookings[index].checkIn.day}',
                        //   checkOutDate:
                        //       '${bookings[index].checkOut.year}-${bookings[index].checkOut.month}-${bookings[index].checkOut.day}',
                        // ),
                      );
                    }),
              ));
  }

  bookedPage(List<BookingsModel> bookings) {
    AppSize size = AppSize(context: context);

    return Expanded(
      child: (bookings.isEmpty)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "assets/images/unavailable.png",
                    ),
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: Text('Not Available'))
                ],
              ),
            )
          : RefreshIndicator.adaptive(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {});
              },
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: bookings.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => hotelDiscription(
                                      rest_ID: bookings[index].sid.toString(),
                                      category: bookings[index].serviceTitle,
                                    )));
                      },
                      child: CardListing(
                        ratings: bookings[index].averageRating,
                        size: size,
                        index: index,
                        imageUrl: baseUrl +
                            "ServiceProviderProfile/" +
                            bookings[index].logo,
                        fullName: bookings[index].fullName,
                        address: bookings[index].address,
                        serviceCategory: bookings[index].serviceTitle,
                        priceRange: 'Rs. ${bookings[index].totalAmount}',
                        checkInDate:
                            '${bookings[index].checkIn.year}-${bookings[index].checkIn.month}-${bookings[index].checkIn.day}',
                        checkOutDate:
                            '${bookings[index].checkOut.year}-${bookings[index].checkOut.month}-${bookings[index].checkOut.day}',
                        sId: bookings[index].sid,
                      ),
                    );
                  }),
            ),
    );
  }
}
