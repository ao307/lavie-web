import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lavie_web/shared/components/image_assets.dart';
import 'package:lavie_web/shared/cubit/cubit.dart';
import 'package:popover/popover.dart';
import '../../modules/auth_screens/auth_widgets/ritch_text_button_.dart';
import '../../modules/cart_screen/cart_screen.dart';
import '../../modules/notification_screen/notification_screen.dart';
import '../../modules/profile_screen/profile_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/responsive.dart';
import '../../shared/components/reuse_functions.dart';
import '../../shared/cubit/states.dart';

class BaseWidget extends StatelessWidget {
  final Widget? child;

  const BaseWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCubit = AppCubit.get(context);
    //  AppCubit.notificationShow = false;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: Responsive.isMobile(context) != true
              ? null
              : AppBar(
                  title: Image.asset(
                    ImagesInAssets.logoImage,
                    width: 100,
                  ),
                  centerTitle: true,
                ),
          body: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                children: [
                  if (Responsive.isMobile(context) != true)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: paddingLarge,
                            end: paddingLarge,
                            top: paddingSmall,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                ImagesInAssets.logoImage,
                                width: 100,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    appCubit.appBarTitles.length,
                                    (index) => ReuseTextButton(
                                      text: appCubit.appBarTitles[index],
                                      isSelected:
                                          index == appCubit.currentIndexOfTitle,
                                      onPressed: () {
                                        appCubit.changeIndexOfTitle(
                                            index, context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              if (accessTokenConst != null)
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        navigateTo(
                                          context: context,
                                          widget: const MyCartScreen(),
                                        );
                                      },
                                      icon: const Icon(
                                        IconlyBroken.buy,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        appCubit.changeNotificationShow();
                                      },
                                      icon: const Icon(
                                        IconlyBroken.notification,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        navigateAndFinish(
                                            context: context,
                                            widget: const ProfileScreen());
                                      },
                                      icon: const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          errorProfileImage,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Image.asset(
                                  ImagesInAssets.logoImage,
                                  width: 100,
                                ),
                              // Visibility(
                              //   visible: false,
                              //   child: ElevatedButton(
                              //     onPressed: () {},
                              //     style: ButtonStyle(
                              //       backgroundColor: MaterialStateProperty.all(
                              //         MyColors.cPrimary,
                              //       ),
                              //       shape: MaterialStateProperty.all(
                              //         RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(
                              //             borderRadiusMedium,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     child: const Text('sign up',style:TextStyle(
                              //       color: Colors.white,
                              //     ),),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: paddingMedium,
                        ),
                      ],
                    ),
                  Expanded(child: child!),
                ],
              ),
              if (AppCubit.notificationShow &&
                  Responsive.isMobile(context) != true)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    GestureDetector(
                      onTap: () {
                        appCubit.changeNotificationShow();
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(paddingLarge * 3),
                      child: Container(
                        height: 400,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(borderRadiusMedium),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF757373).withOpacity(0.5),
                              offset: const Offset(0, 4),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: const NotificationScreen(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('Entry B')),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[300],
              child: const Center(child: Text('Entry C')),
            ),
          ],
        ),
      ),
    );
  }
}
