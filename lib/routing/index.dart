import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imio_flutter/ui/pages/error/404.dart';
import 'package:imio_flutter/ui/pages/home/contact.dart';
import 'package:imio_flutter/ui/pages/home/home.dart';
import 'package:imio_flutter/ui/pages/home/me.dart';
import 'package:imio_flutter/ui/pages/index.dart';
import 'package:imio_flutter/ui/pages/login/forget.dart';
import 'package:imio_flutter/ui/pages/login/login.dart';
import 'package:imio_flutter/ui/pages/login/signup.dart';
import 'package:imio_flutter/ui/pages/setting/setting.dart';
import 'package:imio_flutter/ui/viewmodels/contact_vm.dart';
import 'package:imio_flutter/ui/viewmodels/home_vm.dart';
import 'package:imio_sdk_lite/imio.dart';
import 'package:provider/provider.dart';

import '../data/services/auth_service.dart';
import '../ui/viewmodels/me_vm.dart';

final _openPage = ['/index', "/login", "/signup", "/forget", '/home', '/404'];

GoRouter router(AuthService authService) => GoRouter(
    initialLocation: "/home",
    refreshListenable:authService,
    debugLogDiagnostics: true,
    onException: (_, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
    routes: <RouteBase>[
      ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return IndexPage(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (BuildContext context, GoRouterState state) {
                var viewModel = HomeViewModel();
                return HomePage(viewmodel: viewModel);
              },
            ),
            GoRoute(
              path: '/contact',
              name: 'contact',
              builder: (BuildContext context, GoRouterState state) {
                var client = context.read<IMIOClient>();
                var viewModel = ContactViewModel(imioClient: client);
                return ContactPage(viewModel: viewModel);
              },
            ),
            GoRoute(
              path: '/me',
              name: 'me',
              builder: (BuildContext context, GoRouterState state) {
                var client = context.read<IMIOClient>();
                var viewModel = MeViewModel(imioClient: client, authService: authService);
                return MePage(viewModel: viewModel,);
              },
            ),
          ]),
      GoRoute(
        path: "/login",
        name: "login",
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: "/signup",
        name: "signup",
        builder: (BuildContext context, GoRouterState state) {
          return const SignupPage();
        },
      ),
      GoRoute(
        path: "/forget",
        name: "forget",
        builder: (BuildContext context, GoRouterState state) {
          return const ForgetPage();
        },
      ),
      GoRoute(
        path: "/404",
        name: "404",
        builder: (BuildContext context, GoRouterState state) {
          return const ErrPage();
        },
      ),
      GoRoute(
        path: "/setting",
        name: "setting",
        builder: (BuildContext context, GoRouterState state) {
          return const SettingPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) => _redirect(context,state));

  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    final isAuthenticated = await context.read<AuthService>().isAuthenticated;
    if (isAuthenticated) {
      return null;
    }
    var path = state.fullPath;
    if (!_openPage.contains(path)) {
      return '/login';
    }
    return null;
  }
