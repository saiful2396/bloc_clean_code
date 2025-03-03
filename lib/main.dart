import 'package:bloc_clean_code/config/routes/routes.dart';
import 'package:bloc_clean_code/config/routes/routes_name.dart';
import 'package:bloc_clean_code/repository/auth/login_http_repository.dart';
import 'package:bloc_clean_code/repository/auth/login_repository.dart';
import 'package:bloc_clean_code/repository/movie/movie_http_repository.dart';
import 'package:bloc_clean_code/repository/movie/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void main() {
  serviceLocator();
  runApp(const MyApp());
}

class NoSwipeBackPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // Slide Transition
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0), // Slide from right to left
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoSwipeBackPageTransitionsBuilder(),
            TargetPlatform.iOS: NoSwipeBackPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

void serviceLocator(){
  getIt.registerLazySingleton<LoginRepository>(()=> LoginHttpRepository());
  getIt.registerLazySingleton<MovieRepository>(()=> MovieHttpRepository());
}
