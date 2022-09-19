import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/shared/cubit/quiz_cubit/quiz_cubit.dart';

import '../../layout/web_base_tab/footter_widget.dart';
import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/image_assets.dart';
import '../../shared/components/reuse_functions.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/quiz_cubit/quiz_states.dart';
import '../../shared/cubit/states.dart';
import '../../shared/themes/colors.dart';
import '../auth_screens/auth_widgets/auth_button.dart';
import '../quiz_screen/quiz_screen.dart';
import '../quiz_screen/quiz_widgets/home_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (BuildContext context, Object? state) {
        return BaseWidget(
          child: HomeBackground(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // image && explore
                    SizedBox(
                      height: screenH(context) * .9,
                      child: Row(
                        children: [
                          Image.asset(
                            ImagesInAssets.treeInHomeImage,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenW(context) * .15,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'perfect way to plant in house'
                                        .tr()
                                        .toTitleCase(),
                                    style: const TextStyle(
                                      fontSize: textSizeLarge,
                                      color: MyColors.cPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'leaf, in botany, any usually flattened green outgrowth from the stem of a vascular plant. As the primary sites of photosynthesis, leaves manufacture food for plants, which in turn ultimately nourish and sustain all land animals.'
                                        .tr()
                                        .toTitleCase(),
                                    style: const TextStyle(
                                      fontSize: textSizeMedium,
                                      color: MyColors.cTextSubtitleLight,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: paddingMedium),
                                  const SizedBox(
                                    width: 200,
                                    child: AuthButton(
                                      text: "explore now",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: paddingLarge * 3,
                    ),
                    // about us
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: paddingLarge * 3,
                        vertical: paddingLarge * 3,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'about us'.tr().toTitleCase(),
                                  style: const TextStyle(
                                    fontSize: textSizeLarge * 1.4,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Welcome to La Vie, your number one source for planting. We're dedicated to giving you the very best of plants, with a focus on dependability, customer service and uniqueness. Founded in 2020, La Vie has come a long way from its beginnings in a  home office our passion for helping people and give them some advices about how to plant and take care of plants. We now serve customers all over Egypt, and are thrilled to be a part of the eco-friendly wing "
                                      .tr()
                                      .toCapitalized(),
                                  style: const TextStyle(
                                    fontSize: textSizeMedium,
                                    color: MyColors.cTextSubtitleLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  top: 15,
                                ),
                                child: Container(
                                  width: 300.0,
                                  height: 300.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      borderRadiusMedium,
                                    ),
                                    border: Border.all(
                                      width: 1.4,
                                      color: MyColors.cPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 15,
                                ),
                                child: Container(
                                  width: 300,
                                  height: 285,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      borderRadiusMedium,
                                    ),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        ImagesInAssets.aboutImage,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // mobile application section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: paddingLarge * 3,
                        vertical: paddingLarge * 3,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImagesInAssets.mobileApplicationImage,
                            width: screenW(context) * .4,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.all(paddingLarge * 2),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'mobile application'.tr().toTitleCase(),
                                    style: const TextStyle(
                                      fontSize: textSizeLarge * 1.4,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "You can install La Vie mobile application and enjoy with new features, earn more points and get discounts \nAlso you can scan QR codes in your plants’ pots so that you can get discount on everything in the website up to 70%"
                                        .tr()
                                        .toCapitalized(),
                                    style: const TextStyle(
                                      fontSize: textSizeMedium,
                                      color: MyColors.cTextSubtitleLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // footer
                    const FooterWidget(),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(paddingLarge*2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FloatingActionButton(
                    onPressed: () {
                      navigateTo(
                        context: context,
                        widget: const QuizScreen(),
                      );
                    },
                    heroTag: "home",
                    tooltip: "Answer some questions and get points",
                    child: const Icon(Icons.question_mark_outlined,color: Colors.white,size: 28,),
                  ),
                ),
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.endTop,
            ),
          ),
        );
      },
    );
  }
}
