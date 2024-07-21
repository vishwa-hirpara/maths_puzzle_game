import 'package:flutter/material.dart';

Widget commonAssetImage(String imageName, double h,) {
  return Image.asset(
    imageName,
    height: h,
  );
}
