import 'package:blog_provider/app/constants.dart';
import 'package:blog_provider/providers.dart';
import 'package:blog_provider/router.dart';
import 'package:blog_provider/services/api/user.dart';
import 'package:blog_provider/views/home/home_view.dart';
import 'package:blog_provider/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          accentColor: Colors.amberAccent,
          textTheme: textTheme,
        ),
        theme: ThemeData(
          primarySwatch: Colors.amber,
          textTheme: textTheme,
        ),
        home: Consumer<UserService>(builder: (_, auth, __) {
          return auth.loggedInUser != null ? HomeView() : LoginView();
        }),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
