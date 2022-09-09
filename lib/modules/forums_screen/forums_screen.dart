import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/forums_screen/search_screen/search_forums_screen.dart';
import 'package:lavie_web/modules/products_screen/products_widgets/search_text_form.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/cubit/forums_cubit/forums_cubit.dart';

import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/components/tap_bar_reuse.dart';
import '../../shared/components/widgets.dart';
import '../../shared/cubit/forums_cubit/forums_states.dart';
import '../create_post_screen/create_post_screen.dart';

class ForumsScreen extends StatelessWidget {
  const ForumsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ForumsCubit forumsScreenCubit = ForumsCubit.get(context);
    return BlocConsumer<ForumsCubit, ForumsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BaseWidget(
          child: Row(
            children: [
              Expanded(
                child: TapBarReUse(
                  initialIndex: forumsScreenCubit.indexOfForumsTap,
                  listOfTabsText: forumsScreenCubit.forumsText,
                  listOfViewsBody: forumsScreenCubit.forumsBody,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  onChange: (index) =>
                      forumsScreenCubit.changeIndexOfForumsTap(index),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: paddingLarge * 4,
                ),
                child: Container(
                  color: Colors.transparent,
                  width: screenW(context) * .3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: paddingMedium,
                    ),
                    child: Column(
                      children: [
                        SearchTextFormField(
                          hintText: 'search',
                          readOnly: true,
                          onTap: () {
                            navigateTo(
                              context: context,
                              widget: const SearchForumsScreen(),
                            );
                          },
                        ),
                        const SizedBox(height: paddingLarge,),
                        ReuseOutLinedButton(
                          txt: "create post",
                          onPressed: () {
                            navigateTo(context: context, widget: const CreatePostScreen());

                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
