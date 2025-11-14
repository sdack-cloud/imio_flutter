import 'package:flutter/material.dart';
import 'package:imio_flutter/data/services/auth_service.dart';
import 'package:imio_sdk_lite/enum/client_status_enum.dart';
import 'package:imio_sdk_lite/imio.dart';
import 'package:imio_sdk_lite/listener/client_listener.dart';
import 'package:logging/logging.dart';
import 'package:imio_flutter/utils/size_fit.dart';

final logger = Logger("MeViewModel");

class MeViewModel extends ChangeNotifier implements IMIOClientListener{
  MeViewModel(
      {required IMIOClient imioClient, required AuthService authService})
      :
        _imioClient = imioClient,
        _authService = authService {
    // _imioClient.addClientListener()
  }

  IMIOClient _imioClient;
  AuthService _authService;

  String connStatus = "";

  String token1 = "eyJraWQiOiIyYWVjMmMwMy0zZWRiLTRhNTQtYjgzNy1mYjdmOWRhYTdlYzkiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxNTI5MTg1ODcwOTQiLCJhdWQiOiIxMjEiLCJuYmYiOjE3NjMwMDYzMDksInNjb3BlIjpbIm9wZW5pZCx1c2VyaW5mbyJdLCJpc3MiOiJodHRwOi8vMzkuMTAwLjcyLjE4MTo5MDAwIiwibmlja25hbWUiOiIiLCJsb2NrIjpmYWxzZSwiYWN0aXZlIjp0cnVlLCJleHAiOjE3NjMwNzgzMDksImlhdCI6MTc2MzAwNjMwOSwianRpIjoiNWQwZjgzYTctMTYzOS00N2Q5LTk3YTUtMTc0MWNlNWY2NGNlIiwiYWNjb3VudCI6IjE1MjkxODU4NzA5NCJ9.KGteJsgSXJ8aDYmkBuGovW0oHIyzNxKetePkuzPVV_pUgO5haaY6wANs16SHid1gjAEzYcWNUOa5PDMVEY22AaXCl8Guv7s5aalYhBIFqgI0e7v0HhrtmvTGXTr2L3ol5IqjnxbWEpCEEKKOK9wXQWoTbEUaCt64Xbm0yXJKfI2z473ZT0QyOih4x72K23Ysb6UJwULAyRm4C1c25LSAPypSK15D9sl_A_M4mxoI9L9SCTnKY2XQ3AUYZTISdiaLpb1iMsyXZhnh1P-59eaJ2d36MwRFKtMxsieUPrdaZxJGjW0WqzJCeThKu7-VPi20H6d5TBIMCOIkBOmkCubKuw";

  void conn() {
    var account = _authService!.account;
    if (_authService.token != null) {
      var token = _authService.token!.split(" ");
      _imioClient.connect(int.parse(account), token1);
    }
  }

  void ping() {
    _imioClient!.ping()
        .then((value) {
      logger.warning("Ping OK");
    })
        .catchError((e) {
          logger.warning(e.toString());
    });
  }

  void disconn() {
    _imioClient!.disconnect();
  }
  // ===== IMIOClientListener
  @override
  void onClientStatus(IMIOClientStatusEnum status, int retry) {
    connStatus = status.label;
    notifyListeners();
  }

  @override
  void onConnected() {
    logger.warning('Client onConnected');
  }

  @override
  void onShutdown() {
    logger.warning('Client onShutdown');
  }

  @override
  void onTokenExpired() {
    logger.warning('Client onTokenExpired');
  }
  // ==== IMIOClientListener
}