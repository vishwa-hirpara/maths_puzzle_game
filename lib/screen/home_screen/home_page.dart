import 'package:flutter/material.dart';
import 'package:maths_puzzle/common_widget/asset_image.dart';
import 'package:maths_puzzle/common_widget/background_image.dart';
import 'package:maths_puzzle/screen/play_screen/play_page.dart';
import 'package:maths_puzzle/screen/puzzles_screen/puzzles_page.dart';
import 'package:maths_puzzle/services/pref_service.dart';
import 'package:maths_puzzle/utils/asset_res.dart';
import 'package:maths_puzzle/utils/color_res.dart';
import 'package:maths_puzzle/utils/pref_res.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int level = 0;

  void initState() {
    hintStore();
    // TODO: implement initState
    super.initState();
  }

  void hintStore() {
    bool isStoreHint = PrefService.getBool(PrefRes.isHintStore);
    if (!isStoreHint) {
      PrefService.setValue(key: PrefRes.isHintStore, value: true);
      PrefService.setValue(key: PrefRes.hintTotal, value: 5);
    }
  }

  void goToStart() {
    level = PrefService.getInt(PrefRes.level);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayPage(
          index: level,
        ),
      ),
    );
  }

  void onShare() {
    Share.share('check out my website https://example.com');
  }



  Future<void> onTapEmail() async {
    final url = Uri.parse('https://mail.google.com/mail/u/0/#inbox');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Gmail';
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: totalh * 0.15),

//-----------------------------maths puzzle board-------------------------------
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 100,
              ),
              child: Image.asset(AssetRes.math),
            ),
//-----------------------------start puzzles buy_Pro btn-------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 70),
              child: Column(
                children: [
//--------------------------------------Start Btn------------------------------
                  GestureDetector(
                    onTap: goToStart,
                    child: Image.asset(AssetRes.start),
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
                    child: Image.asset(AssetRes.puzzels),
                  ),

//--------------------------------------Buy Pro Btn------------------------------
                  Image.asset(AssetRes.buy),
                ],
              ),
            ),
            Spacer(),

//-----------------------------share privacy_policy mail btn-------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
//--------------------------------------Share Btn------------------------------
                InkWell(
                  onTap: onShare,
                  child: commonAssetImage(
                    AssetRes.share,
                    totalh * 0.09,
                  ),
                ),

//--------------------------------------Privacy Policy Btn------------------------------
                OutlinedButton(
                  style: ButtonStyle(
                    fixedSize:
                        MaterialStatePropertyAll(Size(w * 0.43, totalh * 0.06)),
                    side: MaterialStatePropertyAll<BorderSide>(
                      BorderSide(
                        color: ColorRes.white,
                        width: 2,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Privacy Policy'.toUpperCase(),
                    style: TextStyle(
                      // fontFamily: 'chalk',
                      color: ColorRes.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

//--------------------------------------Mail Btn------------------------------
                InkWell(onTap: onTapEmail,child: commonAssetImage(AssetRes.mail, totalh * 0.09),),
              ],
            ),
            SizedBox(height: totalh * 0.04),
          ],
        ),
      ),
    );
  }
}
