import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'routing/index.dart';
import 'utils/size_fit.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Logger.root.level = Level.ALL;
    SizeFit.initialize();
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          background: Color.fromRGBO(250, 250, 250, 0.9),
        ),
        cardColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router(context.read()),
    );
  }
}
