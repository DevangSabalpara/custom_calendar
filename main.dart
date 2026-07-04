import 'package:custom_calender/calendar/calendar_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String get initialRoute {
    // return AppPref.isUserLoggedIn ? HomeView.routeName : LoginView.routeName;
    return CalendarView.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: _routes,
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      title: 'Custom Calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

final _routes = <String, WidgetBuilder>{
  // "/": (context) => LoginView.builder(context),
  CalendarView.routeName: (context) => CalendarView.builder(context),
};
