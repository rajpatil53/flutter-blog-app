import 'package:blog_bloc/router.dart';
import 'package:blog_bloc/services/auth/cubit/auth_cubit.dart';
import 'package:blog_bloc/services/comments/bloc/comment_bloc.dart';
import 'package:blog_bloc/services/post/bloc/post_bloc.dart';
import 'package:blog_bloc/views/home_view.dart';
import 'package:blog_bloc/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
        ),
        BlocProvider(
          create: (_) => PostBloc(),
        ),
        BlocProvider(
          create: (_) => CommentBloc(),
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
        home: App(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => BlocBuilder<AuthCubit, AuthState>(
      builder: (_, authState) =>
          authState is LoggedIn ? HomeView() : LoginView());
}
