import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/create_post_screen/create_posts_widgets/add_post_button.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/components/widgets.dart';
import 'package:lavie_web/shared/cubit/forums_cubit/forums_states.dart';
import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/cubit/forums_cubit/forums_cubit.dart';
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
        return Stack(
          children: [
            BaseWidget(
              child: Container(
                width: screenW(context),
                padding: const EdgeInsets.all(paddingLarge),
                child: SingleChildScrollView(
                  child: Form(
                    key: forumsCubit.postKey,
                    child: Column(
                      children: [
                        if (forumsCubit.imagesBase64.isEmpty)
                          FetchPostImageButton(
                            onTap: () async {
                              await forumsCubit.pickImageForums();
                            },
                          )
                        else
                          SizedBox(
                            height: screenH(context)*.3,
                            child: InkWell(
                              onTap: () {
                                forumsCubit.pickImageForums();
                              },
                              child: Image.memory(
                                base64Decode(
                                  forumsCubit.imagesBase64[0],
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: paddingLarge * 1.5),
                        AuthTextFormField(
                          textEditingController:
                              forumsCubit.titleTextEditingController,
                          labelText: 'title',
                          hintText: '',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'title is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: paddingLarge * 1.5),
                        AuthTextFormField(
                          textEditingController:
                              forumsCubit.descriptionTextEditingController,
                          labelText: 'description',
                          hintText: '',
                          maxLines: 4,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'description is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: paddingLarge * 1.5),
                        AuthButton(
                          text: "post",
                          onPressed: () {
                            if (forumsCubit.postKey.currentState!.validate()) {
                              if (forumsCubit.imagesBase64.isNotEmpty) {
                                forumsCubit.createForums();
                              } else {
                                showToast(msg: 'image is required');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is CreateForumsLoadingState) const LoadingScreen(),
          ],
        );
      },
    );
  }
}
