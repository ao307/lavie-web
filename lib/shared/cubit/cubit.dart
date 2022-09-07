// ignore_for_file: type_annotate_public_apis

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/profile_screen/profile_screen.dart';
import 'package:lavie_web/shared/api/local/app_box.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/cubit/states.dart';

import '../../modules/forums_screen/forums_screen.dart';
import '../../modules/notification_screen/notification_screen.dart';
import '../../modules/scan_screen/scan_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const ForumsScreen(),
    ScanScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  static bool isDark = false;

  void changeThem() {
    isDark = !isDark;
    AppBox.box.put(isDarkBox, isDark);
    emit(AppChangeThemeState());
  }

  int currentIndexOfBottom = 0;

  Future<void> changeIndex(int index) async {
    currentIndexOfBottom = index;
    emit(AppChangeBottomNavBarState());
  }



  // web
  List<String> appBarTitles = [
    "home",
    "shop",
    "blog",
    "about",
    "community",
  ];
  int currentIndexOfTitle = 0;

  Future<void> changeIndexOfTitle(int index) async {
    currentIndexOfTitle = index;
    emit(AppChangeTitleBar());
  }

}
