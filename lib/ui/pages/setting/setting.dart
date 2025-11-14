

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:imio_flutter/data/services/auth_service.dart';
import 'package:imio_flutter/utils/size_fit.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

final logger = Logger("SettingPage");

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingPageStats();

}

class _SettingPageStats extends State<SettingPage> {


  @override
  Widget build(BuildContext context) {
    var fToast = FToast().init(context);

    var authService = context.read<AuthService>();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("设置"),
          leading: IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.replace("/login");
                }
              }),
        ),
        body: Text("setting"),

        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
            ),
            child: Text("退出",style: TextStyle(color: Colors.white)),
            onPressed: () {
              authService.logout().then((value) {
                context.go("/");
              }).catchError((e) {
                fToast.showToast(child: toast("失败"));
              });
            },
          ),
        )

    );
  }

}