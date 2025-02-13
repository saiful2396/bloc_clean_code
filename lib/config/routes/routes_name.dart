import 'package:flutter/material.dart';
import 'routes.dart';
import '../../views/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return NoSwipeBackRoute(builder: (context) => SplashScreen());
      case RoutesName.homeScreen:
        return NoSwipeBackRoute(builder: (context) => HomeScreen());
      case RoutesName.loginScreen:
        return NoSwipeBackRoute(builder: (context) => LoginScreen());
      default:
        return NoSwipeBackRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You have route generated yet!"),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pop(context, RoutesName.splashScreen),
                      child: Text("Go to Home")),
                ],
              ),
            ),
          );
        });
    }
  }
}

// Custom PageRoute to disable swipe-to-back gesture
class NoSwipeBackRoute<T> extends MaterialPageRoute<T> {
  NoSwipeBackRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  bool get popGestureEnabled => false; // Disable swipe-to-back gesture
}
