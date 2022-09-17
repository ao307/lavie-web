import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lavie_web/modules/notification_screen/notification_item/notification_item.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/cubit/cubit.dart';
import 'package:lavie_web/shared/cubit/states.dart';
import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/components/widgets.dart';
import '../../shared/cubit/profile_cubit/profile_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = ProfileCubit.get(context);
    return FutureBuilder(
      future: profileCubit.getProfileData(),
      builder: (context, snapshot) {
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final profileModel = profileCubit.profileDataModel;
            if (snapshot.connectionState == ConnectionState.waiting &&
                profileModel == null) {
              return const LoadingPage();
            } else if (snapshot.hasError || profileModel == null) {
              return const ErrorPage();
            }
            return profileModel.data!.userNotification!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'notification'.tr().toTitleCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: textSizeMedium,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context).changeNotificationShow();
                              },
                              icon: const Icon(
                                IconlyBroken.closeSquare,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount:
                              profileModel.data!.userNotification!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const MyDivider(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(paddingSmall),
                              child: NotificationItem(
                                userNotification:
                                    profileModel.data!.userNotification![index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const EmptyWidget(
                    subTitle: "no notification yet.",
                  );
          },
        );
      },
    );
  }
}
