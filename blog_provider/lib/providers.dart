import 'package:blog_provider/services/api/user.dart';
import 'package:blog_provider/services/api/post_service.dart';
import 'package:blog_provider/services/device_storage/shared_prefs.dart';
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
  Provider<SharedPrefService>(
    create: (_) => SharedPrefServiceImpl(),
  ),
];

List<SingleChildWidget> dependentProviders = [
  ChangeNotifierProxyProvider<SharedPrefService, UserService>(
    create: (_) => UserServiceImpl(sharedPrefService: SharedPrefServiceImpl()),
    update: (_, __, userService) => userService,
  ),
];

List<SingleChildWidget> uiCosumableProviders = [];
