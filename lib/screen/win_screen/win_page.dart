import 'package:flutter/material.dart';
import 'package:maths_puzzle/common_widget/background_image.dart';
import 'package:maths_puzzle/screen/home_screen/home_page.dart';
import 'package:maths_puzzle/screen/play_screen/play_page.dart';
import 'package:maths_puzzle/screen/puzzles_screen/puzzles_page.dart';
import 'package:maths_puzzle/utils/asset_res.dart';
import 'package:maths_puzzle/utils/color_res.dart';

class WinPage extends StatefulWidget {
  final int index;

  const WinPage({super.key, required this.index});

  @override
  State<WinPage> createState() => _WinPageState();
}

class _WinPageState extends State<WinPage> {

  void nextLevel(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PlayPage(index: widget.index + 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double toolBarH = MediaQuery.of(context).padding.top;
    double topPadding = AppBar().preferredSize.height;
    double bottomBarH = MediaQuery.of(context).padding.bottom;
    double totalh = h - toolBarH - bottomBarH - topPadding;
    return Scaffold(
      body: commonBackgroundImage(
        Center(
          child: Padding(
            padding: EdgeInsets.all(25),

//--------------------------------------You win Image------------------------------
            child: Container(
              height: totalh * 0.78,
              width: w * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetRes.youWin,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
//--------------------------------------Win level Text------------------------------
                  SizedBox(
                    height: totalh * 0.15,
                    width: w * 0.5,
                    child: Text(
                      'COMPLETE LEVEL ${widget.index + 1}',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                    ),
                  ),

//--------------------------------------Next Level Btn------------------------------
                  GestureDetector(
                    onTap: nextLevel,
                    child: Image.asset(
                      AssetRes.nextLevel,
                      fit: BoxFit.fill,
                      height: totalh * 0.1,
                      width: w * 0.5,
                    ),
                  ),

//--------------------------------------Puzzles Btn------------------------------
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PuzzlesPage(),
                        ),
                      );
                    },
                    child: Image.asset(
                      AssetRes.puzzels,
                      fit: BoxFit.fill,
                      height: totalh * 0.1,
                      width: w * 0.5,
                    ),
                  ),

//--------------------------------------Home Page Btn------------------------------
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: Image.asset(
                      AssetRes.mainMenu,
                      fit: BoxFit.fill,
                      height: totalh * 0.1,
                      width: w * 0.5,
                    ),
                  ),
                  SizedBox(
                    height: totalh * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
