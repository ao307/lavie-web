// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:lavie_web/shared/components/reuse_functions.dart';
// import 'package:lavie_web/shared/cubit/cubit.dart';
// import 'package:lavie_web/shared/cubit/states.dart';
// import 'package:lavie_web/shared/themes/colors.dart';
//
// import '../../modules/products_screen/products_screen.dart';
//
// class HomeLayout extends StatelessWidget {
//   HomeLayout({Key? key}) : super(key: key);
//   final PageController controllerPage = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (BuildContext context, Object? state) {
//         return Scaffold(
//           extendBody: true,
//           body: PageView(
//             physics: const NeverScrollableScrollPhysics(),
//             controller: controllerPage,
//             children: cubit(context).screens,
//           ),
//           bottomNavigationBar: AnimatedBottomNavigationBar(
//             icons: const [
//               FontAwesomeIcons.leaf,
//               FontAwesomeIcons.qrcode,
//               IconlyBold.notification,
//               IconlyBold.profile,
//             ],
//             iconSize: 28,
//             activeIndex: cubit(context).currentIndexOfBottom,
//             gapLocation: GapLocation.center,
//             backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
//             notchSmoothness: NotchSmoothness.verySmoothEdge,
//             activeColor: MyColors.cPrimary,
//             onTap: (index) {
//               cubit(context).changeIndex(index);
//               controllerPage.animateToPage(
//                 index,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//           ),
//           floatingActionButton: ClipRRect(
//             borderRadius: BorderRadius.circular(30),
//             child: FloatingActionButton(
//               heroTag: "homeLayout",
//               onPressed: () {
//                 navigateTo(context: context, widget: const ProductsScreen());
//               },
//               child: const FaIcon(
//                 IconlyLight.home,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerDocked,
//         );
//       },
//     );
//   }
// }
