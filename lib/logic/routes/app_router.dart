import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bargainHistory/bloc/bargian_history_bloc.dart';
import '../../presentation/views/bargain_history/bargainHistory.dart';
import '/cubit/mainpage_cubit/mainpage_cubit.dart';
import '/cubit/transactions_cubit/transaction_cubit.dart';
import '/presentation/internet_lost/not_connection.dart';
import '/presentation/views/login_signup/signup.dart';
import '/presentation/views/home_page/home.dart';
import '/presentation/views/splash.dart/splash.dart';
import '/presentation/views/sub_menu/transactions.dart';
import '../../bloc/internet_bloc.dart';
import '../../bloc/internet_state.dart';
import '../../presentation/views/login_signup/login.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocBuilder<InternetBloc, InternetState>(
                  builder: (context, state) {
                    if (state is InternetGainedState) {
                      return SplashScreen();
                    }
                    return InternetLostScreen();
                  },
                ));
      case 'login':
        return MaterialPageRoute(builder: (_) => const Login());
      case 'signup':
        return MaterialPageRoute(builder: (_) => const SignUp());

      case 'home':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => MainpageCubit(), child: const Home()));
      case 'transaction':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => TransactionsCubit(),
                  child: Transactions(),
                ));
      case 'bargainHistory':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => BargainHistoryBloc(),
                  child: BargainHistory(),
                ));
      default:
        return null;
    }
  }
}
