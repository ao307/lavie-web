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
import '../../shared/components/widgets.dart';
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
              child: Stack(
                children: [
                  SizedBox(
                    height: screenH(context) * .42,
                    child: ImagesAndProfileImage(
                      profileImage: profileModel.data!.imageUrl,
                      profileName:
                          "${profileModel.data!.firstName} ${profileModel.data!.lastName}",
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: screenH(context) * .62,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(borderRadiusLarge),
                          topEnd: Radius.circular(borderRadiusLarge),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            bottom: paddingLarge * 4,
                            top: paddingLarge * 1.5,
                            start: paddingMedium,
                            end: paddingMedium,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              PointsContainer(
                                text:
                                    "you have ${profileModel.data!.userPoints ?? 0} points",
                                image: ImagesInAssets.pointsImage,
                              ),
                              const SizedBox(
                                height: paddingMedium,
                              ),
                              Text(
                                'edit profile'.tr().toTitleCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: textSizeLarge,
                                ),
                              ),
                              const SizedBox(
                                height: paddingMedium,
                              ),
                              const ProfileListTile(
                                title: "change name",
                                leadingIcon: IconlyBroken.edit,
                              ),
                              // orders
                              const ProfileListTile(
                                title: "change email",
                                leadingIcon: IconlyBroken.edit,
                              ),
                              // logout
                              ProfileListTile(
                                title: "logout",
                                leadingIcon: IconlyBroken.logout,
                                onTap: () {
                                  AuthCubit.get(context).logout(context);
                                  navigateAndFinish(
                                    context: context,
                                    widget: const AuthScreen(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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
