import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_sho/app/constants.dart';
import 'package:t_sho/meta/onboarding.page.dart';

void main() {
  runApp(const TSho());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: scaffoldColor,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}

class TSho extends StatelessWidget {
  const TSho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Gifory",
          brightness: Brightness.dark,
          scaffoldBackgroundColor: scaffoldColor,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0.0,
            titleTextStyle: TextStyle(fontFamily: "Gifory"),
          )),
      home: const OnBoarding(),
    );
  }
}
