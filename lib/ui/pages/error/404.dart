
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrPage extends StatelessWidget {
  const ErrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("404"),
          ElevatedButton(onPressed: () {
            context.go("/home");
          }, child: Text("Go Home"))
        ],
      ),
    );
  }

}