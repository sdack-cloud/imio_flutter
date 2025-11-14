import 'dart:ui';

import 'package:flutter/material.dart';

class SizeFit {

  static double physicalHeight = 0;
  static double physicalWidth = 0;
  static double screeWidth = 0;
  static double screeHeight = 0;
  static double dpr = 0;
  static double rpx = 0;
  static double px = 0;
  static double hrpx = 0;
  static double hpx = 0;
  static double statusHeight = 0;

  static void initialize({double standardSize = 750}){
    physicalHeight = window.physicalSize.height;
    physicalWidth = window.physicalSize.width;
    dpr = window.devicePixelRatio;
    screeWidth = physicalWidth / dpr;
    screeHeight = physicalHeight / dpr;
    print("分辨率--$physicalHeight--$physicalWidth");
    print("宽高----$screeWidth--$screeHeight");

    statusHeight = window.padding.top;

    print("dpr----$dpr");
    rpx = screeWidth / standardSize;
    px = screeWidth / standardSize * 2;
    print("rpx----$rpx");
    hrpx = screeHeight / standardSize;
    hpx = screeHeight / standardSize * 2;
    print("hrpx----$hrpx");
  }

  static double setRpx(double size) {
    return rpx * size;
  }

  static double setPx(double size) {
    return px * size;
  }

  static double setHRpx(double size) {
    return hrpx * size;
  }

  static double setHPx(double size) {
    return hpx * size;
  }


}



extension DoubleFit on double {

  double get px {
    return SizeFit.setPx(this);
  }
  double get rpx {
    return SizeFit.setRpx(this);
  }
  double get hpx {
    return SizeFit.setHPx(this);
  }
  double get hrpx {
    return SizeFit.setHRpx(this);
  }

}


extension IntFit on int {
  double get px {
    return SizeFit.setPx(this.toDouble());
  }
  double get rpx {
    return SizeFit.setRpx(this.toDouble());
  }
  double get hpx {
    return SizeFit.setHPx(this.toDouble());
  }
  double get hrpx {
    return SizeFit.setHRpx(this.toDouble());
  }



}


Widget toast(String text) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: Colors.grey[350]!.withOpacity(0.5),
  ),
  child:Text(text),

);
