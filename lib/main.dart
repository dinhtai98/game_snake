import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snake/core/global/my_router_observer.dart';
import 'package:snake/core/global/providers.dart';
import 'package:snake/core/screens/home_screen.dart';
import 'package:snake/core/global/router.dart';
import 'package:snake/core/utils/navigation_utils.dart';

void main() {
  mainDelegate();
}

void mainDelegate() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...viewModelProviders],
      child: GetMaterialApp(
        title: 'Snake',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationUtils.navigatorKey,
        onGenerateRoute: (settings) => MyRouter.generateRoute(settings),
        navigatorObservers: [MyRouteObserver()],
        initialRoute: MyRouter.home,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreens(),
      ),
    );
  }
}
