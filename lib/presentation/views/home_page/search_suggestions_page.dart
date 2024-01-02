import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/data/user_data/data.dart';
import '/presentation/app_data/colors.dart';
import '../../../data/models/search_result_model.dart';
import '../../../data/repository/search_suggestions_repository.dart';

class SearchSuggestions extends StatefulWidget {
  const SearchSuggestions({super.key});

  @override
  State<SearchSuggestions> createState() => SearchSuggestionsState();
}

class SearchSuggestionsState extends State<SearchSuggestions> {
  late TextEditingController searchKey;
  List<SearchResultModel> city = [];
  List<SearchResultModel> propertyname = [];
  bool isSearching = false;

  SearchSuggestionsRepository searchSuggestionsRepository =
      SearchSuggestionsRepository();

  Timer? _debounce;
  String _currentSearchValue = '';

  void _onSearchTextChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _currentSearchValue = value;

    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        isSearching = true;
      });
      search(searchValue: _currentSearchValue);
    });
  }

  void _cancelSearch() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _currentSearchValue = '';
    setState(() {
      isSearching = false;
    });
  }

  @override
  void initState() {
    searchKey = TextEditingController();
    super.initState();
  }

  setHistory(String value) {
    if (!searchHistory.contains(value)) {
      searchHistory.add(value);
      Navigator.pop(context, '${searchKey.text}');
    } else {
      Navigator.pop(context, '${searchKey.text}');
    }
  }

  search({required String searchValue}) {
    Future.delayed(Duration(seconds: 0), () async {
      if (searchValue.length == 0 || searchValue == ' ') {
        city.clear();
        propertyname.clear();

        setState(() {});
      } else {
        print('searchValue: $searchValue');
        await searchSuggestionsRepository
            .fetchSearchSuggestions(searchKey: searchValue)
            .then((value) {
          if (value['status']) {
            setState(() {
              List<dynamic> cityDynamic = value['city'];

              List<dynamic> propertynameDynamic = value['propertyname'];

              city = cityDynamic
                  .map((val) => SearchResultModel.fromJson(val))
                  .toList();

              propertyname = propertynameDynamic
                  .map((val) => SearchResultModel.fromJson(val))
                  .toList();
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Container(
            color: whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: searchKey,
                      onChanged: _onSearchTextChanged,
                      onEditingComplete: _cancelSearch,
                      decoration: InputDecoration(
                          hintText: ' Where are you going ?',
                          prefixIcon: IconButton(
                              onPressed: () {
                                (searchKey.text.isNotEmpty)
                                    ? setHistory(searchKey.text)
                                    : Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: blackColor,
                                size: 18,
                              )),
                          focusColor: blackColor,
                          suffixIcon: Visibility(
                              visible: (searchKey.text != '') ? true : false,
                              child: IconButton(
                                  onPressed: () {
                                    searchKey.clear();
                                  },
                                  icon: Icon(
                                    Icons.highlight_off,
                                    color: textColor,
                                  ))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: blackColor),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    searchHistory.isNotEmpty && !isSearching
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Continue Your Search',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins'),
                                )),
                          )
                        : SizedBox(),
                    isSearching
                        ? SizedBox()
                        : Card(
                            elevation: 0,
                            child: ListView.builder(
                                itemCount: searchHistory.length >= 2
                                    ? 2
                                    : searchHistory.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  // searchHistory =
                                  //     searchHistory.reversed.toList();
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        searchKey.text = searchHistory[index];
                                        Navigator.pop(
                                            context, '${searchKey.text}');
                                        // setHistory(searchHistory[index]);
                                      });
                                    },
                                    leading: Icon(
                                      Icons.schedule,
                                      color: blackColor,
                                    ),
                                    title: Text(
                                      searchHistory[index],
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }),
                          ),
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: city.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchKey.text = city[index].keyword!;
                                      // setHistory(searchHistory[index]);
                                      // Navigator.pop(context, '${searchKey.text}');

                                      setHistory(city[index].keyword!);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(city[index].keyword!),
                                      ),
                                      Divider(
                                        height: 0,
                                        thickness: 1.5,
                                        color: Colors.grey.shade300,
                                      )
                                    ],
                                  ),
                                );
                              }),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: propertyname.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchKey.text =
                                          propertyname[index].keyword!;
                                      setHistory(propertyname[index].keyword!);
                                    });
                                  },
                                  child: ListTile(
                                    title: Text(propertyname[index].keyword!),
                                  ),
                                );
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
