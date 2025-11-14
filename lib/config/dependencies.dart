import 'package:imio_flutter/data/services/auth_service.dart';
import 'package:imio_flutter/data/services/auth_service_impl.dart';
import 'package:imio_sdk_lite/imio.dart';
import 'package:imio_sdk_lite/options.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/apis/auth_api_client.dart';
import '../data/services/shared_preferences_service.dart';


List<SingleChildWidget> get providers {
  return [
    // ChangeNotifierProvider.value(value:AppStore(context:context)),
    // Provider.value(value: () {
    //   var client = IMIOClient.getInstance();
    //   logger.warning("=== imio init ===");
    //   return client;
    // }),
    Provider<IMIOClient>(
        lazy: false,
        create: (context) {
          print("===================== imio init ===");
      IMIOClient client = IMIOClient.getInstance();
      var clientOptions = IMIOClientOptions();
      clientOptions.appId = 121;
      clientOptions.host = "localhost:8000";
      // clientOptions.host = "114.67.110.86:8000";
      clientOptions.debug = true;
      client.init(clientOptions);
      return client;
    }),
    Provider(create: (context) => AuthApiClient()),
    Provider(create: (context) => SharedPreferencesService()),
    ChangeNotifierProvider(
      create: (context) => AuthServiceImpl(
        client: context.read<IMIOClient>(),
        authApiClient: context.read(),
        sharedPreferencesService: context.read(),
      ) as AuthService,
    ),
  ];
}
