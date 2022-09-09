import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/notification_screen/notification_item/notification_item.dart';
import 'package:lavie_web/shared/components/constants.dart';
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
              return const LoadingPage(
              );
            } else if (snapshot.hasError || profileModel == null) {
              return const ErrorPage(
              );
            }
            return BaseWidget(
              child: profileModel.data!.userNotification!.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: paddingLarge * 5,
                      ),
                      itemCount: profileModel.data!.userNotification!.length,
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
                    )
                  : const EmptyWidget(
                    subTitle: "no notification yet.",
                  ),
            );
          },
        );
      },
    );
  }
}
