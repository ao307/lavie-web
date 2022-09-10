import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/auth_button.dart';
import 'package:lavie_web/modules/cart_screen/cart_screen_widgets/cart_item.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/image_assets.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/cubit/products_cubit/products_cubit.dart';
import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/components/widgets.dart';
import '../../shared/cubit/products_cubit/products_states.dart';
import '../../shared/themes/colors.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsCubit productsCubit = ProductsCubit.get(context);
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BaseWidget(
          child: productsCubit.listOfDataCart.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingLarge * 2),
                      child: Text(
                        'my cart'.tr().toTitleCase(),
                        style: const TextStyle(
                          fontSize: textSizeLarge * 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: paddingLarge,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ListView.separated(
                                itemCount: productsCubit.listOfDataCart.length,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: paddingLarge,
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: paddingLarge,
                                ),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        CartItem(
                                  counter: productsCubit.cartCount[index],
                                  model: productsCubit.listOfDataCart[index],
                                  addFun: () =>
                                      productsCubit.addDataCartFun(index),
                                  minFun: () =>
                                      productsCubit.minusDataCartFun(index),
                                  delete: () =>
                                      productsCubit.clearItemCart(index),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: paddingLarge,
                            ),
                            Expanded(
                              child: Container(
                                height: screenH(context) * .4,
                                padding: const EdgeInsetsDirectional.all(
                                    paddingLarge),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(borderRadiusSmall),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF5A5959)
                                          .withOpacity(0.1),
                                      offset: const Offset(12.0, 12.0),
                                      blurRadius: 60.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: const [
                                    CheckOutRow(
                                      title: "sub title",
                                      subTitle: "500 EGP",
                                    ),
                                    SizedBox(
                                      height: paddingMedium,
                                    ),
                                    CheckOutRow(
                                      title: "shipping",
                                      subTitle: "0.00 EGP",
                                    ),
                                    MyDivider(),
                                    CheckOutRow(
                                      title: "total",
                                      subTitle: "200 EGP",
                                      subTitleColored: true,
                                    ),
                                    SizedBox(
                                      height: paddingLarge,
                                    ),
                                    AuthButton(text: 'checkout', height: 40),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              :  EmptyWidget(
                  title: "your cart is empty",
                  subTitle:
                      "sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
            image: ImagesInAssets.basketImage,
                  child: Column(
                    children:const [
                      SizedBox(height: paddingLarge,),
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: AuthButton(
                          text: 'keep shopping',
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class CheckOutRow extends StatelessWidget {
  const CheckOutRow({
    Key? key,
    this.title,
    this.subTitle,
    this.subTitleColored = false,
  }) : super(key: key);
  final String? title;
  final String? subTitle;
  final bool? subTitleColored;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title".tr().toTitleCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textSizeMedium,
          ),
        ),
        Text(
          "$subTitle",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: subTitleColored == false
                ? MyColors.cTextSubtitleLight
                : MyColors.cPrimary,
            fontSize: textSizeMedium,
          ),
        ),
      ],
    );
  }
}
