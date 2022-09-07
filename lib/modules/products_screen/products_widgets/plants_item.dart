import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lavie_web/modules/products_screen/products_widgets/products_counter.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import '../../../models/products_model.dart';
import '../../../shared/themes/colors.dart';
import '../../auth_screens/auth_widgets/auth_button.dart';

class PlantsGridItem extends StatelessWidget {
  const PlantsGridItem({
    Key? key,
    required this.data,
    required this.count,
    this.addFun,
    this.minusFun,
    this.addToCart,
  }) : super(key: key);
  final ProductData? data;
  final int? count;
  final Function? addFun;
  final Function? minusFun;
  final Function()? addToCart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // to make top space
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: AspectRatio(
            aspectRatio: .85,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(borderRadiusMedium),
                ),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.cUnSelectedIconLight.withOpacity(0.09),
                    offset: const Offset(0, 2.0),
                    blurRadius: 18.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        // padding of all content in grid item
        Padding(
          padding: const EdgeInsetsDirectional.only(
            bottom: paddingMedium,
            start: paddingSmall,
            end: paddingSmall,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: CachedNetworkImage(
                        imageUrl: data!.imageUrl!.isNotEmpty
                            ? "$baseApiUrl${data!.imageUrl}"
                            : plantsErrorImage,
                      ),
                    ),
                  ),
                  //counter
                  Padding(
                    padding: const EdgeInsets.only(top: paddingLarge * 2),
                    child: ProductCounter(
                      count: count ?? 0,
                      addFunction: addFun,
                      minusFunction: minusFun,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // product name
                  Text(
                    data!.name!.toTitleCase(),
                    style: const TextStyle(
                      fontSize: textSizeSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // product subtitle
                  Text(
                    "${data!.price ?? 0} EGP",
                    style: const TextStyle(
                      fontSize: textSizeSmall,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: paddingSmall,
                  ),
                  AuthButton(
                    onPressed: count != 0
                        ? addToCart
                        : () {
                      showToast(msg: 'select count');
                    },
                    text: 'buy',
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
