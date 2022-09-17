import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lavie_web/modules/auth_screens/auth_screen.dart';
import 'package:lavie_web/modules/profile_screen/profile_widgets/images_and_profile_name.dart';
import 'package:lavie_web/modules/profile_screen/profile_widgets/point_container.dart';
import 'package:lavie_web/modules/profile_screen/profile_widgets/profile_list_tile.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/image_assets.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/cubit/auth_cubit/auth_cubit.dart';
import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/components/tap_bar_reuse.dart';
import '../../shared/components/widgets.dart';
import '../../shared/cubit/forums_cubit/forums_cubit.dart';
import '../../shared/cubit/profile_cubit/profile_cubit.dart';
import '../../shared/cubit/profile_cubit/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = ProfileCubit.get(context);

    return FutureBuilder(
      future: profileCubit.getProfileData(),
      builder: (context, snapshot) {
        return BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final profileModel = profileCubit.profileDataModel;
            if (snapshot.connectionState == ConnectionState.waiting &&
                profileModel == null) {
              return const LoadingPage();
            } else if (snapshot.hasError || profileModel == null) {
              return const ErrorPage();
            }
            return BaseWidget(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: paddingLarge * 1.5,
                    ),
                    child: Text(
                      'my profile'.tr().toTitleCase(),
                      style: const TextStyle(
                        fontSize: textSizeLarge * 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TapBarReUse(
                      initialIndex: profileCubit.indexOfProfileTap,
                      listOfTabsText: profileCubit.profileText,
                      listOfViewsBody: profileCubit.profileBody,
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      tabBarHPadding: paddingLarge*2,
                      onChange: (index) =>
                          profileCubit.changeIndexOfProfileTap(index),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
