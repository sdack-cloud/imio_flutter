


import 'package:flutter/material.dart';
import 'package:imio_sdk_lite/imio.dart';
import 'package:logging/logging.dart';
final logger = Logger("ContactViewModel");

class ContactViewModel extends ChangeNotifier {
  ContactViewModel({required IMIOClient imioClient}):
      _imioClient = imioClient;

  IMIOClient _imioClient;

  void test () {
    var close = _imioClient.isClose();
    var deviceKey = _imioClient.deviceKey();
    var deviceTag = _imioClient.deviceTag();

    logger.warning("imioClient:",close);
    logger.warning("imioClient device=",deviceKey + deviceTag);
  }

}