import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubit/mainpage_cubit/mainpage_cubit.dart';
import '../../data/user_data/data.dart';
import '../app_data/colors.dart';
import '../app_data/size.dart';
import '../views/home_page/search_result.dart';
import '../views/home_page/search_suggestions_page.dart';

class SearchCard extends StatefulWidget {
  final int searchButtonIndex;
  const SearchCard({super.key, required this.searchButtonIndex});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  String dropdownValue = 'All Catergory';
  FocusNode myFocusNode = FocusNode();
  String search_value = '';
  TextEditingController _searchValue = TextEditingController();
  bool val_hotel = false;
  bool showHintText = true;
  DateTime currentDate = DateTime.now();
  bool visible = false;

  String mainFilter = '0';
  bool dateChanged = false;

  Future<void> navigateSearchPage(BuildContext context, bool isTap) async {
    _searchValue.clear();

    _searchValue.text = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchSuggestions()),
    );

    if (!mounted) return;
  }

  @override
  void dispose() {
    super.dispose();
    _searchValue.dispose();

    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);
    return Card(
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
                  hintText: (widget.searchButtonIndex == 1 && showHintText)
                      ? "Hotels/Resorts"
                      : (widget.searchButtonIndex == 2 && showHintText)
                          ? "Entertainment"
                          : (widget.searchButtonIndex == 3 && showHintText)
                              ? "Tours & Travel"
                              : (widget.searchButtonIndex == 4 && showHintText)
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
                      child: Text(value, style: TextStyle(color: textColor)),
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
                    DateTime? fromYear = await showDatePicker(
                      context: context,
                      initialDate: currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(2300),
                    );
                    if (fromYear != null) {
                      setState(() {
                        pickedStartDate = fromYear;
                        pickedEndDate = pickedStartDate.add(Duration(days: 1));
                      });
                    }
                  },
                  child: Text(
                    "${getWeekDay(pickedStartDate.weekday)}, ${getMonth(pickedStartDate.month)} ${(pickedStartDate.day > 9) ? pickedStartDate.day : '0${pickedStartDate.day}'} ",
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                ),
                Visibility(
                  visible: (widget.searchButtonIndex == 1) ? true : false,
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
                              initialDate: currentDate.add(Duration(days: 1)),
                              firstDate: currentDate.add(Duration(days: 1)),
                              lastDate: DateTime(2300),
                              onDatePickerModeChange: (value) {
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
                  style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                  onPressed: () {
                    {
                      if (_searchValue.text.isNotEmpty) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => MainpageCubit(),
                                  child: SearchResult(
                                    isVisible: visible,
                                    dateChanged: dateChanged,
                                    startDate: pickedStartDate
                                        .toString()
                                        .split(' ')[0],
                                    endDate: dateChanged
                                        ? pickedEndDate.toString().split(' ')[0]
                                        : DateTime.now()
                                            .add(Duration(days: 1))
                                            .toString()
                                            .split(' ')[0],
                                    filter: widget.searchButtonIndex,
                                    search_key: _searchValue.text.trim(),
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
    );
  }
}
