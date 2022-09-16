import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/components/widgets.dart';
import 'package:lavie_web/shared/cubit/forums_cubit/forums_states.dart';
import '../../shared/cubit/forums_cubit/forums_cubit.dart';
import '../../shared/themes/colors.dart';
import '../auth_screens/auth_widgets/auth_button.dart';
import '../auth_screens/auth_widgets/auth_text_form_field.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ForumsCubit forumsCubit = ForumsCubit.get(context);
    return BlocConsumer<ForumsCubit, ForumsStates>(
      listener: (context, state) {
        if (state is CreateForumsSuccessState) {
          Navigator.pop(context);
        } else if (state is CreateForumsErrorState) {
          showToast(msg: 'check your internet');
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            if (state is CreateForumsLoadingState)
              const CircularProgressIndicator.adaptive(),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: paddingLarge * 2,
                end: paddingLarge * 2,
                bottom: paddingLarge * 2,
              ),
              child: Form(
                key: forumsCubit.postKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'create a new post'.tr().toTitleCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: textSizeLarge * 1.4,
                        color: MyColors.cPrimary,
                      ),
                    ),
                    const SizedBox(height: paddingLarge * 1.2),
                    AuthTextFormField(
                      textEditingController:
                          forumsCubit.titleTextEditingController,
                      labelText: 'title',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'title is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: paddingLarge * 1.2),
                    AuthTextFormField(
                      textEditingController:
                          forumsCubit.descriptionTextEditingController,
                      labelText: 'description',
                      maxLines: 4,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'description is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: paddingLarge * 1.2),
                    AuthTextFormField(
                      textEditingController:
                          forumsCubit.updateTextEditingController,
                      labelText: 'update photo',
                      readOnly: true,
                      suffixIcon: SizedBox(
                        width: 180,
                        child: AuthButton(
                          text: "update photo",
                          onPressed: () {
                            forumsCubit.pickImageForums();
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'photo is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: paddingLarge * 1.2),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenW(context) * .15,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ReuseOutLinedButton(
                              txt: "cancel",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: paddingLarge,
                          ),
                          Expanded(
                            child: AuthButton(
                              text: "post",
                              onPressed: () {
                                if (forumsCubit.postKey.currentState!
                                    .validate()) {
                                  if (forumsCubit.imagesBase64.isNotEmpty) {
                                    forumsCubit.createForums();
                                  } else {
                                    showToast(msg: 'image is required');
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
