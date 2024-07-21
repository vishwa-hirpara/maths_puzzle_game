import 'package:flutter/material.dart';
import 'package:maths_puzzle/common_widget/asset_image.dart';
import 'package:maths_puzzle/common_widget/background_image.dart';
import 'package:maths_puzzle/common_widget/number_container.dart';
import 'package:maths_puzzle/common_widget/text.dart';
import 'package:maths_puzzle/screen/play_screen/hint_page.dart';
import 'package:maths_puzzle/screen/win_screen/win_page.dart';
import 'package:maths_puzzle/services/pref_service.dart';
import 'package:maths_puzzle/utils/asset_res.dart';
import 'package:maths_puzzle/utils/color_res.dart';
import 'package:maths_puzzle/utils/pref_res.dart';
import 'package:maths_puzzle/utils/string_res.dart';


class PlayPage extends StatefulWidget {
  final int index;

  const PlayPage({super.key, required this.index});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  String number = '';
  int level = 0;
  int hint = 0;
  List<String> levelData = [];
  List<int> hintData = [];
  bool isFirst = false;
  bool msg = true;

  @override
  void initState() {
    // TODO: implement initState
    level = widget.index;
    super.initState();
  }

  void onTapSubmit() {
    if (level % 5 == 0) {
      int hint = PrefService.getInt(PrefRes.hintTotal);
      PrefService.setValue(key: PrefRes.hintTotal, value: hint + 1);
    }

    if (StringRes.ans[level] == number) {
      List<String> levelData = [];
      levelData = PrefService.getStringList(PrefRes.levelData);
      if (levelData.isEmpty) {
        levelData = List.generate(AssetRes.levelList.length, (index) => "");
      }
      levelData[level] = "win";
      PrefService.setValue(key: PrefRes.levelData, value: levelData);
      int levelComplete = PrefService.getInt(PrefRes.level);
      if (levelComplete == level) {
        PrefService.setValue(key: PrefRes.level, value: level + 1);
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WinPage(
            index: level,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorRes.coffee,
          duration: Duration(seconds: 2),
          content: Text(
            'YOUR ANSWER IS WRONG',
            style: TextStyle(
              color: ColorRes.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );
    }
  }

  void skip() {
    //PrefService.setValue(key: PrefRes.level, value: level+1);
    List<String> levelData = [];
    levelData = PrefService.getStringList(PrefRes.levelData);
    if (levelData.isEmpty) {
      levelData = List.generate(AssetRes.levelList.length, (index) => "");
    }
    levelData[level] = "";
    PrefService.setValue(key: PrefRes.levelData, value: levelData);
    int levelComplete = PrefService.getInt(PrefRes.level);
    if (levelComplete == level) {
      PrefService.setValue(key: PrefRes.level, value: level + 1);
    }
    level++;
    setState(() {});
  }

  void onTap(String value) {
    number += value;
    // print(number);
    setState(() {});
  }

  void removeNumber() {
    if (number.isNotEmpty) {
      number = number.substring(0, number.length - 1);
      // print(number);
    }
    setState(() {});
  }

  void hintCount() {
    int totalHint = PrefService.getInt(PrefRes.hintTotal);
    if (totalHint > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HintPage(
            index: level,
            hint: totalHint,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorRes.coffee,
          duration: Duration(seconds: 2),
          content: Text(
            'YOUR HINT IS 0',
            style: TextStyle(
              color: ColorRes.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );
    }
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
        Column(
          children: [
            SizedBox(
              height: totalh * 0.08,
            ),

            //-----------------------------level number board-------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
//--------------------------------------Hint Btn------------------------------
                GestureDetector(
                  onTap: () => hintCount(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      commonAssetImage(AssetRes.next, totalh * 0.09),
                      commonAssetImage(AssetRes.hint, totalh * 0.05),
                    ],
                  ),
                ),

//--------------------------------------Level Number------------------------------
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: w * 0.5,
                      child: commonAssetImage(AssetRes.name, totalh * 0.08),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: totalh * 0.08,
                      width: w * 0.5,
                      child: commonText('LEVEL ${level + 1}'),
                    ),
                  ],
                ),

//--------------------------------------Skip Btn------------------------------
                GestureDetector(
                  onTap: skip,
                  child: commonAssetImage(AssetRes.next, totalh * 0.09),
                ),
              ],
            ),
            SizedBox(height: totalh * 0.08),

            //-----------------------------task board-------------------------------
            Container(
              height: totalh * 0.5,
              padding: EdgeInsets.all(20),
              child: Image.asset(AssetRes.levelList[level]),
            ),
            SizedBox(height: totalh * 0.035),

            //-----------------------------number write-------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  height: totalh * 0.06,
                  width: w * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: ColorRes.white,
                      width: 3,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        number,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorRes.white,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                ),

//--------------------------------------Remove Btn------------------------------
                GestureDetector(
                  onTap: removeNumber,
                  child: Image.asset(
                    AssetRes.back,
                    width: w * 0.2,
                  ),
                ),
              ],
            ),
            SizedBox(height: totalh * 0.03),

            //-----------------------------number btn-------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () => onTap('1'),
                    child: commonNumberContainer(
                        totalh * 0.045, totalh * 0.045, '1')),
                GestureDetector(
                  onTap: () => onTap('2'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '2'),
                ),
                GestureDetector(
                  onTap: () => onTap('3'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '3'),
                ),
                GestureDetector(
                  onTap: () => onTap('4'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '4'),
                ),
                GestureDetector(
                  onTap: () => onTap('5'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '5'),
                ),
                GestureDetector(
                  onTap: () => onTap('6'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '6'),
                ),
                GestureDetector(
                  onTap: () => onTap('7'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '7'),
                ),
                GestureDetector(
                  onTap: () => onTap('8'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '8'),
                ),
                GestureDetector(
                  onTap: () => onTap('9'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '9'),
                ),
                GestureDetector(
                  onTap: () => onTap('0'),
                  child: commonNumberContainer(
                      totalh * 0.045, totalh * 0.045, '0'),
                ),
              ],
            ),
            SizedBox(height: totalh * 0.025),

            //-----------------------------submit btn-------------------------------

            GestureDetector(
              onTap: onTapSubmit,
              child: Container(
                width: totalh * 0.25,
                height: totalh * 0.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetRes.name),
                  ),
                ),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: ColorRes.coffee),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
