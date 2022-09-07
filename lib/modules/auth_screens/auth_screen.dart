import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/background_leaves.dart';
import 'package:lavie_web/modules/auth_screens/body/login_body.dart';
import 'package:lavie_web/modules/auth_screens/body/signup_body.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/themes/colors.dart';

import '../../layout/home_layout/home_layout.dart';
import '../../shared/components/widgets.dart';
import '../../shared/cubit/auth_cubit/auth_cubit.dart';
import '../../shared/cubit/auth_cubit/auth_states.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState || state is SignUpSuccessState) {
          navigateAndFinish(context: context, widget: HomeLayout());
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: Stack(
            children: [
              BackLeaves(
                child: Padding(
                  padding:  const EdgeInsetsDirectional.only(
                    top: paddingLarge,
                  ),
                  child: ContainedTabBarView(
                    initialIndex: authCubit.indexOfTap,
                    tabBarProperties: TabBarProperties(
                      indicatorSize: TabBarIndicatorSize.label,
                      padding: EdgeInsetsDirectional.only(
                        start: screenW(context) * .14,
                        end: screenW(context) * .14,
                      ),
                    ),
                    tabs: [
                      Text(
                        'sign up'.tr().toTitleCase(),
                        style: authCubit.indexOfTap == 0
                            ? const TextStyle(
                                color: MyColors.cPrimary,
                                fontSize: textSizeLarge,
                                fontWeight: FontWeight.bold,
                              )
                            : const TextStyle(
                                color: Colors.black,
                                fontSize: textSizeLarge,
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                      Text(
                        'login'.tr().toTitleCase(),
                        style: authCubit.indexOfTap == 1
                            ? const TextStyle(
                                color: MyColors.cPrimary,
                                fontSize: textSizeLarge,
                                fontWeight: FontWeight.bold,
                              )
                            : const TextStyle(
                                color: Colors.black,
                                fontSize: textSizeLarge,
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                    ],
                    views:const [
                      SignUpBody(),
                      LoginBody(),
                    ],
                    onChange: (index) => authCubit.changeIndexOfTap(index),
                  ),
                ),
              ),
              if (state is SignUpLoadingState || state is LoginLoadingState)
                const LoadingScreen(),
            ],
          ),
        );
      },
    );
  }
}
