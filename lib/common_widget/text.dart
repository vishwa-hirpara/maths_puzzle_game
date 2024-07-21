import 'package:flutter/material.dart';
import 'package:maths_puzzle/utils/color_res.dart';

//----------------------------Level Text-----------------------------

Widget commonText(String level) {
  return Text(
    level,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: ColorRes.coffee,
      fontSize: 24,
    ),
  );
}


