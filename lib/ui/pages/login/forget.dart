
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imio_flutter/utils/size_fit.dart';
import 'package:logging/logging.dart';

final logger = Logger("ForgetPage");

class ForgetPage extends StatelessWidget {
  const ForgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("忘记密码"),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "手机号或邮箱",
                            border: InputBorder.none,
                            icon: Icon(Icons.phone_android),
                            //                    filled: true,
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "验证码",
                            border: InputBorder.none,
                            icon: Icon(Icons.lock),
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "密码",
                            border: InputBorder.none,
                            icon: Icon(Icons.lock),
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "确认密码",
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
                    child: Text("提交"),
                    onPressed: () {
                      // _onSubmitted();
                    }),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(onPressed: () {
                context.replace("/login");
              }, child: Text("登录")),
              Text("|"),
              TextButton(onPressed: () {
                context.replace("/signup");
              }, child: Text("注册")),
            ],
          ),
        )

    );
  }

}