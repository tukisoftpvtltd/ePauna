import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:ePauna/bargain/colors.dart';
import 'package:ePauna/bargain/find_room.dart';
import 'package:ePauna/presentation/views/alerts/noBookingAlert.dart';
import 'package:ePauna/presentation/views/alerts/notSignedIn.dart';
import '../../../bloc/bargain/bloc/bargain_bloc.dart';
import '../profile/mainprofile.dart';
import '/bloc/internet_bloc.dart';
import '/cubit/bookings_cubit/bookings_cubit.dart';
import '/cubit/canceledBooking_cubit/canceled_cubit.dart';
import '/data/user_data/data.dart';
import '/presentation/app_data/colors.dart';
import '/presentation/app_data/size.dart';
import '/presentation/internet_lost/error_state.dart';
import '/presentation/internet_lost/not_connection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/internet_state.dart';
import '../../../logic/google_login_api.dart';
import 'mainpage.dart';
import '../my_bookings/mybookings.dart';
import '../saved/saved.dart';
import '../profile/tabforprofile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.index});
  final index;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  bool leading = false;
  late int currentIndex = widget.index ?? 0;

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = await prefs.getString("uid") ?? null;

    setState(() {
      user_id = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);
    // List<dynamic> tabs = [
    //   MainPage(),
    //   (user_id != null)
    //       ? saved(
    //           user_ID: '',
    //         )
    //       : alertDialog(),
    //   MultiBlocProvider(
    //     providers: [
    //       BlocProvider(
    //         create: (context) => BookingsCubit(),
    //       ),
    //       BlocProvider(
    //         create: (context) => CanceledBookingsCubit(),
    //       ),
    //     ],
    //     child: (user_id != null) ? MyBooking() : alertDialog(),
    //   ),
    //   (user_id != null) ? MainProfile() : alertDialog(),
    //   (user_id != null) ? MainPage() : alertDialog(),
    // ];
    final screens = [
      MainPage(),
      // (user_id != null)
      //     ? saved(
      //         user_ID: '',
      //       )
      // : alertDialog(),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookingsCubit(),
          ),
        ],
        child: (user_id != null)
            ? Saved(
                user_ID: user_id,
              )
            : NoBookingAler(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookingsCubit(),
          ),
          BlocProvider(
            create: (context) => CanceledBookingsCubit(),
          ),
        ],
        child: (user_id != null) ? MyBooking() : NoBookingAler(),
      ),
      (user_id != null) ? MainProfile() : NotSignedIn(),
    ];

    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetLostState) {
          return InternetLostScreen();
        }
        if (state is InternetGainedState) {
          return Stack(
            children: [
              Scaffold(
                // resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  elevation: currentIndex > 0 ? 0.5 : 0,
                  backgroundColor: whiteColor,
                  centerTitle: false,
                  leading: (user_id != null)
                      ? currentIndex == 3
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  leading = true;
                                });
                              },
                              icon: Icon(
                                Icons.menu,
                                color: mainColor,
                              ),
                            )
                          : null
                      : null,
                  title: currentIndex == 1
                      ? Text(
                          'Saved',
                          style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 25),
                        )
                      : currentIndex == 2
                          ? Text(
                              'My Bookings',
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                  fontSize: 25),
                            )
                          : currentIndex == 3
                              ? Text(
                                  'My Profile',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      fontSize: 25),
                                )
                              : Text(
                                  'ePauna.com',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      fontSize: 25),
                                ),
                  actions: [
                    (currentIndex == 0)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.notifications_outlined),
                                  iconSize: 30,
                                  color: mainColor,
                                ),
                              ],
                            ),
                          )
                        : (user_id != null && currentIndex == 3)
                            ? IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Logout ?'),
                                          content: Text(
                                              'Are you sure you want to logout ?'),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: mainColor),
                                                onPressed: () async {
                                                  var prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  setState(() {
                                                    prefs.clear();
                                                    user_id = null;
                                                    LoginApi.signOut;
                                                  });
                                                  Navigator.pop(context);
                                                  Navigator.of(context)
                                                      .pushNamed('home');
                                                },
                                                child: Text(
                                                  'Logout',
                                                  style: TextStyle(
                                                      color: whiteColor),
                                                )),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: mainColor),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: whiteColor),
                                                )),
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.logout,
                                  color: mainColor,
                                ))
                            : IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.notifications_outlined),
                                iconSize: 30,
                                color: mainColor,
                              )
                  ],
                ),
                // bottomNavigationBar:
                body: leading ? tabforprofie() : screens[currentIndex],
                // floatingActionButton: CenteredFAB(),
                //  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

                // : screens[currentIndex],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: whiteColor,
                    currentIndex: currentIndex,
                    selectedFontSize: size.ex_small() * 12,
                    unselectedFontSize: 9 * size.ex_small(),
                    unselectedItemColor: blackColor,
                    selectedIconTheme: IconThemeData(fill: 0, color: mainColor),
                    selectedLabelStyle: TextStyle(
                        height: size.ex_small() * 0.6,
                        fontWeight: FontWeight.bold),
                    selectedItemColor: mainColor,
                    items: [
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0, 0, size.small() * 6),
                            child: SvgPicture.asset(
                              "assets/NavigationIcon/search-line.svg",
                              color:
                                  (currentIndex == 0) ? mainColor : blackColor,
                            ),
                          ),
                          label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0, 20, size.small() * 6),
                            child: SvgPicture.asset(
                              "assets/NavigationIcon/heart-line.svg",
                              color:
                                  (currentIndex == 1) ? mainColor : blackColor,
                            ),
                          ),
                          label: 'Saved        '),

                      // BottomNavigationBarItem(
                      // icon: Padding(
                      //   padding:
                      //       EdgeInsets.fromLTRB(0, 0, 0,0),
                      //   child: Container(),
                      // ),
                      // label: ''),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding:
                                EdgeInsets.fromLTRB(20, 0, 0, size.small() * 6),
                            child: SvgPicture.asset(
                              "assets/NavigationIcon/briefcase-line.svg",
                              color:
                                  (currentIndex == 2) ? mainColor : blackColor,
                            ),
                          ),
                          label: "        My Booking"),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, 0, 0, size.small() * 6),
                            child: SvgPicture.asset(
                              "assets/NavigationIcon/profile-line.svg",
                              color:
                                  (currentIndex == 3) ? mainColor : blackColor,
                            ),
                          ),
                          label: 'Profile'),
                    ],
                    onTap: (index) {
                      setState(() {
                        leading = false;
                        currentIndex = index;
                      });
                      if (index == 4) {
                        showDialog(
                            builder: (context) => AlertDialog(
                                  title: const Text('Do you want to Logout?'),
                                  content: Text('We hate to see you leave...'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.clear();
                                        setState(() {
                                          user_id = null;
                                        });
                                        currentIndex = 0;
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                            context: context);
                      } else {
                        setState(() {
                          currentIndex = index;
                        });
                      }
                    },
                  ),
                ],
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("The user id is");
                        print(user_id);
                        if (user_id == null) {
                          Fluttertoast.showToast(
                            msg: "Please login to bargain",
                            toastLength:
                                Toast.LENGTH_SHORT, // Duration of the toast
                            gravity:
                                ToastGravity.BOTTOM, // Position of the toast
                            backgroundColor:
                                Colors.black, // Background color of the toast
                            textColor: Colors.white, // Text color of the toast
                            fontSize: 16.0, // Font size of the toast message
                          );
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => BargainBloc(),
                                    child: FindRoom(),
                                  )));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, 0, 0, MediaQuery.of(context).size.height / 80),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipOval(
                            child: Container(
                                decoration: BoxDecoration(
                                  color: PrimaryColors.primaryblue,
                                  border: Border.all(
                                      color: Color.fromARGB(255, 228, 226, 226),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 60,
                                width: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/handShake.png',
                                  ),
                                )),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return const InternetErrorScreen();
      },
    );
  }
}

class CenteredFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        backgroundColor: PrimaryColors.primaryblue,
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          height: 30,
          width: 30,
          child: Image(
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            image: AssetImage(
              'assets/handShake.png',
            ),
          ),
        ),
      ),
    );
  }
}
