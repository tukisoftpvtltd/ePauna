// ignore_for_file: unused_local_variable, must_be_immutable

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/presentation/app_data/colors.dart';
import '/data/user_data/data.dart';
import '/presentation/app_data/size.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repository/api/api.dart';
import '../../../data/repository/update_password_repository.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({super.key});

  @override
  State<MainProfile> createState() => MainProfileState();
}

bool isSaved = false;
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController cityController = TextEditingController();
int gender = 5;

class MainProfileState extends State<MainProfile> {
  TextEditingController current_password = TextEditingController();
  TextEditingController new_password = TextEditingController();
  UpdatePasswordRepository updatePasswordRepository =
      UpdatePasswordRepository();
  final _formKey = GlobalKey<FormState>();
  var userId = '';

  @override
  void initState() {
    getUserId();

    super.initState();
  }

  getUserId() async {
    userId = await AppData().userId();
    getUserData(apiType: 'GET', apiUrl: '$baseUrl/api/user/$userId');
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Card(
              child: Container(
                decoration: BoxDecoration(color: whiteColor),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(size.small() * 12, size.small() * 15,
                      size.small() * 12, size.small() * 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          // Text(
                          //   'Profile ',
                          //   style: TextStyle(
                          //     fontSize: 20 * size.ex_small(),
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.person_outline,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  (firstNameController.text +
                                      ' ' +
                                      lastNameController.text),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 19 * size.ex_small(),
                                    fontWeight: FontWeight.w500,
                                    height: 1.5 * size.ex_small() / size.small(),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        'User Information :',
                        style: TextStyle(
                          fontSize: 19 * size.ex_small(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: size.ex_small() * 13,
                      ),
                      textformfieldforfill(
                        ffem: size.ex_small(),
                        hint: "First Name",
                        controller: firstNameController,
                      ),
                      SizedBox(
                        height: size.ex_small() * 13,
                      ),
                      textformfieldforfill(
                        ffem: size.ex_small(),
                        hint: "Last Name",
                        controller: lastNameController,
                      ),
                      SizedBox(
                        height: size.ex_small() * 13,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number ';
                            }
                            if (value.length != 10) {
                              return 'Please enter valid phone number ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF4F0F0),
                            contentPadding: EdgeInsets.all(size.ex_small() * 10),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff7A7C7E),
                                fontSize: 16 * size.ex_small()),
                            hintText: 'Phone Number',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffA7A4A4)),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffA7A4A4)),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.ex_small() * 13,
                      ),
                      textformfieldforfill(
                        ffem: size.ex_small(),
                        hint: "Email",
                        controller: emailController,
                      ),
                      SizedBox(
                        height: size.ex_small() * 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = 0;
                              });
                            },
                            child: Container(
                              width: size.ex_small() * 100,
                              height: size.ex_small() * 45,
                              decoration: BoxDecoration(
                                  color: gender == 0 ? Color(0xff276BAE) : null,
                                  border: Border.all(
                                      color: const Color(0xff968B8B), width: 1),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  "Male",
                                  style: TextStyle(
                                      color: gender == 0
                                          ? whiteColor
                                          : Color(0xff968B8B)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.ex_small() * 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = 1;
                              });
                            },
                            child: Container(
                              width: size.ex_small() * 100,
                              height: size.ex_small() * 45,
                              decoration: BoxDecoration(
                                  color: gender == 1 ? mainColor : null,
                                  border: Border.all(
                                      color: const Color(0xff968B8B), width: 1),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  "Female",
                                  style: TextStyle(
                                      color: gender == 1
                                          ? whiteColor
                                          : Color(0xff968B8B)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.ex_small() * 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = 2;
                              });
                            },
                            child: Container(
                              width: size.ex_small() * 100,
                              height: size.ex_small() * 45,
                              decoration: BoxDecoration(
                                  color: gender == 2 ? mainColor : null,
                                  border: Border.all(
                                      color: const Color(0xff968B8B), width: 1),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  "Other",
                                  style: TextStyle(
                                      color: gender == 2
                                          ? whiteColor
                                          : Color(0xff968B8B)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Center(
                                    child: Text(
                                  'Change Password',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold),
                                )),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      textformfieldforfill(
                                        ffem: size.ex_small(),
                                        hint: "Current Password",
                                        controller: current_password,
                                      ),
                                      SizedBox(
                                        height: size.ex_small() * 13,
                                      ),
                                      textformfieldforfill(
                                        lastIndex: true,
                                        ffem: size.ex_small(),
                                        hint: "New Password",
                                        controller: new_password,
                                      ),
                                    ]),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () async {
                                        await updatePasswordRepository
                                            .update(
                                                new_password: new_password.text,
                                                old_password: current_password.text)
                                            .then((value) {
                                          Navigator.pop(context);
                                          new_password.clear;
                                          current_password.clear;
                                          return showDialog(
                                              context: context,
                                              builder: (context) {
                                                return WillPopScope(
                                                  onWillPop: () async {
                                                    return false;
                                                  },
                                                  child: AlertDialog(
                                                    content:
                                                        Text('${value['Message']}'),
                                                    actions: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      mainColor),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text('Ok'))
                                                    ],
                                                  ),
                                                );
                                              });
                                        });
                                        // updateData(
                                        //     apiType: 'PUT',
                                        //     apiUrl:
                                        //         '$baseUrl/api/updatePassword/$userId?OldPassword=${current_password.text}&NewPassword=${new_password.text}');
                                        Navigator.pop(context);
                                      },
                                      child: Text('Update')),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Close'))
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'Do you want to change password ?',
                            style: TextStyle(color: mainColor),
                          )),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              storeUsername(firstNameController.text,
                                  lastNameController.text);
                              updateData(
                                  apiType: 'PUT',
                                  body: {
                                    "FirstName": firstNameController.text,
                                    "LastName": lastNameController.text,
                                    "UserId": userId,
                                    "Email": emailController.text,
                                    "Gender": gender,
                                    "MobileNumber": phoneController.text
                                  },
                                  apiUrl:
                                      'https://pauna.tukisoft.com.np/api/user/$userId');
                            });
                          }
                        },
                        child: Container(
                          width: size.ex_small() * 100,
                          height: size.ex_small() * 45,
                          decoration: BoxDecoration(
                              color: mainColor,
                              border: Border.all(
                                  color: const Color(0xff968B8B), width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              "Save Changes",
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
      storeUsername(data['FirstName'], data['LastName']);
      firstNameController.text = data['FirstName'];
      lastNameController.text = data['LastName'];
      phoneController.text = data['MobileNumber'] ?? '';
      emailController.text = data['Email'] ?? '';
      gender = data['Gender'] ?? '';
    });
  }

  storeUsername(firstname, lastname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", '$firstname $lastname');
  }

  updateData(
      {required String apiUrl, required String apiType, dynamic body}) async {
    var headersList = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(apiUrl);
    var req = await http.put(Uri.parse(apiUrl),
        body: jsonEncode(body), headers: headersList);
    print(req.statusCode);
    print(req.body);
    // emailController.text =;
    (req.statusCode == 200 && EmailValidator.validate(emailController.text))
        ? showDialog(
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async {
                  return await false;
                },
                child: AlertDialog(
                  content: Text('Successfully Updated'),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pop(context);
                        },
                        child: Text('Ok'))
                  ],
                ),
              );
            })
        : showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Could not be Updated'),
                actions: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'))
                ],
              );
            });
  }
}

class textformfieldforfill extends StatelessWidget {
  textformfieldforfill(
      {Key? key,
      this.lastIndex,
      required this.ffem,
      required this.controller,
      required this.hint})
      : super(key: key);
  String hint;
  bool? lastIndex;
  TextEditingController controller;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction:
          (lastIndex == true) ? TextInputAction.none : TextInputAction.next,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF4F0F0),
        contentPadding: EdgeInsets.all(ffem * 10),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: const Color(0xff7A7C7E),
            fontSize: 16 * ffem),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffA7A4A4)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffA7A4A4)),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
