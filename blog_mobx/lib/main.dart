import 'package:blog_mobx/services/api/auth.dart';
import 'package:blog_mobx/services/api/post_service.dart';
import 'package:blog_mobx/views/home_view.dart';
import 'package:blog_mobx/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:blog_mobx/router.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:blog_mobx/state/post_store.dart';
import 'package:blog_mobx/state/user_store.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => UserStore(AuthService()),
        ),
        Provider(
          create: (_) => PostStore(PostServiceImpl()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<UserStore>(
            builder: (ctx, userStore, _) => Observer(
                  builder: (_) =>
                      userStore.loggedInUser == null ? LoginView() : HomeView(),
                )),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
