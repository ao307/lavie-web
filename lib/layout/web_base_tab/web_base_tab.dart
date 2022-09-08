import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/shared/components/image_assets.dart';
import 'package:lavie_web/shared/cubit/cubit.dart';

import '../../modules/auth_screens/auth_widgets/ritch_text_button_.dart';
import '../../modules/forums_screen/forums_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/reuse_functions.dart';
import '../../shared/cubit/states.dart';

class BaseWidget extends StatelessWidget {
  final Widget? child;

  const BaseWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: paddingLarge,
                end: paddingLarge,
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
                            if (index == 4) {
                              showToast(msg: 'msg');
                            }
                          } ,
                        ),
                      ),
                    ),
                  ),
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
          ),
          body: Column(
            children: [
              Expanded(child: child!),
            ],
          ),
        );
      },
    );
  }
}
