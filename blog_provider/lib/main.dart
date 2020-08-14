import 'package:blog_provider/providers.dart';
import 'package:blog_provider/router.dart';
import 'package:blog_provider/services/api/auth.dart';
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
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<AuthService>(builder: (_, auth, __) {
          return auth.loggedInUser != null ? HomeView() : LoginView();
        }),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
