// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/bloc/internet_bloc.dart';
import '/presentation/internet_lost/error_state.dart';
import '../../../bloc/internet_state.dart';
import '../../../data/repository/register_repository.dart';
import '../../../logic/login_signup/login_signup.dart';
import '../../internet_lost/not_connection.dart';
import '/presentation/views/login_signup/login.dart';
import '../../app_data/colors.dart';
import 'verifyEmail.dart';

class SignUp extends StatefulWidget {
  final beforePayment;
  const SignUp({super.key, this.beforePayment});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final GlobalKey<FormState> key;
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  RegisterRepository registerRepository = RegisterRepository();
  bool enableSignup = true;
  bool hidePassword = true;
  bool hidePassword0 = true;

  @override
  void initState() {
    key = GlobalKey<FormState>();
    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //LoginHelper Instantiated
    LoginSignUp help = const LoginSignUp();
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetLostState) {
          return const InternetLostScreen();
        }
        if (state is InternetGainedState) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                backgroundColor: whiteColor,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('home');
                    // Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: blackColor,
                    size: 25,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      45 * fem, 10 * fem, 40 * fem, 20 * fem),
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            // paunaTitle

                            width: 250 * fem,
                            height: 80.56 * fem,
                            child: Image.asset(
                              'assets/pauna1-1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // signup
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 1 * fem, 32 * fem),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 35 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.5 * ffem / fem,
                              color: mainColor,
                            ),
                          ),
                        ),
                        TextFomFeilds(
                          hint: "First  Name",
                          inputController: firstname,
                          icon: const Icon(Icons.person),
                        ),
                        TextFomFeilds(
                          hint: "Last Name",
                          inputController: lastname,
                          icon: const Icon(Icons.person),
                        ),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email ';
                            } else if (!value.contains('@')) {
                              return 'Please enter a valid email ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * ffem / fem,
                                color: const Color(0x60276bae),
                              ),
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: const Color(0xffE8E7E7),
                              contentPadding: const EdgeInsets.all(12),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Color(0xffE8E7E7),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Color(0xffE8E7E7),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: errorColor,
                                  ))),
                        ),
                        SizedBox(
                          height: ffem * 25,
                        ),
                        TextFormField(
                          controller: phone,
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
                              hintStyle: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * ffem / fem,
                                color: const Color(0x60276bae),
                              ),
                              hintText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone),
                              filled: true,
                              fillColor: const Color(0xffE8E7E7),
                              contentPadding: const EdgeInsets.all(12),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Color(0xffE8E7E7),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Color(0xffE8E7E7),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: errorColor,
                                  ))),
                        ),
                        SizedBox(
                          height: ffem * 25,
                        ),
                        TextFormField(
                            controller: password,
                            enabled: enableSignup,
                            obscureText: hidePassword0,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5 * ffem / fem,
                                  color: const Color(0x60276bae),
                                ),
                                hintText: 'New Password',
                                prefixIcon: Icon(Icons.security),
                                filled: true,
                                suffixIcon: (hidePassword0)
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hidePassword0 = !hidePassword0;
                                          });
                                        },
                                        icon: Icon(Icons.visibility_off))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hidePassword0 = !hidePassword0;
                                          });
                                        },
                                        icon: Icon(Icons.remove_red_eye)),
                                fillColor: const Color(0xffE8E7E7),
                                contentPadding: const EdgeInsets.all(12),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xffE8E7E7),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xffE8E7E7),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    )))),
                        SizedBox(
                          height: ffem * 25,
                        ),
                        // TextFormField(
                        //     controller: confirmPassword,
                        //     enabled: enableSignup,
                        //     obscureText: hidePassword,
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return 'Please re-enter your password ';
                        //       } else if (password.text != value) {
                        //         return 'Passwords do not match';
                        //       }
                        //       return null;
                        //     },
                        //     decoration: InputDecoration(
                        //         hintStyle: TextStyle(
                        //           fontSize: 20 * ffem,
                        //           fontWeight: FontWeight.w300,
                        //           height: 1.5 * ffem / fem,
                        //           color: const Color(0x60276bae),
                        //         ),
                        //         hintText: 'Re-enter Password',
                        //         prefixIcon: Icon(Icons.security),
                        //         filled: true,
                        //         suffixIcon: (hidePassword)
                        //             ? IconButton(
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     hidePassword = !hidePassword;
                        //                   });
                        //                 },
                        //                 icon: Icon(Icons.visibility_off))
                        //             : IconButton(
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     hidePassword = !hidePassword;
                        //                   });
                        //                 },
                        //                 icon: Icon(Icons.remove_red_eye)),
                        //         fillColor: const Color(0xffE8E7E7),
                        //         contentPadding: const EdgeInsets.all(12),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           borderSide: const BorderSide(
                        //             color: Color(0xffE8E7E7),
                        //           ),
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           borderSide: const BorderSide(
                        //             color: Color(0xffE8E7E7),
                        //           ),
                        //         ),
                        //         errorBorder: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(8.0),
                        //             borderSide: const BorderSide(
                        //               color: Colors.red,
                        //             )))),
                        SizedBox(
                          height: ffem * 25,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (key.currentState!.validate()) {
                              setState(() {
                                enableSignup = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Loading'),
                                          CircularProgressIndicator.adaptive(),
                                        ],
                                      ),
                                    );
                                  });
                              await registerRepository
                                  .register(
                                      firstName: firstname.text,
                                      lastName: lastname.text,
                                      email: email.text,
                                      password: password.text,
                                      phone: phone.text)
                                  .then((value) async {
                                if (value[0].status == true) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('username',
                                      '${firstname.text} ${lastname.text}');

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VerifyEmailPage(
                                            userId: value[0].userId,
                                          )));

                                  firstname.clear();
                                  lastname.clear();
                                  email.clear();
                                  password.clear();
                                  phone.clear();
                                }
                                if (value[0].status == false) {
                                  firstname.clear();
                                  lastname.clear();
                                  email.clear();
                                  password.clear();
                                  confirmPassword.clear();
                                  phone.clear();
                                  //This pops the previous Loading bar and then allow the text to be shown
                                  Navigator.pop(context);
                                  setState(() {
                                    enableSignup = true;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Registeration Failure",
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content:
                                              Text(value[0].message.toString()),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: mainColor),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Close'))
                                          ],
                                        );
                                      });
                                }
                              });
                              // if (await help.loginSignUpFunction(
                              //         apiUrl: signupApi(
                              //             firstname: firstname.text,
                              //             lastname: lastname.text,
                              //             email: email.text,
                              //             password: password.text,
                              //             phone: phone.text),
                              //         apiType: 'POST') ==
                              //     true) {
                              //   Navigator.of(context)
                              //       .pushReplacementNamed('login');
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           content: const Text("Successful"),
                              //           backgroundColor: successColor));
                              //   Navigator.of(context)
                              //       .pushReplacementNamed('login');
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           content: const Text("Exception thrown"),
                              //           backgroundColor: errorColor));
                              //   Navigator.of(context)
                              //       .pushReplacementNamed('login');
                              // }
                            }
                          },
                          child: Container(
                            //Sign up Button
                            margin:
                                EdgeInsets.fromLTRB(0, 0 * fem, 0, 33 * fem),
                            padding: EdgeInsets.fromLTRB(
                                126 * fem, 11 * fem, 106 * fem, 9 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(8 * fem),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x3f164482),
                                  offset: Offset(0 * fem, 4 * fem),
                                  blurRadius: 2 * fem,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 11 * fem, 0 * fem),
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5 * ffem / fem,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // alreadyhaveaaccountloging
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 5 * fem, 0 * fem),
                          child: RichText(
                            text: TextSpan(
                                text: 'Already have an account?',
                                style: TextStyle(
                                  fontSize: 21 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * ffem / fem,
                                  decoration: TextDecoration.underline,
                                  color: mainColor,
                                  decorationColor: mainColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Login',
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Login(
                                              beforePayment:
                                                  widget.beforePayment,
                                            );
                                          }));
                                          // Navigator.of(context)
                                          // .pushReplacementNamed('login');
                                        }),
                                ]),
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
        return const InternetErrorScreen();
      },
    );
  }
}

class TextFomFeilds extends StatelessWidget {
  String hint;
  Icon icon;

  TextEditingController inputController;

  TextFomFeilds(
      {Key? key,
      required this.inputController,
      required this.hint,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      children: [
        TextFormField(
            controller: inputController,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $hint ';
              }
              return null;
            },
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w300,
                  height: 1.5 * ffem / fem,
                  color: const Color(0x60276bae),
                ),
                hintText: hint,
                prefixIcon: icon,
                filled: true,
                fillColor: const Color(0xffE8E7E7),
                contentPadding: const EdgeInsets.all(12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffE8E7E7),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffE8E7E7),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    )))),
        SizedBox(
          height: ffem * 25,
        )
      ],
    );
  }
}
