import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lavie_web/shared/components/image_assets.dart';
import 'package:lavie_web/shared/cubit/cubit.dart';

import '../../modules/auth_screens/auth_widgets/ritch_text_button_.dart';
import '../../modules/cart_screen/cart_screen.dart';
import '../../shared/components/constants.dart';
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
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          appCubit.appBarTitles.length,
                          (index) => ReuseTextButton(
                            text: appCubit.appBarTitles[index],
                            isSelected: index == appCubit.currentIndexOfTitle,
                            onPressed: () {
                              appCubit.changeIndexOfTitle(index, context);
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
                            onPressed: () {},
                            icon: const Icon(
                              IconlyBroken.notification,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: CachedNetworkImageProvider(
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
              Expanded(child: child!),
            ],
          ),
        );
      },
    );
  }
}
