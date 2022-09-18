import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/themes/colors.dart';

import '../../layout/web_base_tab/web_base_tab.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/products_model.dart';
import '../../shared/cubit/products_cubit/products_cubit.dart';
import '../../shared/cubit/products_cubit/products_states.dart';
import '../auth_screens/auth_widgets/auth_button.dart';
import '../products_screen/products_widgets/products_counter.dart';

// ignore: must_be_immutable
class SingleProductScreen extends StatelessWidget {
  SingleProductScreen({
    Key? key,
    required this.productData,
  }) : super(key: key);
  final ProductData? productData;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        printFullText(screenW(context).toString());
        return BaseWidget(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: paddingLarge * 4,
              top: paddingLarge * 4,
              start: screenW(context) * .05,
            ),
            child: Row(
              children: [
                Container(
                  width: screenW(context) * .4,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF757373).withOpacity(0.5),
                        offset: const Offset(0, 4),
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                      borderRadiusLarge,
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        productData!.imageUrl!.isNotEmpty
                            ? "$baseApiUrl${productData!.imageUrl!}"
                            : plantsErrorImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: paddingLarge * 2,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // price and name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (productData!.name ?? '').toTitleCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: textSizeLarge,
                              ),
                            ),
                            Text(
                              '${productData!.price ?? 0} EGP',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: textSizeMedium,
                                color: MyColors.cPrimary,
                              ),
                            ),
                          ],
                        ),
                        if (productData!.plant != null)
                          Row(
                            children: [
                              StaticItem(
                                title: "sun light",
                                percent:
                                    "${productData!.plant!.sunLight ?? 0}%",
                                icon: FontAwesomeIcons.sun,
                                iconColor: const Color(0xFFFFE87C),
                              ),
                              StaticItem(
                                title: "water",
                                percent:
                                    "${productData!.plant!.waterCapacity ?? 0}%",
                                icon: FontAwesomeIcons.water,
                                iconColor: MyColors.cFacebookColor,
                              ),
                              StaticItem(
                                title: "temperature",
                                percent:
                                    "${productData!.plant!.temperature ?? 0}c",
                                icon: FontAwesomeIcons.temperatureFull,
                                iconColor: MyColors.cErrorColor,
                              ),
                            ],
                          ),
                        // information
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'information'.tr().toTitleCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.cTextSubtitleLight,
                                fontSize: textSizeMedium,
                              ),
                            ),
                            Text(
                              (productData!.description ?? "").toCapitalized(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.cTextSubtitleLight,
                                fontSize: textSizeMedium,
                              ),
                            ),
                          ],
                        ),
                        // quantity
                        Row(
                          children: [
                            Text(
                              "qty:".toCapitalized(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: textSizeMedium,
                              ),
                            ),
                            const SizedBox(
                              width: paddingMedium,
                            ),
                            ProductCounter(
                              count: count,
                              addFunction: () {
                                if (count < 9) {
                                  count++;
                                }
                                ProductsCubit.get(context).anyState();
                              },
                              minusFunction: () {
                                if (count > 1) {
                                  count--;
                                }
                                ProductsCubit.get(context).anyState();
                              },
                            ),
                          ],
                        ),
                        // add to cart button
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: paddingLarge*2),
                          child: AuthButton(
                            onPressed: () {
                              ProductsCubit.get(context).addToCart(
                                DataCard(
                                  cartCount: count,
                                  imageUrl: productData!.imageUrl,
                                  name: productData!.name,
                                  price: productData!.price,
                                  productId: productData!.productId,
                                ),
                              );
                            },
                            text: 'buy',
                          ),
                        ),
                      ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsetsDirectional.only(
                                bottom: paddingLarge * 2,
                              ),
                              child: e,
                            ),
                          )
                          .toList(),
                    ),
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

class StaticItem extends StatelessWidget {
  const StaticItem({
    Key? key,
    this.percent,
    this.icon,
    this.title,
    this.iconColor,
  }) : super(key: key);
  final String? percent;
  final String? title;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: paddingMedium,
      ),
      child: Container(
        padding: const EdgeInsetsDirectional.all(
          paddingLarge,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          color: const Color(0xFF1ABC00).withOpacity(0.05),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$percent ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textSizeMedium,
                  ),
                ),
                Icon(
                  icon,
                  size: iconSizeSmall,
                  color: iconColor,
                ),
              ],
            ),
            Text(
              '$title'.tr().toTitleCase(),
            ),
          ],
        ),
      ),
    );
  }
}
