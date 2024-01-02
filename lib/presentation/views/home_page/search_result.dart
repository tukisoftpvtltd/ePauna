// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ePauna/presentation/custom_widgets/results_card.dart';
import 'package:ePauna/presentation/custom_widgets/searchShimmer.dart';
import 'package:ePauna/presentation/custom_widgets/search_top_sheet.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import '../../../data/user_data/data.dart';
import '/bloc/internet_bloc.dart';
import '/cubit/mainpage_cubit/mainpage_cubit.dart';
import '../../../data/models/filter_model.dart';
import '/presentation/app_data/size.dart';
import '/data/models/model.dart';
import '/logic/services/services.dart';
import '/presentation/internet_lost/not_connection.dart';
import '../hotel_desc/hotel_description.dart';
import '../../../bloc/internet_state.dart';
import '../../../data/repository/search_filter.dart';
import '../../app_data/colors.dart';
import '../../../data/urls/urls.dart';

class SearchResult extends StatefulWidget {
  final search_key;
  final mainFilter;
  final dynamic filter;
  final String startDate;
  final String endDate;
  final bool dateChanged;
  final bool isVisible;

  const SearchResult(
      {super.key,
      required this.search_key,
      required this.mainFilter,
      required this.startDate,
      required this.endDate,
      required this.filter,
      required this.dateChanged,
      required this.isVisible});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  SearchFilterRepository _filterRepository = SearchFilterRepository();
  bool isCardVisible = false;
  bool _visible = false;
  List<Model> result = [];
  Services services = Services();
  bool priceVal = false;
  List propertyVal = [];
  List pricesVal = [];
  int SelectedOption = -1;
  bool showFilter = false;
  String? filter;
  double baseWidth = 428;
  bool onTopTapped = false;

  List<FilterModel> property = [];
  List filterValue = [];
  List price = [
    "0 to NRP. 1,000",
    "NRP. 1,000 to NRP. 2,000",
    "NRP. 2,000 to NRP. 4,000",
    "NRP. 4,000 to NRP. 7,000",
    "Greater than NRP. 7,000"
  ];

  var priceFilter = '0/0';
  @override
  void initState() {
    getResult();
    getFilterCategory();
    super.initState();
    filterValue.add(widget.filter);
  }

  getResult() {
    if (widget.search_key.isNotEmpty) {
      services
          .getHotels(
              apiUrl:
                  'api/filterServiceProviders/${widget.search_key}/${filter ?? widget.filter}/$priceFilter/${widget.mainFilter}/recommended/${widget.filter}')
          .then((value) {
        print(
            "'api/filterServiceProviders/${widget.search_key}/${filter ?? widget.filter}/$priceFilter/${widget.mainFilter}/recommended/${widget.filter}'");
        setState(() {
          result = value!;
          _visible = true;
        });
      });
    } else if (widget.search_key.isEmpty) {
      BlocProvider.of<MainpageCubit>(context).searchEmpty();
    }
  }

  getFilterCategory() async {
    await _filterRepository.getSearchFilter(widget.filter).then((value) {
      setState(() {
        property = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);

    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetGainedState) {
          return Scaffold(
              backgroundColor: Color(0xFFF0F1F5),
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: mainColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: blackColor,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  var value = await showTopModalSheet<String?>(
                                      context,
                                      SearchTopSheet(
                                        searchButtonIndex: widget.filter,
                                        mainCategoryIndex: widget.mainFilter,
                                      ));

                                  setState(() {});
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        '${widget.search_key} ${getMonth(pickedStartDate.month)} ${(pickedStartDate.day > 9) ? pickedStartDate.day : '0${pickedStartDate.day}'} ',
                                      ),
                                      (widget.filter == 1)
                                          ? Text(
                                              ' - ${getMonth(pickedEndDate.month)} ${(pickedEndDate.day > 9) ? pickedEndDate.day : '0${pickedEndDate.day}'}',
                                            )
                                          : Text(
                                              '',
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  color: whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 15,
                                        right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          result.length > 1
                                              ? "${result.length} Results found"
                                              : "${result.length} Result found",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: blackColor,
                                              fontSize: 17),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showFilter = !showFilter;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.filter_list,
                                              color: blackColor,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              _filter(size, context),
                              SizedBox(
                                height: size.ex_small() * 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Visibility(
                                  visible: _visible,
                                  replacement: Center(
                                      child: Column(
                                    children: [
                                      SearchShimmer(),
                                      SearchShimmer(),
                                      SearchShimmer(),
                                      SearchShimmer(),
                                      SearchShimmer(),
                                    ],
                                  )),
                                  child: (result.length != 0)
                                      ? ListView.builder(
                                          itemCount: result.length,
                                          shrinkWrap: true,
                                          primary: false,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              height: 150,
                                              child: GestureDetector(
                                                onTap: (() {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              hotelDiscription(
                                                                  category:
                                                                      result[index]
                                                                              .categoryName ??
                                                                          'N/A',
                                                                  rest_ID: result[
                                                                          index]
                                                                      .sid)));
                                                }),
                                                child: ResultCard(
                                                    ratings: result[index]
                                                        .averageRating,
                                                    address:
                                                        result[index].address ??
                                                            'N/A',
                                                    imageUrl: baseUrl +
                                                        "ServiceProviderProfile/" +
                                                        "${result[index].logo ?? ""}",
                                                    fullName: result[index]
                                                            .fullName ??
                                                        'N/A',
                                                    index: index,
                                                    priceRange:
                                                        'Rs. ${result[index].min}',
                                                    serviceCategory:
                                                        result[index]
                                                                .categoryName ??
                                                            'N/A',
                                                    size: size),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(child: Text('No result found')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }
        if (state is InternetLostState) {
          return InternetLostScreen();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Visibility _filter(AppSize size, BuildContext context) {
    return Visibility(
      visible: showFilter,
      child: Card(
        child: Container(
          height: size.large() * 0.4,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '    Categories',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: property.length,
                            itemBuilder: (context, index) {
                              for (int i = 0; i < property.length; i++) {
                                (i == widget.filter - 1)
                                    ? propertyVal.add(true)
                                    : propertyVal.add(false);
                              }
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Transform.scale(
                                    scale: 0.7,
                                    child: SizedBox(
                                      height: 25,
                                      child: Checkbox(
                                          value: this.propertyVal[index],
                                          checkColor: blackColor,
                                          activeColor: whiteColor,
                                          onChanged: (value) {
                                            setState(() {
                                              this.propertyVal[index] = value!;
                                              if (value) {
                                                filterValue
                                                    .add(property[index].id);
                                                filter = filterValue
                                                    .toString()
                                                    .replaceAll("[", "")
                                                    .replaceAll("]", "");
                                              } else {
                                                filterValue
                                                    .remove(property[index].id);
                                                filter = (filterValue.isEmpty)
                                                    ? 'noFilter'
                                                    : filterValue
                                                        .toString()
                                                        .replaceAll("[", "")
                                                        .replaceAll("]", "");
                                              }
                                              getResult();
                                            });
                                          }),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      property[index].name.toString(),
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 10),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: VerticalDivider(
                    thickness: 2,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 17),
                          child: Text(
                            'Price Range',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: price.length,
                          itemBuilder: (context, index) {
                            for (int i = 0; i < price.length; i++) {
                              pricesVal.add(false);
                            }
                            return Row(
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: SizedBox(
                                    height: 25,
                                    child: Checkbox(
                                        activeColor: whiteColor,
                                        checkColor: mainColor,
                                        value: index == SelectedOption,
                                        onChanged: (value) {
                                          setState(() {
                                            SelectedOption =
                                                value! ? index : -1;
                                            (value == true)
                                                ? (index == 0)
                                                    ? priceFilter = '0/1000'
                                                    : (index == 1)
                                                        ? priceFilter =
                                                            '1000/2000'
                                                        : (index == 2)
                                                            ? priceFilter =
                                                                '2000/4000'
                                                            : (index == 3)
                                                                ? priceFilter =
                                                                    '4000/7000'
                                                                : (index == 4)
                                                                    ? priceFilter =
                                                                        '7000/100000'
                                                                    : '0/0'
                                                : priceFilter = '0/0';

                                            getResult();
                                          });
                                        }),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    price[index],
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 10),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
