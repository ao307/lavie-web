import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/auth_button.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/components/image_assets.dart';
import '../../../shared/components/reuse_functions.dart';
import '../../../shared/cubit/profile_cubit/profile_cubit.dart';
import '../../../shared/cubit/profile_cubit/profile_states.dart';
import '../../auth_screens/auth_widgets/auth_text_form_field.dart';
import '../profile_widgets/point_container.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = ProfileCubit.get(context);

    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final profileModel = profileCubit.profileDataModel;
        return Form(
          key: profileCubit.personalInfoKey,
          child: ListView(
            padding: const EdgeInsetsDirectional.only(
              start: paddingLarge * 2,
              end: paddingLarge * 2,
              bottom: paddingLarge,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: paddingMedium,
                ),
                child: PointsContainer(
                  image: ImagesInAssets.pointsImage,
                  text:
                      "you have ${profileModel!.data!.userPoints ?? 0} points",
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AuthTextFormField(
                      labelText: 'first name',
                      textEditingController: profileCubit.firstNameInfo,
                      hintText: 'enter your first name',
                      validator: (value) {
                        return validateName(value, 'first');
                      },
                    ),
                  ),
                  const SizedBox(
                    width: paddingLarge * 2,
                  ),
                  Expanded(
                    child: AuthTextFormField(
                      textEditingController: profileCubit.lastNameInfo,
                      labelText: 'last name',
                      hintText: 'enter your last name',
                      validator: (value) {
                        return validateName(value, 'last');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: paddingMedium,
              ),
              Row(
                children: [
                  Expanded(
                    child: AuthTextFormField(
                      textEditingController: profileCubit.emailInfo,
                      labelText: 'email',
                      hintText: 'enter your email',
                      validator: (value) {
                        return validateEmail(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: paddingLarge * 2,
                  ),
                  Expanded(
                    child: AuthTextFormField(
                      textEditingController: profileCubit.imageUrlInfo,
                      labelText: 'image url',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "enter your image url";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: paddingMedium,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenW(context) * .38),
                child: AuthButton(
                  text: 'save',
                  onPressed: () {
                    if (profileCubit.personalInfoKey.currentState!.validate()) {
                      profileCubit.updateProfile();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
