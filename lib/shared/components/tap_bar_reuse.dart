import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/themes/colors.dart';

class TapBarReUse extends StatelessWidget {
  final int? initialIndex;
  final List<String>? listOfTabsText;
  final List<Widget>? listOfViewsBody;
  final Function(int)? onChange;
  final TabBarIndicatorSize? tabBarIndicatorSize;
  final double? tabBarHPadding;

  const TapBarReUse({
    Key? key,
    required this.initialIndex,
    this.tabBarHPadding,
    required this.listOfTabsText,
    required this.listOfViewsBody,
    required this.onChange,
    this.tabBarIndicatorSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainedTabBarView(
      initialIndex: initialIndex!,
      tabBarProperties: TabBarProperties(
        indicatorSize: tabBarIndicatorSize ?? TabBarIndicatorSize.tab,
        height: 100,
        isScrollable: true,
        padding: EdgeInsets.symmetric(
          horizontal: tabBarHPadding ?? paddingMedium,
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: paddingMedium,
        ),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: textSizeLarge,
          height: 4,
        ),
        unselectedLabelColor: MyColors.cTextSubtitleLight,
      ),
      tabs: List.generate(
        listOfTabsText!.length,
        (index) => Text(
          listOfTabsText![index].tr().toTitleCase(),
          style: TextStyle(
            color: initialIndex == index ? MyColors.cPrimary : Colors.black,
          ),
        ),
      ),
      views: List.generate(
        listOfTabsText!.length,
        (index) => listOfViewsBody![index],
      ),
      onChange: onChange,
    );
  }
}
