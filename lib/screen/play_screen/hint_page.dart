
import 'dart:ui';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:maths_puzzle/common_widget/background_image.dart';
import 'package:maths_puzzle/screen/play_screen/play_page.dart';
import 'package:maths_puzzle/services/pref_service.dart';
import 'package:maths_puzzle/utils/asset_res.dart';
import 'package:maths_puzzle/utils/color_res.dart';
import 'package:maths_puzzle/utils/pref_res.dart';
import 'package:maths_puzzle/utils/string_res.dart';

class HintPage extends StatefulWidget {
  final int index;
  final int hint;

  const HintPage({super.key, required this.index, required this.hint});

  @override
  State<HintPage> createState() => _HintPageState();
}

class _HintPageState extends State<HintPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double toolBarH = MediaQuery.of(context).padding.top;
    double topPadding = AppBar().preferredSize.height;
    double bottomBarH = MediaQuery.of(context).padding.bottom;
    double totalh = h - toolBarH - bottomBarH - topPadding;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          PrefService.setValue(key: PrefRes.hintTotal, value: widget.hint-1);
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => PlayPage(index: widget.index),
            ),
          );
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: commonBackgroundImage(
            Container(
              height: h,
              // decoration: BoxDecoration(),

//--------------------------------------Blur Page------------------------------
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40,
                  sigmaY: 40,
                ),
                child: Container(
                  height: h,
                  decoration: BoxDecoration(
                    color: ColorRes.transparent,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
//--------------------------------------Hint Board------------------------------
                      Center(
                        child: DropShadowImage(
                          offset: Offset(15, 15),
                          blurRadius: 20,
                          image: Image.asset(
                            AssetRes.banner,
                            height: totalh * 0.4,
                          ),
                        ),
                      ),

//--------------------------------------Hint Icon------------------------------
                      Positioned(
                        top: totalh * 0.27,
                        child: Container(
                          height: totalh * 0.13,
                          width: totalh * 0.13,
                          child: Image.asset(
                            AssetRes.hint,
                            fit: BoxFit.fill,
                          ),
                        ),
                        // commonAssetImage(AssetRes.hint, totalh * 0.2),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
//--------------------------------------Hint Left------------------------------
                          Text(
                            'HINT LEFT : ${widget.hint}',
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: totalh * 0.02),

//--------------------------------------Level Number------------------------------
                          Text(
                            'LEVEL : ${widget.index + 1}',
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: totalh * 0.02),

//--------------------------------------Hint Answer------------------------------
                          Text(
                            'ANSWER : ${StringRes.ans[widget.index]}',
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
