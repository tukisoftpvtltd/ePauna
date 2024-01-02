// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable, unused_element, must_be_immutable

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ePauna/presentation/views/booking_page/payment_methods.dart';
import '../../../bargain/payment.dart';
import '/data/user_data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/internet_bloc.dart';
import '/presentation/app_data/size.dart';
import '/presentation/internet_lost/error_state.dart';
import '/presentation/internet_lost/not_connection.dart';
import '../../../bloc/internet_state.dart';
import '../../../data/repository/api/api.dart';
import '../../app_data/colors.dart';

class booking extends StatefulWidget {
  final checkInDate;
  final checkOutDate;
  final category;
  final ServiceRate;
  final ServiceTitle;
  final days;
  final service_Id;
  final serviceCategoryId;
  final imageUrl;
  final businessId;
  final hotelName;

  const booking({
    super.key,
    required this.businessId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.category,
    required this.ServiceRate,
    required this.ServiceTitle,
    required this.days,
    required this.service_Id,
    required this.serviceCategoryId,
    required this.imageUrl,
    required this.hotelName,
  });

  @override
  State<booking> createState() => _bookingState(this.checkInDate,
      this.checkOutDate, this.category, this.ServiceTitle, this.ServiceRate);
}

enum Bookingfor { ForMe, ForSomeoneElse }

class _bookingState extends State<booking> {
  var checkInDate;
  var checkOutDate;
  var category;
  var ServiceRate;
  var ServiceTitle;

  _bookingState(this.checkInDate, this.checkOutDate, this.category,
      this.ServiceTitle, this.ServiceRate);
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController email;
  late TextEditingController phonenumber;
  late TextEditingController guestname;
  late TextEditingController guestemail;
  late TextEditingController guestphone;

  String sessionBookingId = '';
  String reference_ID = '';
  var userId = '';

  bool onlinePayment = false;
  // int? _selectedRadio;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    phonenumber = TextEditingController();
    guestname = TextEditingController();
    guestemail = TextEditingController();
    guestphone = TextEditingController();

    getUserId();
  }

  getUserId() async {
    getUserData(apiType: 'GET', apiUrl: '$baseUrl/api/user/$user_id');
  }

  Bookingfor role = Bookingfor.ForMe;

  @override
  Widget build(BuildContext context) {
    AppData user = AppData();
    AppSize size = AppSize(context: context);
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetLostState) {
          return InternetLostScreen();
        }
        if (state is InternetGainedState) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: appBackgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: whiteColor,
                centerTitle: true,
                // systemOverlayStyle: SystemUiOverlayStyle(
                //   statusBarIconBrightness: Brightness.light,
                //   statusBarColor: mainColor,
                // ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: blackColor,
                    )),
                // title: Padding(
                //   padding: EdgeInsets.only(top: 3, bottom: 3),
                //   child: IntrinsicWidth(
                //     child: Image(
                //       height: size.large() / 10,
                //       image: AssetImage('assets/pauna1-1.png'),
                //       fit: BoxFit.contain,
                //     ),
                //   ),
                // ),
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(
                    size.ex_small() * 20,
                    size.ex_small() * 20,
                    size.ex_small() * 20,
                    size.ex_small() * 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //   Text(
                      //     '$ServiceTitle',
                      //     style: TextStyle(
                      //       fontSize: 20 * size.ex_small(),
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      //   SizedBox(
                      //     height: size.ex_small() * 10,
                      //   ),
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          height: size.small() * 480,
                          child: Container(
                            // decoration: BoxDecoration(
                            //   border:
                            //       Border.all(color: const Color(0x7f7a7c7e)),
                            //   color: const Color(0x66e3e3e3),
                            // ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: size.small() * 180,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/nophoto.jpg',
                                    image: '${widget.imageUrl}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      size.ex_small() * 20,
                                      size.ex_small() * 10,
                                      size.ex_small() * 20,
                                      size.ex_small() * 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$ServiceTitle',
                                        style: TextStyle(
                                          fontSize: 17 * size.ex_small(),
                                          fontWeight: FontWeight.w600,
                                          height: 1.5 *
                                              size.ex_small() /
                                              size.small(),
                                        ),
                                      ),
                                      const Divider(),
                                      Text(
                                        'Days :',

                                        // 'Check In / Check Out :',
                                        style: TextStyle(
                                          fontSize: 17 * size.ex_small(),
                                          fontWeight: FontWeight.w600,
                                          height: 1.5 *
                                              size.ex_small() /
                                              size.small(),
                                        ),
                                      ),
                                      Text(
                                        '${checkInDate.year}-${(checkInDate.month > 9) ? checkInDate.month : '0${checkInDate.month}'}-${(checkInDate.day > 9) ? checkInDate.day : '0${checkInDate.day}'} ${(widget.businessId == "1") ? "/${checkOutDate.year}-${(checkOutDate.month > 9) ? checkOutDate.month : '0${checkOutDate.month}'}-${(checkOutDate.day > 9) ? checkOutDate.day : '0${checkOutDate.day}'}" : ""}',
                                        style: TextStyle(
                                          fontSize: 13 * size.ex_small(),
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff797c7e),
                                        ),
                                      ),
                                      const Divider(),
                                      Text(
                                        (widget.businessId == "1")
                                            ? "Number of Rooms"
                                            : "Service Quantity",
                                        style: TextStyle(
                                          fontSize: 17 * size.ex_small(),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      (widget.businessId == 1)
                                          ? Text(
                                              // '1 Room - 2 Guests can stay',
                                              '${widget.days} ${widget.days > 1 ? 'Rooms' : 'Room'} ',
                                              style: TextStyle(
                                                fontSize: 13 * size.ex_small(),
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff797c7e),
                                              ),
                                            )
                                          : Text("Quantity: ${widget.days}"),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '$ServiceTitle :',
                                            style: TextStyle(
                                              fontSize: 17 * size.ex_small(),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Nrs. $ServiceRate',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 17 * size.ex_small(),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: const Color(0xff7A7C7E)
                                            .withOpacity(0.5),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ' Grand Total  :',
                                            style: TextStyle(
                                              fontSize: 17 * size.ex_small(),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Nrs. ${widget.days * ServiceRate * checkOutDate.difference(checkInDate).inDays}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 17 * size.ex_small(),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15 * size.ex_small(),
                      ),
                      Card(
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: const Color(0xffC3BFBF)),
                        //   color: const Color(0xffE3E3E3).withOpacity(0.4),
                        // ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.ex_small() * 10,
                              size.ex_small() * 15,
                              size.ex_small() * 10,
                              size.ex_small() * 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Fill Your Details :',
                                style: TextStyle(
                                  fontSize: 17 * size.ex_small(),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    textformfieldforfill(
                                      ffem: size.ex_small(),
                                      hint: "First Name",
                                      controller: firstname,
                                      goNext: true,
                                    ),
                                    SizedBox(
                                      height: size.ex_small() * 13,
                                    ),
                                    textformfieldforfill(
                                      ffem: size.ex_small(),
                                      hint: "Last Name",
                                      controller: lastname,
                                      goNext: true,
                                    ),
                                    SizedBox(
                                      height: size.ex_small() * 13,
                                    ),
                                    // textformfieldforfill(
                                    //   ffem: size.ex_small(),
                                    //   hint: "Email",
                                    //   controller: email,
                                    //   goNext: true,
                                    // ),
                                    TextFormField(
                                      validator: ((value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This Field cannot be empty';
                                        }
                                        if (!value.contains('@')) {
                                          return 'Please enter valid email';
                                        }
                                      }),
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      controller: email,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(
                                            size.ex_small() * 10),
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff7A7C7E),
                                            fontSize: 16 * size.ex_small()),
                                        hintText: "Email",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffBDB7B7)),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffBDB7B7)),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      // decoration: InputDecoration(
                                      //   contentPadding: EdgeInsets.all(
                                      //       size.ex_small() * 10),
                                      //   hintStyle: TextStyle(
                                      //       fontWeight: FontWeight.w600,
                                      //       color: const Color(0xff7A7C7E),
                                      //       fontSize: 16 * size.ex_small()),
                                      //   hintText: "Email",
                                      //   enabledBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(
                                      //         color: Color(0xffBDB7B7)),
                                      //     borderRadius:
                                      //         BorderRadius.circular(5.0),
                                      //   ),
                                      //   focusedBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(
                                      //         color: Color(0xffBDB7B7)),
                                      //     borderRadius:
                                      //         BorderRadius.circular(5.0),
                                      //   ),
                                      // ),
                                    ),
                                    SizedBox(
                                      height: size.ex_small() * 13,
                                    ),

                                    // textformfieldforfill(
                                    //   ffem: size.ex_small(),
                                    //   hint: "Phone number",
                                    //   controller: phonenumber,
                                    //   goNext: false,
                                    // ),

                                    TextFormField(
                                      validator: ((value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This Field cannot be empty';
                                        }
                                        if (value.length != 10) {
                                          return 'Please enter valid phone number ';
                                        }
                                      }),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      // textInputAction: TextInputAction.none,
                                      controller: phonenumber,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(
                                            size.ex_small() * 10),
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff7A7C7E),
                                            fontSize: 16 * size.ex_small()),
                                        hintText: "Phone number",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffBDB7B7)),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffBDB7B7)),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      // decoration: InputDecoration(
                                      //   contentPadding: EdgeInsets.all(
                                      //       size.ex_small() * 10),
                                      //   hintStyle: TextStyle(
                                      //       fontWeight: FontWeight.w600,
                                      //       color: const Color(0xff7A7C7E),
                                      //       fontSize: 16 * size.ex_small()),
                                      //   hintText: "Phone number",
                                      //   enabledBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(
                                      //         color: Color(0xffBDB7B7)),
                                      //     borderRadius:
                                      //         BorderRadius.circular(5.0),
                                      //   ),
                                      //   focusedBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(
                                      //         color: Color(0xffBDB7B7)),
                                      //     borderRadius:
                                      //         BorderRadius.circular(5.0),
                                      //   ),
                                      // ),
                                    ),

                                    SizedBox(
                                      height: size.ex_small() * 13,
                                    ),
                                    Text(
                                      'Who Are You Booking For :',
                                      style: TextStyle(
                                        fontSize: 18 * size.ex_small(),
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 *
                                            size.ex_small() /
                                            size.small(),
                                        color: blackColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Transform.translate(
                                              offset: Offset(
                                                  -30 * size.ex_small(), 0),
                                              child: Text(
                                                'For me',
                                                style: TextStyle(
                                                  fontSize:
                                                      15 * size.ex_small(),
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5 *
                                                      size.ex_small() /
                                                      size.small(),
                                                  color: Color(0xff797c7e),
                                                ),
                                              ),
                                            ),
                                            leading: Radio(
                                              value: Bookingfor.ForMe,
                                              groupValue: role,
                                              onChanged: (Bookingfor? value) {
                                                setState(() {
                                                  role = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Transform.translate(
                                              offset: Offset(
                                                  -30 * size.ex_small(), 0),
                                              child: Text(
                                                'For Other',
                                                style: TextStyle(
                                                  fontSize: 15 * size.small(),
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff797c7e),
                                                ),
                                              ),
                                            ),
                                            leading: Radio(
                                              value: Bookingfor.ForSomeoneElse,
                                              groupValue: role,
                                              onChanged: (Bookingfor? value) {
                                                setState(() {
                                                  role = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible:
                                          role == Bookingfor.ForSomeoneElse,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Who Are You Booking For :',
                                            style: TextStyle(
                                              fontSize: 18 * size.ex_small(),
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff797c7e),
                                            ),
                                          ),
                                          textformfieldforfill(
                                            ffem: size.ex_small(),
                                            hint: "Guest Full name",
                                            controller: guestname,
                                            goNext: true,
                                          ),
                                          SizedBox(
                                            height: size.ex_small() * 13,
                                          ),
                                          // textformfieldforfill(
                                          //   ffem: size.ex_small(),
                                          //   hint: " Guest Email",
                                          //   controller: guestemail,
                                          //   goNext: true,
                                          // ),
                                          TextFormField(
                                            validator: ((value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'This Field cannot be empty';
                                              }
                                              if (!value.contains('@')) {
                                                return 'Please enter valid email';
                                              }
                                            }),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            // textInputAction:
                                            //     TextInputAction.next,
                                            controller: guestemail,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(
                                                  size.ex_small() * 10),
                                              hintStyle: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xff7A7C7E),
                                                  fontSize:
                                                      16 * size.ex_small()),
                                              hintText: " Guest Email",
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffBDB7B7)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffBDB7B7)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.ex_small() * 13,
                                          ),
                                          // textformfieldforfill(
                                          //   ffem: size.ex_small(),
                                          //   hint: "Guest Phone number",
                                          //   controller: guestphone,
                                          //   goNext: false,
                                          // ),
                                          TextFormField(
                                            validator: ((value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'This Field cannot be empty';
                                              }
                                              if (value.length != 10) {
                                                return 'Please enter valid phone number ';
                                              }
                                            }),
                                            // keyboardType:
                                            //     TextInputType.number,
                                            // inputFormatters: <TextInputFormatter>[
                                            //   FilteringTextInputFormatter
                                            //       .digitsOnly,
                                            // ],
                                            //
                                            controller: guestphone,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(
                                                  size.ex_small() * 10),
                                              hintStyle: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xff7A7C7E),
                                                  fontSize:
                                                      16 * size.ex_small()),
                                              hintText: 'Guest Phone number',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffBDB7B7)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffBDB7B7)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.ex_small() * 13,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: MaterialButton(
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Map data = {
                                              'CheckIn': '${checkInDate}',
                                              'CheckOut': '${checkOutDate}',
                                              'Discount': 0,
                                              'Email': '${email.text}',
                                              'FirstName': '${firstname.text}',
                                              'Gender': 1,
                                              'GuestEmail':
                                                  '${guestemail.text}',
                                              'GuestFullName':
                                                  '${guestname.text}',
                                              'GuestMobileNumber':
                                                  '${guestphone.text}',
                                              'LastName': lastname.text,
                                              'MobileNumber':
                                                  '${phonenumber.text}',
                                              'Qty': '${widget.days}',
                                              'Rate': '${ServiceRate}',
                                              'ServiceId':
                                                  '${widget.serviceCategoryId}',
                                              'Sid': '${widget.service_Id}',
                                              'TotalAmount': widget.days *
                                                  widget.ServiceRate,
                                              'UserId': user_id
                                            };
                                            dynamic body = json.encode(data);
                                            var response = await http.post(
                                              Uri.parse("$baseUrl/api/booking"),
                                              headers: {
                                                'Content-type':
                                                    'application/json',
                                                'Accept': 'application/json',
                                              },
                                              body: body,
                                            );
                                            if (response.statusCode == 200) {
                                              Map<String, dynamic> data =
                                                  await jsonDecode(
                                                      response.body);
                                              setState(() {
                                                sessionBookingId =
                                                    data['SessionBookingId'];
                                                print(
                                                    "Session Booking Id: $sessionBookingId ");
                                              });
                                              Navigator.pop(context);
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      PaymentMethods(
                                                          sessionBookingName:
                                                              widget
                                                                  .ServiceTitle,
                                                          sessionBookingId:
                                                              sessionBookingId,
                                                          amount: widget.days *
                                                              widget
                                                                  .ServiceRate)));
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            "Pay Now",
                                            style: TextStyle(color: whiteColor),
                                          ),
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
                      SizedBox(
                        height: size.ex_small() * 13,
                      ),
                      SizedBox(
                        height: size.large() * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const InternetErrorScreen();
      },
    );
  }

  // !GetUserData
  Future<dynamic> getUserData(
      {required String apiUrl, required String apiType}) async {
    var headersList = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(apiUrl);
    var req = http.Request(apiType, url);
    req.headers.addAll(headersList);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    final body = jsonDecode(resBody);
    var data = {
      "FirstName": await body['FirstName'],
      "LastName": await body['LastName'],
      "UserId": await body['FirstName'],
      "Email": await body['Email'],
      "Gender": await body['Gender'],
      "MobileNumber": await body['MobileNumber'],
    };
    setState(() {
      // storeUsername(data['FirstName'], data['LastName']);
      firstname.text = data['FirstName'];
      lastname.text = data['LastName'];
      phonenumber.text = data['MobileNumber'] ?? '';
      email.text = data['Email'];
      // gender = data['Gender'];
    });
  }

  Widget _buildSnackBar(Color color, String msg) {
    return SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
  }
}

class textformfieldforfill extends StatelessWidget {
  textformfieldforfill(
      {Key? key,
      required this.ffem,
      required this.controller,
      required this.goNext,
      required this.hint})
      : super(key: key);
  String hint;
  TextEditingController controller;
  final double ffem;
  final bool goNext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return 'This Field cannot be empty';
        }
      }),
      textInputAction: (goNext) ? TextInputAction.next : TextInputAction.go,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(ffem * 10),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: const Color(0xff7A7C7E),
            fontSize: 16 * ffem),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffBDB7B7)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffBDB7B7)),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
