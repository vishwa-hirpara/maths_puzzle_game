import 'package:flutter/material.dart';
import 'package:maths_puzzle/utils/asset_res.dart';

Widget commonBackgroundImage(Widget child) {
  return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetRes.background),
          fit: BoxFit.fill,
        ),
      ),
      child: child);
}
