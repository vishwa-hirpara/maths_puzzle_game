import 'package:flutter/material.dart';
import 'package:maths_puzzle/common_widget/asset_image.dart';
import 'package:maths_puzzle/common_widget/background_image.dart';
import 'package:maths_puzzle/screen/play_screen/play_page.dart';
import 'package:maths_puzzle/services/pref_service.dart';
import 'package:maths_puzzle/utils/asset_res.dart';
import 'package:maths_puzzle/utils/color_res.dart';
import 'package:maths_puzzle/utils/pref_res.dart';

class PuzzlesPage extends StatefulWidget {
  const PuzzlesPage({super.key});

  @override
  State<PuzzlesPage> createState() => _PuzzlesPageState();
}

class _PuzzlesPageState extends State<PuzzlesPage> {
  List<String> levelData = [];
  int level = 0;

  @override
  void initState() {
    // TODO: implement initState
    getPrefData();
    super.initState();
  }

  void getPrefData() {
    levelData = PrefService.getStringList(PrefRes.levelData);
    level = PrefService.getInt(PrefRes.level);
    if (levelData.isEmpty) {
      levelData = List.generate(AssetRes.levelList.length, (index) => "");
      PrefService.setValue(key: PrefRes.levelData, value: levelData);
    }
  }

  void onTap(index) {
    if (index <= level) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PlayPage(index: index),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double toolBarH = MediaQuery.of(context).padding.top;
    double topPadding = AppBar().preferredSize.height;
    double bottomBarH = MediaQuery.of(context).padding.bottom;
    double totalh = h - toolBarH - bottomBarH - topPadding;

    return Scaffold(
      body: commonBackgroundImage(
        Center(
          child: Column(
            children: [
              SizedBox(height: totalh * 0.06),

//--------------------------------------Puzzles Board------------------------------
              commonAssetImage(AssetRes.puzzels, totalh * 0.16),
              SizedBox(height: totalh * 0.02),

//--------------------------------------GridView Levels------------------------------
              Expanded(
                child: GridView.builder(
                  itemCount: AssetRes.levelList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: EdgeInsets.only(left: 10, right: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
//--------------------------------------Box Open Image------------------------------
                        InkWell(
                          onTap: () => onTap(index),
                          child: Container(
                            height: totalh * 0.15,
                            width: totalh * 0.15,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 15),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AssetRes.boxOpen),
                                  fit: BoxFit.fill),
                            ),
                            //--------------------------------------Level Number & Star------------------------------
                            child: Container(
                              height: totalh * 0.1,
                              width: totalh * 0.1,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 2, left: 5),
                              decoration: levelData[index] == "win"
                                  ? const BoxDecoration(
                                      //--------------------------------------Level Star------------------------------
                                      image: DecorationImage(
                                          image: AssetImage(AssetRes.star),
                                          fit: BoxFit.fill),
                                    )
                                  : null,

                              //--------------------------------------Level Number Text------------------------------
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: levelData[index] == "win"
                                      ? ColorRes.coffee
                                      : ColorRes.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

//--------------------------------------Box Close Image------------------------------
                        Positioned(
                          child: level >= index
                              ? const SizedBox()
                              : Image.asset(
                                  AssetRes.boxClose,
                                  height: totalh * 0.145,
                                ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
