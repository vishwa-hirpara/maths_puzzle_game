import 'package:flutter/cupertino.dart';
import 'package:maths_puzzle/utils/asset_res.dart';
import 'package:maths_puzzle/utils/color_res.dart';

Widget commonNumberContainer(double imageH, double textH, String number) {
  return Stack(
    children: [
      Container(
        alignment: Alignment.center,
        child: Image.asset(
          AssetRes.number,
          height: imageH,
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: textH,
        child: Row(
          children: [
            SizedBox(width: 12),
            Text(
              number,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorRes.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
