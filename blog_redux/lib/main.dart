import 'package:blog_redux/router.dart';
import 'package:blog_redux/store/actions/actions.dart';
import 'package:blog_redux/store/middleware/app_middleware.dart';
import 'package:blog_redux/store/reducer/app_reducer.dart';
import 'package:blog_redux/views/home/home_view.dart';
import 'package:blog_redux/views/home/home_view_model.dart';
import 'package:blog_redux/views/login/login_view.dart';
import 'package:blog_redux/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'models/app_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = new Store<AppState>(
    appStateReducer,
    initialState: AppState.initial(),
    middleware: appStateMiddelware(),
  );
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StoreBuilder<AppState>(
          builder: (ctx, store) => store.state.loggedInUser == null ||
                  store.state.loggedInUser.name == ''
              ? StoreConnector<AppState, LoginViewModel>(
                  converter: (store) => LoginViewModel.create(store),
                  builder: (context, model) => LoginView(model),
                )
              : StoreConnector<AppState, HomeViewModel>(
                  onInit: (store) => store.dispatch(FetchAllPosts()),
                  converter: (store) => HomeViewModel.create(store),
                  builder: (context, model) => HomeView(model),
                ),
        ),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
