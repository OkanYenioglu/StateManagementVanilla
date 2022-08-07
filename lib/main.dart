import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:state_managements_real_life/feature/login/view/login_view.dart';
import 'package:state_managements_real_life/feature/onboard/on_board_view.dart';
import 'package:state_managements_real_life/product/model/state/project_context.dart';
import 'package:state_managements_real_life/product/model/state/user_context.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider(
        //   create: (context) => UserContext('a'),
        // ),
        ChangeNotifierProvider(
          create: (context) => ProductContext(),
        ),
        ProxyProvider<ProductContext, UserContext?>(update: (context, producContext, userContext) {
          return userContext != null ? userContext.copyWith(name: producContext.newUserName) : UserContext(producContext.newUserName);
        }),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: const OnBoardView(),
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.grey[300],
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromRGBO(11, 23, 84, 1),
            )),
      ),
    );
  }
}
