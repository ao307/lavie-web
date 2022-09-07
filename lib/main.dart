import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lavie_web/layout/home_layout/home_layout.dart';
import 'package:lavie_web/layout/web_base_tab/web_base_tab.dart';
import 'package:lavie_web/modules/auth_screens/auth_screen.dart';
import 'package:lavie_web/shared/api/remote/dio_helper.dart';
import 'package:lavie_web/shared/bloc_observer.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/cubit/auth_cubit/auth_cubit.dart';
import 'package:lavie_web/shared/cubit/cubit.dart';
import 'package:lavie_web/shared/cubit/forums_cubit/forums_cubit.dart';
import 'package:lavie_web/shared/cubit/products_cubit/products_cubit.dart';
import 'package:lavie_web/shared/cubit/profile_cubit/profile_cubit.dart';
import 'package:lavie_web/shared/cubit/scan_cubit/scan_cubit.dart';
import 'package:lavie_web/shared/cubit/states.dart';
import 'package:lavie_web/shared/themes/themes.dart';


Widget startScreenDoctor = const AuthScreen();

Future<void> startScreen() async {
  await Hive.initFlutter();
  final box = await Hive.openBox(boxName);
  // dark mode
  final isDark = await box.get(isDarkBox);
  AppCubit.isDark = isDark ?? false;
  //
  refreshTokenConst = await box.get(refreshTokenBox);
  accessTokenConst = await box.get(accessTokenBox);
  userIdConst = await box.get(userIdBox);
  if (refreshTokenConst != null &&
      accessTokenConst != null &&
      userIdConst != null) {
    startScreenDoctor = HomeLayout();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await EasyLocalization.ensureInitialized();
  await startScreen();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  EasyLocalization.logger.enableBuildModes = [];
  // TODO: preview mode
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'EG'),
      ],
      path: 'assets/translation',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProductsCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => ForumsCubit()),
        BlocProvider(create: (context) => ScanCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            builder: (context, child) => BaseWidget(
              child: child,
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: AppCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: startScreenDoctor,
          );
        },
      ),
    );
  }
}


// class PersistentWidget extends StatelessWidget {
//   const PersistentWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40.0,
//       margin: const EdgeInsets.all(10.0),
//       decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           gradient: LinearGradient(colors: [Colors.yellow, Colors.redAccent])),
//       child: const Center(
//         child: Text(
//           'Tap to know about our exciting new offer!',
//           style: TextStyle(
//               fontSize: 16.0,
//               color: Colors.white70,
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
