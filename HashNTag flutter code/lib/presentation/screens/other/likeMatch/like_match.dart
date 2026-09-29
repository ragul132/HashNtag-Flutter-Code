
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating/core/config.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/presentation/firebase/chat_page.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/other/likeMatch/likematch_provider.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../language/localization/app_localization.dart';
import '../../BottomNavBar/home_screen.dart';


class LikeMatchScreen extends StatefulWidget {
  static const String likeMatchScreenRoute = "/likeMatchScreen";
  const LikeMatchScreen({Key? key}) : super(key: key);

  @override
  State<LikeMatchScreen> createState() => _LikeMatchScreenState();
}

class _LikeMatchScreenState extends State<LikeMatchScreen>
    with TickerProviderStateMixin {
  late LikeMatchProvider likeMatchProvider;
  late AnimationController controller;

  static const Color bg = Color(0xFF08050D);
  static const Color surface = Color(0xFF15101D);
  static const Color surface2 = Color(0xFF1D1427);
  static const Color border = Color(0xFF382642);
  static const Color pink = Color(0xFFFF4FA3);
  static const Color purple = Color(0xFF9B5CFF);
  static const Color textColor = Color(0xFFF8F2FA);
  static const Color muted = Color(0xFFB7AABD);

  @override
  void initState() {
    super.initState();
    likeMatchProvider = Provider.of<LikeMatchProvider>(context, listen: false);
    controller = AnimationController(vsync: this);
    if (likeMatchProvider.isHome && likeMatchProvider.likeMatchData.isNotEmpty) {
      likeMatchProvider.profileViewApi(
        uid: Provider.of<HomeProvider>(context, listen: false).uid,
        profileId: likeMatchProvider.likeMatchData.first.profileId,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    likeMatchProvider.likeMatchData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    likeMatchProvider = Provider.of<LikeMatchProvider>(context);

    if (likeMatchProvider.likeMatchData.isEmpty) {
      return const Scaffold(
        backgroundColor: bg,
        body: Center(
          child: CircularProgressIndicator(color: pink),
        ),
      );
    }

    final current = likeMatchProvider.likeMatchData[likeMatchProvider.interIndex];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        leading: const BackButtons(),
        backgroundColor: bg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Lottie.asset(
                "assets/Image/multiheart.json",
                controller: controller,
                repeat: true,
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(
                      const ['**', 'Red Heart Comp 1', '**'],
                      value: pink,
                    ),
                  ],
                ),
                onLoaded: (composition) {
                  controller
                    ..duration = const Duration(milliseconds: 4500)
                    ..forward().then((_) => controller.repeat());
                },
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: pink.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: pink.withOpacity(0.25)),
                        ),
                        child: const Text(
                          "IT'S A MATCH ✨",
                          style: TextStyle(
                            color: pink,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)
                                      ?.translate("You and ") ??
                                  "You and ",
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "${current.profileName}",
                              style: const TextStyle(
                                color: pink,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)
                                      ?.translate(" liked each other!") ??
                                  " liked each other!",
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    CarouselSlider(
                      items: [
                        for (int a = 0;
                            a < likeMatchProvider.likeMatchData.length;
                            a++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.28,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(70),
                                        bottomLeft: Radius.circular(70),
                                        topRight: Radius.circular(70),
                                      ),
                                      border: Border.all(
                                        color: pink.withOpacity(0.8),
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: pink.withOpacity(0.18),
                                          blurRadius: 24,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${Config.baseUrl}${Provider.of<HomeProvider>(context).userlocalData.userLogin!.otherPic.toString().split("\$;").first}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.28,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(70),
                                        topRight: Radius.circular(70),
                                        bottomRight: Radius.circular(70),
                                      ),
                                      border: Border.all(
                                        color: purple.withOpacity(0.75),
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: purple.withOpacity(0.18),
                                          blurRadius: 24,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${Config.baseUrl}${current.profileImages.first}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                      options: CarouselOptions(
                        enableInfiniteScroll:
                            likeMatchProvider.likeMatchData.length != 1,
                        onPageChanged: (i, r) {
                          if (likeMatchProvider.isHome) {
                            likeMatchProvider.profileViewApi(
                              uid: Provider.of<HomeProvider>(
                                context,
                                listen: false,
                              ).uid,
                              profileId:
                                  likeMatchProvider.likeMatchData[i].profileId,
                            );
                          }
                          likeMatchProvider.upDateinnerindex(i);
                        },
                        viewportFraction: 1,
                        autoPlay: likeMatchProvider.likeMatchData.length > 1,
                      ),
                    ),
                    Container(
                      height: 88,
                      width: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [pink, purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: pink.withOpacity(0.30),
                            blurRadius: 26,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: surface,
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 58,
                                width: 58,
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  backgroundColor: muted.withOpacity(0.18),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(pink),
                                  value: double.parse(
                                    "0.${current.matchRatio.toString().split(".").first}",
                                  ),
                                ),
                              ),
                              Text(
                                "${current.matchRatio.toString().split(".").first}%",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (likeMatchProvider.likeMatchData.length > 1)
                      Positioned(
                        bottom: -32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              likeMatchProvider.likeMatchData.length,
                              (index) => Indicator(
                                isActive:
                                    likeMatchProvider.interIndex == index,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [
                      _buildGradientButton(
                        context: context,
                        title: AppLocalizations.of(context)
                                ?.translate("Send a message") ??
                            "Send a message",
                        iconpath: "assets/icons/chattingIcon.svg",
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChattingPage(
                                resiverUserId: current.profileId,
                                resiverUseremail: current.profileName,
                                proPic: current.profileImages.first,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildOutlineButton(
                        context: context,
                        title: AppLocalizations.of(context)
                                ?.translate("Keep Swiping") ??
                            "Keep Swiping",
                        iconpath: "assets/icons/swiping.svg",
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton({
    required BuildContext context,
    required String title,
    required String iconpath,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [pink, purple],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: pink.withOpacity(0.20),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconpath,
                    height: 22,
                    width: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required BuildContext context,
    required String title,
    required String iconpath,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Material(
        color: surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: border),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(iconpath, height: 22, width: 22, colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn)),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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
