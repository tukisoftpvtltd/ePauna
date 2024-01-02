import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/internet_bloc.dart';
import '../../../data/repository/login_repository.dart';
import '/presentation/app_data/colors.dart';
import '/presentation/internet_lost/error_state.dart';
import '/presentation/views/login_signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/internet_state.dart';
import '../../../data/repository/google_login_respository.dart';
import '../../../data/user_data/data.dart';
import '../../../logic/google_login_api.dart';
import '../../../logic/login_signup/login_signup.dart';
import '../../custom_widgets/custom_prompt.dart';
import '../../internet_lost/not_connection.dart';
import 'reset_password.dart';
import 'verifyEmail.dart';

class Login extends StatefulWidget {
  final beforePayment;
  const Login({super.key, this.beforePayment});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  bool isLoaded = true;
  bool enableLogin = true;

  //LoginHelper Instantiated
  LoginSignUp help = const LoginSignUp();
  //CustomPrompt
  CustomPrompt alert = const CustomPrompt();
  LoginRepository loginRepository = LoginRepository();
  bool hidePassword = true;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  googleLogin() async {
    GoogleLoginRepository googleLoginRepository = GoogleLoginRepository();

    var user = await LoginApi.login();
    if (user != null) {
      await googleLoginRepository
          .googleLogin(
              firstName: user.displayName,
              lastname: user.displayName,
              email: user.email,
              phone: '',
              password: '')
          .then((value) async {
        if (value[0].status == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("uid", "${value[0].userId}");
          setState(() {
            user_id = value[0].userId;
          });
          Navigator.of(context).pushNamed('home');
        } else {
          email.clear();
          password.clear();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Login Error'),
                  content: Text('Couldnot signin with google'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'))
                  ],
                );
              });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  // systemOverlayStyle: SystemUiOverlayStyle(
                  //   statusBarIconBrightness: Brightness.light,
                  //   statusBarColor: blackColor,
                  // ),
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      // Navigator.of(context).pushReplacementNamed('home');
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: blackColor,
                      size: 25,
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            44 * fem, 40 * fem, 43 * fem, 179 * fem),
                        child: Form(
                          key: formkKey,
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      //for logo
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          0 * fem, 1 * fem, 8.44 * fem),
                                      width: 250 * fem,
                                      height: 80.56 * fem,
                                      child: Image.asset(
                                        'assets/pauna1-1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //For Login Text
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 2 * fem, 35 * fem),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 35 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 * ffem / fem,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      // For Email TextEditing Field
                                      margin: EdgeInsets.fromLTRB(
                                          1 * fem, 0 * fem, 1 * fem, 31 * fem),
                                      width: double.infinity,
                                      child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your email ';
                                            }
                                            if (!value.contains('@')) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                          // hint: "Confirm Password",
                                          controller: email,
                                          textInputAction: TextInputAction.next,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                fontSize: 20 * ffem,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5 * ffem / fem,
                                                color: const Color(0x60276bae),
                                              ),
                                              hintText: 'email',
                                              prefixIcon:
                                                  const Icon(Icons.mail),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xffE8E7E7),
                                              contentPadding:
                                                  const EdgeInsets.all(12),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xffE8E7E7),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xffE8E7E7),
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  borderSide: BorderSide(
                                                    color: errorColor,
                                                  ))))),
                                  Container(
                                      // For TextEdituing Feild
                                      margin: EdgeInsets.fromLTRB(
                                          1 * fem, 0 * fem, 1 * fem, 31 * fem),
                                      width: double.infinity,
                                      child: TextFormField(
                                          textInputAction: TextInputAction.send,
                                          onFieldSubmitted: ((value) {}),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your paswword ';
                                            }
                                            return null;
                                          },
                                          controller: password,
                                          obscureText: hidePassword,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                fontSize: 20 * ffem,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5 * ffem / fem,
                                                color: const Color(0x60276bae),
                                              ),
                                              prefixIcon: Icon(Icons.password),
                                              hintText: 'password',
                                              suffixIcon: (hidePassword)
                                                  ? IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          hidePassword =
                                                              !hidePassword;
                                                        });
                                                      },
                                                      icon: Icon(
                                                          Icons.visibility_off))
                                                  : IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          hidePassword =
                                                              !hidePassword;
                                                        });
                                                      },
                                                      icon: Icon(Icons
                                                          .remove_red_eye)),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xffE8E7E7),
                                              contentPadding:
                                                  const EdgeInsets.all(12),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xffE8E7E7),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xffE8E7E7),
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  borderSide: BorderSide(
                                                    color: errorColor,
                                                  ))))),
                                  GestureDetector(
                                    onTap: () async {
                                      print("Password: ${password.text}");
                                      if (formkKey.currentState!.validate()) {
                                        setState(() {
                                          enableLogin = false;
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text('Loading'),
                                                    CircularProgressIndicator
                                                        .adaptive()
                                                  ],
                                                ),
                                              );
                                            });
                                        await loginRepository
                                            .login(
                                                email:
                                                    '${email.text.toString()}',
                                                password:
                                                    '${password.text.toString()}')
                                            .then((value) async {
                                          if (value[0].status == true &&
                                              value[0].emailVarified == 1) {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            prefs.setString("uid",
                                                value[0].userId.toString());
                                            prefs.setString('username',
                                                '${value[0].firstName} ${value[0].lastName}');
                                            setState(() {
                                              user_id =
                                                  value[0].userId.toString();
                                            });
                                            Navigator.pop(context);
                                            (widget.beforePayment != null &&
                                                    widget.beforePayment)
                                                ? Navigator.pop(context)
                                                : Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        'home');
                                          } else if (value[0].status == true &&
                                              value[0].emailVarified == 0) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VerifyEmailPage(
                                                          userId:
                                                              value[0].userId,
                                                        )));
                                          } else if (value[0].status == false) {
                                            Navigator.pop(context);
                                            setState(() {
                                              enableLogin = true;
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      "Login Failure",
                                                      style: TextStyle(
                                                          color: mainColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: Text(value[0]
                                                        .message
                                                        .toString()),
                                                    actions: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      mainColor),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Ok'))
                                                    ],
                                                  );
                                                });
                                          }
                                        });
                                      }

                                      // SharedPreferences sEmail =
                                      //     await SharedPreferences.getInstance();
                                      // SharedPreferences sPassword =
                                      //     await SharedPreferences.getInstance();
                                      // if (key.currentState!.validate()) {
                                      // var res = await help.loginSignUpFunction(
                                      //     apiUrl: loginApi(
                                      //         email: email.text
                                      //             .toLowerCase()
                                      //             .trim(),
                                      //         password: password.text),
                                      //     apiType: 'POST');

                                      //   if (res[0]) {
                                      //     await sEmail.setString("email",
                                      //         email.text.trim().toLowerCase());
                                      //     await sPassword.setString(
                                      //         "password", password.text);

                                      //     if (widget.beforePayment == true) {
                                      //       SharedPreferences prefs =
                                      //           await SharedPreferences
                                      //               .getInstance();
                                      //       var val =
                                      //           await prefs.getString("uid")!;
                                      //       setState(() {
                                      //         user_id = val;
                                      //       });
                                      //       Navigator.pop(context);
                                      //     } else {
                                      //       Navigator.of(context)
                                      //           .pushReplacementNamed('home');
                                      //     }
                                      //   }
                                      //   if (!res[0]) {
                                      //     showDialog(
                                      //         context: context,
                                      //         builder: (context) {
                                      //           return AlertDialog(
                                      //             content:
                                      //                 Text(res[1].toString()),
                                      //             actions: [
                                      //               ElevatedButton(
                                      //                   style: ElevatedButton
                                      //                       .styleFrom(
                                      //                           backgroundColor:
                                      //                               mainColor),
                                      //                   onPressed: () {
                                      //                     Navigator.pop(context);
                                      //                   },
                                      //                   child: Text('Ok'))
                                      //             ],
                                      //           );
                                      //         });
                                      //   }
                                      // }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(1 * fem,
                                            0 * fem, 0.3 * fem, 10 * fem),
                                        padding: EdgeInsets.fromLTRB(141 * fem,
                                            11 * fem, 106 * fem, 9 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x3f164482),
                                              offset: Offset(0 * fem, 4 * fem),
                                              blurRadius: 2 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    13 * fem,
                                                    0 * fem),
                                                child: Text(
                                                  'Login',
                                                  style: TextStyle(
                                                    fontSize: 20 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5 * ffem / fem,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ])),
                                  ),
                                  Container(
                                    // forgetpassword
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 11 * fem, 10 * fem),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPassword()));
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Text(
                                        'Forget Password ?',
                                        style: TextStyle(
                                          fontSize: 20 * ffem,
                                          fontWeight: FontWeight.w400,

                                          // height: 1.5 * ffem / fem,
                                          // decoration: TextDecoration.underline,
                                          color: mainColor,
                                          decorationColor: mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        1 * fem, 0 * fem, 1 * fem, 16 * fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              3 * fem, 0 * fem, 0 * fem),
                                          width: 139 * fem,
                                          height: 1 * fem,
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 19 * fem,
                                        ),
                                        Text(
                                          'OR',
                                          style: TextStyle(
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.5 * ffem / fem,
                                            color: mainColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 19 * fem,
                                        ),
                                        Expanded(
                                          child: Container(
                                            // Line
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                3 * fem, 0 * fem, 0 * fem),
                                            width: 139 * fem,
                                            height: 1 * fem,
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      googleLogin();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: mainColor),
                                      ),
                                      width: 339 * fem,
                                      height: 50 * fem,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Image.asset(
                                              'assets/images/google.png',
                                              fit: BoxFit.contain,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Login with Gooogle',
                                              style: TextStyle(
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 10 * fem, 5 * fem, 0 * fem),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Don\'t have an account?',
                                          style: TextStyle(
                                            fontSize: 21 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * ffem / fem,
                                            // decoration:
                                            //     TextDecoration.underline,
                                            color: mainColor,
                                            decorationColor: mainColor,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' SignUp',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                          return SignUp(
                                                            beforePayment: widget
                                                                .beforePayment,
                                                          );
                                                        }));
                                                        // Navigator.of(context)
                                                        //     .pushReplacementNamed(
                                                        //         'signup');
                                                      }),
                                          ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          );
        }
        return const InternetErrorScreen();
      },
    );
  }
}
