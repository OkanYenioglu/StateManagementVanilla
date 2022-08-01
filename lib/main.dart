import 'package:flutter/material.dart';
import 'package:state_managements_real_life/feature/onboard/on_board_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: const OnBoardView(),
      theme: ThemeData.light().copyWith(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(11, 23, 84, 1),
      )),
    );
  }
}
