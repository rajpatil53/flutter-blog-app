import 'package:blog_provider/services/api/auth.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentProviders,
  ...uiCosumableProviders,
];
List<SingleChildWidget> independentServices = [
  Provider<PostService>(
    create: (_) => PostServiceImpl(),
  ),
];
List<SingleChildWidget> dependentProviders = [];
List<SingleChildWidget> uiCosumableProviders = [
  ChangeNotifierProvider<AuthService>(
    create: (_) => AuthService(),
  ),
];
