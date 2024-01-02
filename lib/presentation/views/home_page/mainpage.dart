import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ePauna/data/urls/urls.dart';
import 'package:ePauna/presentation/app_data/size.dart';
import 'package:ePauna/presentation/views/home_page/search_result.dart';
import '../../../data/models/model.dart';
import '../../../data/user_data/data.dart';
import '../../../logic/services/services.dart';
import '../../custom_widgets/serviceCard.dart';
import '../../custom_widgets/shimmer.dart';
import '../hotel_desc/hotel_description.dart';
import '/cubit/mainpage_cubit/mainpage_cubit.dart';
import '/presentation/app_data/colors.dart';
import 'search_suggestions_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

String dropdownValue = 'All Catergory';
String mainFilter = '0';
bool firstLoading = true;
List<Model> saved = <Model>[];
bool isLoaded_b = false;

class _MainPageState extends State<MainPage> {
  String search_value = '';
  bool showHintText = true;
  bool isVisible = true;
  int searchButtonIndex = 1;

  List<Model> topDestination = <Model>[];
  Services services = Services();

  double baseWidth = 428;

  DateTime currentDate = DateTime.now();
  bool dateChanged = false;

  TextEditingController _searchValue = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  Future<void> navigateSearchPage(BuildContext context, bool isTap) async {
    _searchValue.clear();

    _searchValue.text = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchSuggestions()),
    );

    if (!mounted) return;
  }

  @override
  void initState() {
    print(firstLoading);
    print(saved);
    firstLoading ? loadData() : null;
    super.initState();
  }

  List<Map<String, dynamic>> data = [
    {
      "image": "assets/images/desc1.png",
      "title": "Budget-Friendly Hotels",
      "description":
          "We understand the value of a good deal without compromising on quality. Our budget-friendly hotels provide comfortable accommodations, convenient amenities, and a welcoming atmosphere."
    },
    {
      "image": "assets/images/desc2.png",
      "title": "Prime Vacation Hotspots",
      "description":
          "Immerse yourself in Nepal's Pinnacle: Majestic Himalayas, Spiritual Cities and Tranquil Wildlife. An enchanting blend of nature, culture, and adventure."
    },
    {
      "image": "assets/images/desc3.png",
      "title": "Family-Friendly Getaways",
      "description":
          "Nepal's Family-Friendly Gateway: Explore captivating landscapes, cultural gems, and adventure, creating cherished memories for all generations."
    },
  ];

  void loadData() {
    services.getHotels(apiUrl: topdestination()).then((top) {
      setState(() {
        topDestination = top!;
        saved = top;
        isLoaded_b = true;
        firstLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchValue.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.91;
    AppSize size = AppSize(context: context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 0), () {
            setState(() {
              firstLoading = true;
              loadData();
            });
          });
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(parent: ClampingScrollPhysics()),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (searchButtonIndex == 1)
                                  ? mainColor
                                  : whiteColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: mainColor),
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            setState(() {
                              searchButtonIndex = 1;
                            });
                          },
                          icon: SizedBox(
                            height: 15,
                            width: 15,
                            child: SvgPicture.asset(
                              "assets/NavigationIcon/hotel-blue.svg",
                              color: (searchButtonIndex == 1)
                                  ? whiteColor
                                  : mainColor,
                            ),
                          ),
                          label: Text(
                            'Hotels',
                            style: TextStyle(
                                color: (searchButtonIndex == 1)
                                    ? whiteColor
                                    : mainColor),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (searchButtonIndex == 2)
                                  ? mainColor
                                  : whiteColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: mainColor),
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            setState(() {
                              searchButtonIndex = 2;
                            });
                          },
                          icon: SizedBox(
                            height: 15,
                            width: 15,
                            child: SvgPicture.asset(
                              "assets/NavigationIcon/entertainment-blue.svg",
                              color: (searchButtonIndex == 2)
                                  ? whiteColor
                                  : mainColor,
                            ),
                          ),
                          label: Text(
                            'Entertainment',
                            style: TextStyle(
                                color: (searchButtonIndex == 2)
                                    ? whiteColor
                                    : mainColor),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (searchButtonIndex == 3)
                                  ? mainColor
                                  : whiteColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: mainColor),
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            setState(() {
                              searchButtonIndex = 3;
                            });
                          },
                          icon: SizedBox(
                            height: 15,
                            width: 15,
                            child: SvgPicture.asset(
                              "assets/NavigationIcon/toursandtravel-blue.svg",
                              color: (searchButtonIndex == 3)
                                  ? whiteColor
                                  : mainColor,
                            ),
                          ),
                          label: Text(
                            'Tours & Travel',
                            style: TextStyle(
                                color: (searchButtonIndex == 3)
                                    ? whiteColor
                                    : mainColor),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (searchButtonIndex == 4)
                                  ? mainColor
                                  : whiteColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: mainColor),
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            setState(() {
                              searchButtonIndex = 4;
                            });
                          },
                          icon: SizedBox(
                            height: 15,
                            width: 15,
                            child: SvgPicture.asset(
                              "assets/NavigationIcon/adventure-white.svg",
                              color: (searchButtonIndex == 4)
                                  ? whiteColor
                                  : mainColor,
                            ),
                          ),
                          label: Text(
                            'Adventure',
                            style: TextStyle(
                                color: (searchButtonIndex == 4)
                                    ? whiteColor
                                    : mainColor),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/NavigationIcon/search-line.svg",
                      width: 25.39,
                      height: 25.39,
                      color: blackColor,
                    ),
                    title: TextFormField(
                      focusNode: myFocusNode,
                      controller: _searchValue,
                      onTap: () {
                        myFocusNode.unfocus();
                        navigateSearchPage(context, true);
                        _searchValue.clear();
                        _searchValue.text.isEmpty
                            ? showHintText = true
                            : showHintText = false;
                      },
                      textDirection: TextDirection.ltr,
                      onChanged: ((value) async {
                        if (value.isEmpty) {
                          BlocProvider.of<MainpageCubit>(context).searchEmpty();
                        }
                        if (value.isNotEmpty) {
                          navigateSearchPage(context, false);
                        }
                      }),
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          hintText: (searchButtonIndex == 1 && showHintText)
                              ? "Hotels/Resorts"
                              : (searchButtonIndex == 2 && showHintText)
                                  ? "Entertainment"
                                  : (searchButtonIndex == 3 && showHintText)
                                      ? "Tours & Travel"
                                      : (searchButtonIndex == 4 && showHintText)
                                          ? "Adventure"
                                          : " ",
                          hintStyle: TextStyle(
                            color: textColor,
                          )),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/NavigationIcon/hotel-line.svg",
                      width: 25.39,
                      height: 25.39,
                      color: blackColor,
                    ),
                    title: SizedBox(
                      width: size.ex_small() * 350,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          isExpanded: true,
                          underline: SizedBox(),
                          items: <String>[
                            'All Catergory',
                            'Property',
                            'Location',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(color: textColor)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              myFocusNode.unfocus();
                              dropdownValue = newValue!;
                              (dropdownValue == 'All Catergory')
                                  ? mainFilter = '0'
                                  : (dropdownValue == 'Property')
                                      ? mainFilter = '1'
                                      : (dropdownValue == 'Location')
                                          ? mainFilter = '2'
                                          : mainFilter = '0';
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/NavigationIcon/calander.svg",
                      width: 25.39,
                      height: 25.39,
                      color: blackColor,
                    ),
                    title: Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            print("Press");
                            DateTime? fromYear = await showDatePicker(
                              context: context,
                              initialDate: currentDate,
                              firstDate: currentDate,
                              lastDate: DateTime(2300),
                            );
                            if (fromYear != null) {
                              print("pressed");
                              setState(() {
                                pickedStartDate = fromYear;
                                pickedEndDate =
                                    pickedStartDate.add(Duration(days: 1));
                              });
                            }
                          },
                          child: Text(
                            "${getWeekDay(pickedStartDate.weekday)}, ${getMonth(pickedStartDate.month)} ${(pickedStartDate.day > 9) ? pickedStartDate.day : '0${pickedStartDate.day}'} ",
                            style: TextStyle(color: textColor, fontSize: 16),
                          ),
                        ),
                        Visibility(
                          visible: (searchButtonIndex == 1) ? true : false,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "-",
                                style: TextStyle(color: textColor),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    DateTime? toYear = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          currentDate.add(Duration(days: 1)),
                                      firstDate:
                                          currentDate.add(Duration(days: 1)),
                                      lastDate: DateTime(2300),
                                      onDatePickerModeChange: (value) {
                                        print("date changed");
                                        dateChanged = true;
                                      },
                                    );
                                    if (toYear != null) {
                                      setState(() {
                                        dateChanged = true;
                                        pickedEndDate = toYear;
                                      });
                                    }
                                  },
                                  child: dateChanged
                                      ? Text(
                                          "${getWeekDay(pickedEndDate.weekday)}, ${getMonth(pickedEndDate.month)} ${(pickedEndDate.day > 9) ? pickedEndDate.day : '0${pickedEndDate.day}'} ",
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                          ),
                                        )
                                      : Text(
                                          " ${getWeekDay(DateTime.now().add(Duration(days: 1)).weekday)}, ${getMonth(DateTime.now().add(Duration(days: 1)).month)} ${(DateTime.now().add(Duration(days: 1)).day > 9) ? DateTime.now().add(Duration(days: 1)).day : '0${DateTime.now().add(Duration(days: 1)).day}'} ",
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                          ),
                                        ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor),
                          onPressed: () {
                            {
                              if (_searchValue.text.isNotEmpty) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => MainpageCubit(),
                                          child: SearchResult(
                                            isVisible: searchButtonIndex == 2 ||
                                                    searchButtonIndex == 3 ||
                                                    searchButtonIndex == 4
                                                ? false
                                                : true,
                                            dateChanged: dateChanged,
                                            startDate: pickedStartDate
                                                .toString()
                                                .split(' ')[0],
                                            endDate: pickedEndDate
                                                .toString()
                                                .split(' ')[0],
                                            filter: searchButtonIndex,
                                            search_key:
                                                _searchValue.text.trim(),
                                            mainFilter: mainFilter,
                                          ),
                                        )));

                                showHintText = false;
                              }
                              myFocusNode.unfocus();
                            }
                          },
                          child: Text("Search")),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // BlocBuilder<MainpageCubit, MainpageState>(
            //   builder: ((context, state) {
            //     if (state.searchVisible == false) {
            //       return const MainContainer();
            //     }
            //     return Text('Exception Occured');
            //   }),
            // ),
            Container(
              height: 180,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: 280,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: mainColor,
                              width: 0.7,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 0),
                                child: Image.asset('${data[index]['image']}'),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        data[index]['title'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data[index]['description'],
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontFamily: 'Poppins',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            GestureDetector(
              onTap: FocusManager.instance.primaryFocus?.unfocus,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 5),
                      child: Text(
                        'Top Destination',
                        style: TextStyle(
                          wordSpacing: size.ex_small() * 3,
                          fontSize: 21 * size.ex_small(),
                          fontWeight: FontWeight.w600,
                          color: blackColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Visibility(
                        visible: isLoaded_b,
                        replacement: Column(
                          children: [
                            TopDestinationShimmer(),
                            TopDestinationShimmer(),
                          ],
                        ),
                        child: saved.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 90 / 110),
                                itemCount: saved.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                hotelDiscription(
                                              rest_ID: saved[index].sid,
                                              category:
                                                  saved[index].categoryName ??
                                                      'N/A',
                                            ),
                                          ));
                                    },
                                    child: ServiceCard(
                                      ratings: saved[index].averageRating,
                                      image:
                                          '${baseUrl + "ServiceProviderProfile/" + saved[index].logo!}',
                                      index: index,
                                      location: saved[index].address ?? 'N/A',
                                      title: saved[index].fullName ?? 'N/A',
                                      ffem: ffem,
                                      category: saved[index].categoryName,
                                      maxPrice: saved[index].max,
                                      minPrice: saved[index].min,
                                    ),
                                  );
                                },
                              )
                            : GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 90 / 110),
                                itemCount: topDestination.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                hotelDiscription(
                                              rest_ID:
                                                  topDestination[index].sid,
                                              category: topDestination[index]
                                                      .categoryName ??
                                                  'N/A',
                                            ),
                                          ));
                                    },
                                    child: ServiceCard(
                                        ratings:
                                            topDestination[index].averageRating,
                                        image:
                                            '${baseUrl + "ServiceProviderProfile/" + topDestination[index].logo!}',
                                        index: index,
                                        location:
                                            topDestination[index].address ??
                                                'N/A',
                                        title: topDestination[index].fullName ??
                                            'N/A',
                                        ffem: ffem,
                                        category:
                                            topDestination[index].categoryName,
                                        maxPrice: topDestination[index].max,
                                        minPrice: topDestination[index].min),
                                  );
                                },
                              ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }
}
