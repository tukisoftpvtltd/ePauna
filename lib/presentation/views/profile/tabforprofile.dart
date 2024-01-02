import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/mainpage_cubit/mainpage_cubit.dart';
import '../home_page/home.dart';
import '/presentation/app_data/size.dart';

class tabforprofie extends StatelessWidget {
  const tabforprofie({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            size.small() * 15, size.small() * 15, size.small() * 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => MainpageCubit(),
                          child: Home(
                            index: 3,
                          ),
                        )));
              },
              child: Text(
                "Profile",
                style: TextStyle(
                    fontSize: 20 * size.ex_small(),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Divider(
              height: size.ex_small() * 50,
              thickness: 1,
              color: Color(0xffBFBABA),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('transaction');
              },
              child: Text(
                "Transaction History",
                style: TextStyle(
                    fontSize: 20 * size.ex_small(),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Divider(
              height: size.ex_small() * 50,
              thickness: 1,
              color: Color(0xffBFBABA),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Coupens",
                style: TextStyle(
                    fontSize: 20 * size.ex_small(),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Divider(
              height: size.ex_small() * 50,
              thickness: 1,
              color: Color(0xffBFBABA),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "My Reviews",
                style: TextStyle(
                    fontSize: 20 * size.ex_small(),
                    fontWeight: FontWeight.w500),
              ),
            ),
             Divider(
              height: size.ex_small() * 50,
              thickness: 1,
              color: Color(0xffBFBABA),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('bargainHistory');
              },
              child: Text(
                "Bargain History",
                style: TextStyle(
                    fontSize: 20 * size.ex_small(),
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
