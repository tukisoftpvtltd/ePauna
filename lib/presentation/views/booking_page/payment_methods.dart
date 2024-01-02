// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:math';
// import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:ePauna/data/user_data/data.dart';
import '/presentation/app_data/colors.dart';
import '/presentation/app_data/size.dart';
import 'package:http/http.dart' as http;
import '../../../data/repository/api/api.dart';

class PaymentMethods extends StatefulWidget {
  PaymentMethods(
      {super.key,
      this.isFromBargain = false,
      required this.sessionBookingId,
      required this.amount,
      required this.sessionBookingName,
      this.hotelType,
      this.bed_type,
      this.room_quantity,
      this.checkout_date,
      this.checkin_date,
      this.note = ' ',
      this.sId,
      this.rate,
      this.no_of_guest,
      this.payment_method,
      this.payment_id,
      this.total,
      this.discount,
      this.clearCallBack});
  final sessionBookingId;
  final amount;
  final sessionBookingName;
  bool isFromBargain;
  String? sId;
  String? hotelType;
  String? bed_type;
  String? room_quantity;
  String? rate;
  String? checkout_date;
  String? checkin_date;
  String? note;
  String? no_of_guest;
  String? payment_method;
  String? payment_id;
  String? total;
  String? discount;
  Function? clearCallBack;

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int? _selectedRadio;
  bool agreeTerms = false;

  //esewa Payment
  String productId =
      ''; // send unique product Id for the product you are paying for
  String productName = ""; // name of the product
  String amount = ""; // amount you are paying
  String call_back_url =
      ""; // (optional) : eSewa sends a copy of proof of payment to this URL after successful payment in live environment. Callback URL is a POST request API(Refer to the developer documentation for it's details)
  String ebpNo = ""; //This field is required in case of government payments.

  String totalAmount = "";
  String environment = "";
  String code = "";
  String merchantName = "";
  String message = "";
  String date = "";
  String status = "";
  String refId = "";
  String hasError = '';
  String PID = '';
  String PName = '';
  String PPrice = '';
  String PMethod = '';
  @override
  void initState() {
    super.initState();
    _selectedRadio = 0;
    String PID = widget.sessionBookingId.toString();
    String PName = widget.sessionBookingName.toString();
    String PPrice = widget.amount.toString();
    String PMethod = widget.payment_method.toString();
    print(widget.sId);
    print(widget.hotelType);
    print(widget.bed_type);
    print(widget.room_quantity);
    print(widget.rate);
    print(widget.checkout_date);
    print(widget.checkin_date);
    print(widget.note);
    print(widget.no_of_guest);
    print(widget.payment_method);
    print(widget.payment_id);
    print(widget.amount);
    print(widget.discount);
    print(widget.isFromBargain);
  }

  // setSelectedRadio(int val) {
  //   setState(() {
  //     _selectedRadio = val;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        // title: Padding(
        //   padding: EdgeInsets.only(top: 3, bottom: 3),
        title: Text(
          "ePauna.com",
          style: TextStyle(
              color: mainColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        // child: IntrinsicWidth(
        //   child: Image(
        //     height: size.large() / 10,
        //     image: AssetImage('assets/pauna1-1.png'),
        //     fit: BoxFit.contain,
        //   ),
        // ),
        // ),
        leading: IconButton(
            color: mainColor,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(size.ex_small() * 10, size.ex_small() * 20,
            size.ex_small() * 10, size.ex_small() * 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: SizedBox(
                width: double.infinity,
                // height: size.small() * 350,
                child: Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: const Color(0x7f7a7c7e)),
                  //   color: const Color(0x66e3e3e3),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            size.ex_small() * 20,
                            size.ex_small() * 10,
                            size.ex_small() * 20,
                            size.ex_small() * 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 15),
                              child: Text(
                                'Pay Through Different Means :',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 17 * size.ex_small(),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Divider(),

                            // ElevatedButton(
                            //     onPressed: () {
                            //       payWithKhalti();
                            //     },
                            //     child: Text('Pay with Khalti')),
                            // EsewaPayButton(
                            //   paymentConfig: ESewaConfig.dev(
                            //     su: 'https://www.marvel.com/hello',
                            //     amt: 10,
                            //     fu: 'https://www.marvel.com/hello',
                            //     pid: '1212',
                            //     // scd: dotenv.env['ESEWA_SCD']!
                            //   ),
                            //   width: 100,
                            //   onFailure: (result) async {
                            //     setState(() {
                            //       refId = '';
                            //       hasError = result;
                            //     });
                            //     if (kDebugMode) {
                            //       print(result);
                            //     }
                            //   },
                            //   onSuccess: (result) async {
                            //     setState(() {
                            //       hasError = '';
                            //       refId = result.refId!;
                            //     });
                            //     if (kDebugMode) {
                            //       print(result.toJson());
                            //     }
                            //   },
                            // ),
                            // if (refId.isNotEmpty)
                            //   Text('Console: Payment Success, Ref Id: $refId'),
                            // if (hasError.isNotEmpty)
                            //   Text(
                            //       'Console: Payment Failed, Message: $hasError'),
                            RadioListTile(
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/esewa.png',
                                      height: 50,
                                    ),
                                  ],
                                ),
                                value: 1,
                                groupValue: _selectedRadio,
                                onChanged: (val) {
                                  setState(() {
                                    _selectedRadio = 1;
                                  });
                                }),
                            RadioListTile(
                                value: 2,
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/khalti.png',
                                      height: 50,
                                    ),
                                  ],
                                ),
                                groupValue: _selectedRadio,
                                onChanged: (val) {
                                  setState(() {
                                    setState(() {
                                      _selectedRadio = 2;
                                    });
                                  });
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.ex_small() * 13,
            ),
            Row(
              children: [
                Checkbox(
                    value: agreeTerms,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = !agreeTerms;
                      });
                    }),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Agree with Terms and Conditions',
                      style: TextStyle(color: tableText),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            agreeTerms = !agreeTerms;
                          });
                        }),
                  TextSpan(
                    text: ' View',
                    style: TextStyle(
                        color: mainColor, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Center(
                                  child: Text(
                                    'Terms and Conditions',
                                    style: TextStyle(color: tableText),
                                  ),
                                ),
                                content: Text(
                                  """This contains all the terms and conditions""",
                                  style: TextStyle(color: tableText),
                                ),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Close',
                                      ))
                                ],
                              );
                            });
                      },
                  ),
                ])),
              ],
            ),
            MaterialButton(
              color: const Color(0xff276BAE),
              onPressed: () {
                if (_selectedRadio == 0) {
                  print('Pay On Site Selected');
                }
                if (_selectedRadio == 1) {
                  (agreeTerms)
                      ? payWithEsewa()
                      : showDialog(
                          context: context,
                          builder: (context) {
                            return WillPopScope(
                              onWillPop: () async {
                                return await false;
                              },
                              child: AlertDialog(
                                scrollable: true,
                                content: Text(
                                    'Make sure you have checked terms and conditions'),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'))
                                ],
                              ),
                            );
                          });
                }
                if (_selectedRadio == 2) {
                  (agreeTerms)
                      ? payWithKhalti()
                      : showDialog(
                          context: context,
                          builder: (context) {
                            return WillPopScope(
                              onWillPop: () async {
                                return await false;
                              },
                              child: AlertDialog(
                                content: Text(
                                    'Make sure you have checked terms and conditions'),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'))
                                ],
                              ),
                            );
                          });
                }
              },
              child: Text(
                "Submit",
                style: TextStyle(color: whiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  String reference_ID = "";
  // !Khalti Payment
  payWithKhalti() {
    KhaltiScope.of(context)
        //amount is defined in 'paisa' so 1000 paisa means NRP.10
        .pay(
            config: PaymentConfig(
                // amount: int.parse('${100 * widget.amount}'),
                amount: 1000,
                productIdentity: 'productIdentity',
                productName: 'productName'),
            preferences: [PaymentPreference.khalti],
            onSuccess: onSuccess,
            onFailure: onFailure,
            onCancel: onCancel);
  }

  void onSuccess(PaymentSuccessModel success) async {
    Map data = {
      'token': '${success.token}',
      // 'amount': "${100 * double.parse(widget.amount)}"
      'amount': "1000"
    };
    String body = json.encode(data);
    try {
      var response = await http.post(
        Uri.parse("https://khalti.com/api/v2/payment/verify/"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization":
              "Key test_secret_key_fba0fa1dc5df4411ae262beb77846252"
        },
        body: body,
      );
      if (response.statusCode == 200) {
        print("payment Successfully Made");
        showDialog(
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: AlertDialog(
                  scrollable: true,
                  content: Row(children: [
                    Text('Processing'),
                    Spacer(),
                    CircularProgressIndicator.adaptive()
                  ]),
                ),
              );
            });
        try {
          widget.isFromBargain
              ? bargainServerUpdate(paymentMethod: 'khalti', data: data)
              : serverUpdate(paymentMethod: 'khalti');
        } catch (e) {}
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: AlertDialog(
                  scrollable: true,
                  content: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: successColor)),
                        child: Icon(
                          Icons.close,
                          color: errorColor,
                          size: 80,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "UNSUCCESSFUL",
                        style: TextStyle(
                            color: errorColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Purchase Was Unsuccessful Please Try Again Later!"),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: errorColor),
                          onPressed: () {
                            setState(() {
                              reference_ID = success.idx;
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Try Again"))
                    ],
                  ),
                ),
              );

              // return AlertDialog(
              //   title: Text('Transaction unSuccessful'),
              //   actions: [
              //     SimpleDialogOption(
              //       child: Text('OK'),
              //       onPressed: (() {
              //         setState(() {
              //           reference_ID = success.idx;
              //         });
              //         Navigator.pop(context);
              //       }),
              //     )
              //   ],
              // );
            });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint('Cancelled');
  }

// ! Esewa Payment Code
  payWithEsewa() {
    try {
      print("the amount is ${widget.amount}");
      print(widget.amount);

      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
          secretId: 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
        ),
        esewaPayment: EsewaPayment(
          productId: widget.sessionBookingId.toString(),
          productName: widget.sessionBookingName.toString(),
          productPrice: widget.amount.toString(),
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
          // BlocProvider.of<PaymentBloc>(context).add(
          //   SubmitPayment(
          //     100.toString(),
          //   ),
          // );
          verifyTransactionStatus(data);
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }

  void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
    print("The result is ");
    print(result);
    Map data = result.toJson();
    var response = await callVerificationApi(data['refId']);
    print(response);
    print('mathiko');
    if (response.statusCode.toString() == "200") {
      widget.isFromBargain
          ? bargainServerUpdate(paymentMethod: 'esewa', data: data)
          : serverUpdate(paymentMethod: 'esewa');
      // paymentSuccessAlert();
    } else {
      showDialog(
          context: context,
          builder: (context) => WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: AlertDialog(
                  scrollable: true,
                  content: Text('Verification Failed'),
                ),
              ));
    }
  }

  paymentSuccessAlert() {
    return showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                scrollable: true,
                title: Text(
                  'Successful',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                ),
                content: Text('Your payment was successful'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'home');
                      },
                      child: Text('OK'))
                ],
              ),
            ));
  }

  callVerificationApi(result) async {
    print("TxnRefd Id: " + result);
    var response = await http.get(
      Uri.parse("https://esewa.com.np/mobile/transaction?txnRefId=$result"),
      headers: {
        'Content-Type': 'application/json',
        'merchantId': 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
        'merchantSecret': 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
      },
    );
    print("Call Verification Api: ${response.statusCode}");
    return response;
  }

  String generateRandomTCode() {
    final random = Random();
    const String characters = 'abcdefghijklmnopqrstuvwxyz0123456789';

    String tCode = '';

    for (int i = 0; i < 12; i++) {
      tCode += characters[random.nextInt(characters.length)];
    }

    return tCode;
  }

  // !Server Update Code
  serverUpdate({dynamic data, required String paymentMethod}) async {
    var res = await http.post(Uri.parse("$baseUrl/api/onlinePayment"), body: {
      'TransactionCode': widget.sessionBookingId.toString(),
      'ModeOfPayment': paymentMethod.toString(),
      'PaymentHistory': DateTime.now().toString(),
    });
    print("Post Payment Status Code: ${res.statusCode}");
    if (res.statusCode == 200) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                scrollable: true,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: successColor)),
                      child: Icon(
                        Icons.done,
                        color: successColor,
                        size: 80,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SUCCESS",
                      style: TextStyle(
                          color: successColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "We received your booking request; we'll be in touch shortly!"),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () {
                          print("object");
                          Navigator.pushReplacementNamed(context, 'home');
                          (data != null)
                              ? setState(() {
                                  reference_ID = data;
                                })
                              : null;
                        },
                        child: Text("Continue Booking"))
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              content: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: errorColor)),
                    child: Icon(
                      Icons.close,
                      color: errorColor,
                      size: 80,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "UNSUCCESSFUL",
                    style: TextStyle(
                        color: errorColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("Payment Successful but Unverified"),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: errorColor),
                      onPressed: () {
                        // Navigator.pushNamed(context, 'home');
                        (data != null)
                            ? setState(() {
                                reference_ID = data;
                              })
                            : null;
                        Navigator.pop(context);
                        serverUpdate(paymentMethod: paymentMethod, data: data);
                      },
                      child: Text("Try Again"))
                ],
              ),
            );
          });
    }
  }

  bargainServerUpdate({dynamic data, required String paymentMethod}) async {
    String tCode = generateRandomTCode();
    var res = await http.post(Uri.parse("$baseUrl/api/pauna_bargain"), body: {
      'tCode': '$tCode:${widget.sId}',
      'sid': '${widget.sId}',
      'user_id': '$user_id',
      'hotel_type': '${widget.hotelType}',
      'bed_type': '${widget.bed_type}',
      'room_quantity': '${widget.room_quantity}',
      'rate': '${widget.rate}',
      'checkout_date': '${widget.checkout_date}',
      'checkin_date': '${widget.checkin_date}',
      'note': '${widget.note}',
      'no_of_guest': '${widget.no_of_guest}',
      'payment_method': '$paymentMethod',
      'payment_id': '${data['refId']}',
      'total': '${widget.amount}',
      'discount': '0',
    });
    print('baraginserveupdate ma aayo');
    var jsonDecoded = json.decode(res.body);
    print(jsonDecoded);
    print("Post Payment Status Code: ${res.statusCode}");
    if (jsonDecoded['status'] == true) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                scrollable: true,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: successColor)),
                      child: Icon(
                        Icons.done,
                        color: successColor,
                        size: 80,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SUCCESS",
                      style: TextStyle(
                          color: successColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "We received your booking request; we'll be in touch shortly!"),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () {
                          print("object");
                          Navigator.pushReplacementNamed(context, 'home');
                          (data != null)
                              ? setState(() {
                                  reference_ID = data;
                                })
                              : null;
                        },
                        child: Text("Continue Booking"))
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                scrollable: true,
                content: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: errorColor)),
                      child: Icon(
                        Icons.close,
                        color: errorColor,
                        size: 80,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "UNSUCCESSFUL",
                      style: TextStyle(
                          color: errorColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("Payment Successfull but Unverified"),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: errorColor),
                        onPressed: () {
                          (data != null)
                              ? setState(() {
                                  reference_ID = data;
                                })
                              : null;
                          Navigator.pop(context);
                          bargainServerUpdate(
                              paymentMethod: paymentMethod, data: data);
                        },
                        child: Text("Try Again"))
                  ],
                ),
              ),
            );
          });
    }
  }
}
