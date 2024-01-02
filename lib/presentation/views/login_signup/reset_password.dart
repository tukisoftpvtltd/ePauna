// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import '../../../data/repository/send_email_repository.dart';
import '/presentation/app_data/colors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  SendEmailRepository sendEmailRepository = SendEmailRepository();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  forgetPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text('Loading'), CircularProgressIndicator.adaptive()],
            ),
          );
        });
    await sendEmailRepository
        .sendEmail(
            fullName: _fullNameController.text, email: _emailController.text)
        .then((value) {
      print("Reset Password response: $value");
      if (!value['status']) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Unsuccessful',
                  style:
                      TextStyle(color: mainColor, fontWeight: FontWeight.bold),
                ),
                content: Text('${value['message']}'),
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
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Email Sent',
                  style:
                      TextStyle(color: mainColor, fontWeight: FontWeight.bold),
                ),
                content: Text('Check your email and reset your password.'),
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
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      backgroundColor: mainColor),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: whiteColor,
                                      ))),
                              Text(
                                'Change Password ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
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
                            'FORGET PASSWORD',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'You can reset your password here',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: mainColor,
                                child: IconButton(
                                    onPressed: null,
                                    disabledColor: whiteColor,
                                    icon: const Icon(Icons.person)),
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: _fullNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your full name';
                                    }
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      fillColor: inputFieldColor,
                                      filled: true,
                                      border: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: ' Enter your Full Name '),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: mainColor,
                                child: IconButton(
                                    onPressed: null,
                                    disabledColor: whiteColor,
                                    icon: const Icon(Icons.email)),
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!value.contains('@')) {
                                      return 'Please enter valid email';
                                    }
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      fillColor: inputFieldColor,
                                      filled: true,
                                      border: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: ' Enter your email '),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      color: mainColor,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          forgetPassword();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Submit ',
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
      ),
    );
  }
}
