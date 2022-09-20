import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/themes/colors.dart';

import '../../../models/blogs_model.dart';

class BlogsPlantItem extends StatelessWidget {
  const BlogsPlantItem({
    Key? key,
    required this.model,
    this.onTap,
  }) : super(key: key);
  final BlogsPlants? model;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5A5959).withOpacity(0.1),
              offset: const Offset(12.0, 12.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // product image
            AspectRatio(
              aspectRatio: 2,
              child: CachedNetworkImage(
                imageUrl: model!.imageUrl!.isNotEmpty
                    ? baseApiUrl + model!.imageUrl!
                    : errorProfileImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            // product name && price && counter
            Padding(
              padding: const EdgeInsetsDirectional.all(paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (model!.name ?? '').toCapitalized(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    model!.description ?? "",
                    style: const TextStyle(
                      color: MyColors.cTextSubtitleLight,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
