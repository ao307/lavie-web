import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/auth_button.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/auth_text_form_field.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/ritch_text_button_.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/image_assets.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/themes/colors.dart';

import '../../../shared/components/widgets.dart';
import '../../../shared/cubit/auth_cubit/auth_cubit.dart';
import '../../../shared/cubit/auth_cubit/auth_states.dart';
import '../auth_widgets/social_auth_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: authCubit.loginForm,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: screenW(context) * .14,
                end: screenW(context) * .14,
              ),
              child: Column(
                children: [
                  const SizedBox(height: paddingSmall),
                  // email text field
                  AuthTextFormField(
                    labelText: 'email',
                    hintText: 'enter your email',
                    textEditingController: authCubit.loginEmailController,
                    validator: (value) {
                      return validateEmail(value);
                    },
                  ),
                  // password text field && forgot password button
                  AuthTextFormField(
                    labelText: 'password',
                    hintText: 'enter your password',
                    obscure: authCubit.isPassword,
                    textEditingController: authCubit.loginPasswordController,
                    suffixIcon: IconButton(
                      icon: FaIcon(
                        authCubit.isPassword
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                      ),
                      onPressed: () {
                        authCubit.changePasswordVisibility();
                      },
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter your password'.tr().toCapitalized();
                      }
                      return null;
                    },
                    // forgot password button
                    underWidget: Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: ReuseTextButton(
                        text: 'forgot password?'.tr(),
                        isSelected: true,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  // login button
                  Padding(
                    padding: const EdgeInsets.only(
                      top: paddingMedium,
                    ),
                    child: AuthButton(
                      onPressed: () {
                        if (authCubit.loginForm.currentState!.validate()) {
                          authCubit.loginFun();
                        }
                      },
                      text: 'login'.tr().toUpperCase(),
                    ),
                  ),
                  // or
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: paddingLarge * 2,
                      vertical: paddingLarge * 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: MyColors.cTextSubtitleLight,
                            height: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: paddingSmall,
                          ),
                          child: Text(
                            'or continue with'.tr(),
                            style: const TextStyle(
                              color: MyColors.cPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: MyColors.cTextSubtitleLight,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // social button
                  Wrap(
                    children: [
                      SizedBox(
                        width: screenW(context) * .25,
                        child: ReuseOutLinedButton(
                          onPressed: () {},
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImagesInAssets.googleImage,
                                width: 30,
                              ),
                              const SizedBox(
                                width: paddingMedium,
                              ),
                              Expanded(
                                child: Text(
                                  'google'.tr().toCapitalized(),
                                  style: const TextStyle(
                                    color: MyColors.cPrimary,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: paddingLarge,
                      ),
                      SizedBox(
                        width: screenW(context) * .25,
                        child: ReuseOutLinedButton(
                          onPressed: () {},
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.facebook,
                                color: MyColors.cFacebookColor,
                              ),
                              const SizedBox(
                                width: paddingMedium,
                              ),
                              Expanded(
                                child: Text(
                                  'facebook'.tr().toCapitalized(),
                                  style: const TextStyle(
                                    color: MyColors.cPrimary,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: paddingSmall),
                        child: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
