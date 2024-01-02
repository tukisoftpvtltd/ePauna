// import 'package:ayog_tayari/logic/blocs/login_bloc/login_bloc.dart';
// import 'package:ayog_tayari/presentation/data/color/colors.dart';
// import 'package:ayog_tayari/presentation/screens/home/home/base.dart';
// import 'package:ayog_tayari/presentation/screens/home/home/home.dart';
// import 'package:ayog_tayari/presentation/screens/login_register/login.dart';
// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/verify_email_repository.dart';
import '../../../data/user_data/data.dart';
import '../../app_data/colors.dart';

// import '../../../data/repository/emailVerify.dart';

class VerifyEmailPage extends StatefulWidget {
  final userId;
  final loginResponse;
  const VerifyEmailPage({super.key, required this.userId, this.loginResponse});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final formKey = GlobalKey<FormState>();

  EmailVerifyRepository emailVerifyRepository = EmailVerifyRepository();
  TextEditingController otp_code_1 = TextEditingController();
  TextEditingController otp_code_2 = TextEditingController();
  TextEditingController otp_code_3 = TextEditingController();
  TextEditingController otp_code_4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          // backgroundColor: appBackgroundColor,
          body: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                          color: mainColor, shape: BoxShape.circle),
                      child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Icon(
                            Icons.email,
                            size: 70,
                            color: whiteColor,
                          )),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Enter The 4 digits code that is sent to',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Your Email Address',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: otp_code_1,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'N/A';
                              }
                            },
                            maxLength: 1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              // fillColor: inputFieldColor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: otp_code_2,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'N/A';
                              }
                            },
                            maxLength: 1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              fillColor: Color(0xffE8E7E7),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: otp_code_3,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'N/A';
                              }
                            },
                            maxLength: 1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              fillColor: Color(0xffE8E7E7),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: otp_code_4,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'N/A';
                              }
                            },
                            maxLength: 1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              fillColor: inputFieldColor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    color: mainColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        emailVerifyRepository
                            .verifyEmai(
                                userId: widget.userId,
                                otp_code_1: otp_code_1.text,
                                otp_code_2: otp_code_2.text,
                                otp_code_3: otp_code_3.text,
                                otp_code_4: otp_code_4.text)
                            .then((value) async {
                          if (value['status'] == true) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("uid", widget.userId);
                            setState(() {
                              user_id = widget.userId;
                              otp_code_1.clear();
                              otp_code_2.clear();
                              otp_code_3.clear();
                              otp_code_4.clear();
                            });

                            Navigator.of(context).pushReplacementNamed('home');
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Invalid OTP'),
                                    content:
                                        Text("You have entered an invalid OTP"),
                                    actions: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: mainColor),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Text('Close'))
                                    ],
                                  );
                                });
                          }
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Verify ',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
