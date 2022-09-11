import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';

import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/themes/colors.dart';

// TODO: blog product
class ScanProductScreen extends StatelessWidget {
  const ScanProductScreen({
    Key? key,
    this.imageUrl = "",
    this.name = "",
    this.description = "",
  }) : super(key: key);
  final String? imageUrl;
  final String? name;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: paddingLarge * 4,
                top: paddingLarge * 1.5,
                start: paddingLarge,
                end: paddingLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl!.isNotEmpty
                        ? "$baseApiUrl$imageUrl"
                        : errorProfileImage,
                    height: screenH(context) * .5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: paddingLarge,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$name",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: textSizeLarge,
                        ),
                      ),
                      const SizedBox(
                        height: paddingMedium,
                      ),
                      Text(
                        "$description",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: textSizeMedium,
                          color: MyColors.cTextSubtitleLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: MyColors.cTextSubtitleLight.withOpacity(.1),
              height: 200,
            ),

          ],
        ),
      ),
    );
  }
}

class ItemProductScan extends StatelessWidget {
  const ItemProductScan({
    Key? key,
    this.icon,
    this.numberText,
    this.titleText,
  }) : super(key: key);
  final IconData? icon;
  final String? titleText;
  final String? numberText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.all(paddingSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black.withOpacity(0.64),
          ),
          child: Icon(
            icon,
            color: MyColors.cTextSubtitleLight,
            size: 40,
          ),
        ),
        const SizedBox(
          width: paddingSmall,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$numberText",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "$titleText".tr().toTitleCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
