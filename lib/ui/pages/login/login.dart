import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:imio_flutter/data/services/auth_service.dart';
import 'package:imio_flutter/utils/size_fit.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

final logger = Logger("LoginPage");


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState()  => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _pwdEditController = TextEditingController();
    TextEditingController _userNameEditController = TextEditingController();
    var authService = context.read<AuthService>();
    var fToast = FToast().init(context);
    _userNameEditController.text = authService.account;

    _onSubmitted() {
      if (_userNameEditController.text.length <= 0) {
        fToast.showToast(child: toast("用户名必须"));
        return;
      }
      if (_userNameEditController.text.length >= 20) {
        fToast.showToast(child: toast("用户名太长"));
        return;
      }
      if (_pwdEditController.text.length <= 0) {
        fToast.showToast(child: toast("密码必须"));
        return;
      }
      if (_pwdEditController.text.length >= 20) {
        fToast.showToast(child: toast("密码太长"));
        return;
      }
      authService.login(email: _userNameEditController.text, password: _pwdEditController.text)
          .then((value) {
        logger.finer(value.toString());
        if (context.canPop()) {
          context.pop();
        } else {
          context.go("/home");
        }
      }).catchError((e) {
        logger.warning("login Error32",e);
        fToast.showToast(child: toast(e.toString()));

      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("登录"),
          leading: IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                // GoRouter.of(context).routerDelegate.currentConfiguration
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.replace("/home");
                }
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.rpx,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 160.rpx,
                  height: 160.rpx,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0,4.0,16.0,4.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _userNameEditController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "手机号",
                            border: InputBorder.none,
                            icon: Icon(Icons.phone_android),
                            //                    filled: true,
                          ),
                        ),
                        Divider(),
                        TextField(
                          controller: _pwdEditController,
                          obscureText: false,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "密码",
                            border: InputBorder.none,
                            icon: Icon(Icons.lock),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.rpx),
                padding: EdgeInsets.symmetric(horizontal: 30.rpx),
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    child: Text("登录"),
                    onPressed: () {
                      _onSubmitted();
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    context.push("/signup");
                  },
                  child: Text("注册")),
              Text("|"),
              TextButton(
                  onPressed: () {
                    context.push("/forget");
                  },
                  child: Text("忘记密码")),
            ],
          ),
        ));
  }
}