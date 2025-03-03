import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Platform.isAndroid
              ? CircularProgressIndicator()
              : CupertinoActivityIndicator(),
          SizedBox(
            width: 5,
          ),
          Text("Loading..."),
        ],
      ),
    );
  }
}
