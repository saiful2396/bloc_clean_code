import 'package:bloc_clean_code/config/routes/routes.dart';
import 'package:bloc_clean_code/service/storage/local_storage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              LocalStorage localStorage = LocalStorage();
              localStorage.deleteValue('token').then((value) {
                localStorage.deleteValue('isLogin').then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.loginScreen, (route) => false);
                });
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text("Home screen, you are not able to swipe to back!"),
      ),
    );
  }
}
