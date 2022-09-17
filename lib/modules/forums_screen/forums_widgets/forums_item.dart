import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lavie_web/models/forums_model.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import '../../../shared/themes/colors.dart';
import '../../profile_screen/profile_widgets/profile_image_name.dart';


class ForumsItem extends StatelessWidget {
  final ForumData? forums;
  final VoidCallback? onPressedLike;
  final VoidCallback? onPressedComment;

  const ForumsItem({
    Key? key,
    required this.forums,
    this.onPressedLike,
    this.onPressedComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? like() {
      for (final bigElement in forums!.forumLikes!) {
        if (bigElement.userId == userIdConst) {
          return true;
        }
      }
      return false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingLarge*2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF757373).withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsetsDirectional.only(
                start: paddingMedium,
                end: paddingMedium,
                top: paddingMedium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileImageName(
                    image: forums!.user!.imageUrl,
                    name: "${forums!.user!.firstName} ${forums!.user!.lastName}",
                    time: 'time',
                  ),
                  const SizedBox(
                    height: paddingMedium,
                  ),
                  SelectableText(
                    (forums!.title ?? '').toTitleCase(),
                    style: const TextStyle(
                      color: MyColors.cPrimary,
                      fontSize: textSizeMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: paddingSmall - 2,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: paddingSmall,
                    ),
                    child: SelectableText(
                      (forums!.description ?? '').toCapitalized(),
                      style: const TextStyle(
                        fontSize: textSizeSmall + 1,
                        color: MyColors.cTextSubtitleLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: paddingMedium,
                  ),
                ],
              ),
            ),
            if (forums!.imageUrl != null)
              AspectRatio(
                aspectRatio: 16 / 6,
                child: CachedNetworkImage(
                  imageUrl: forums!.imageUrl != null
                      ? baseApiUrl + forums!.imageUrl!
                      : errorProfileImage,
                  errorWidget: (context, imageUrl, error) {
                    return Center(
                      child: Text(
                        'not found in server'.tr().toTitleCase(),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onPressedLike,
                    icon: Row(
                      children: [
                        Icon(
                          Icons.thumb_up_outlined,
                          color: like() == true
                              ? MyColors.cPrimary
                              : MyColors.cTextSubtitleLight,
                        ),
                        const SizedBox(width: paddingSmall),
                        Text(
                          '${forums!.forumLikes!.length}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: like() == true
                                ? MyColors.cPrimary
                                : MyColors.cTextSubtitleLight,
                          ),
                        ),
                        const SizedBox(width: paddingSmall),
                        Text(
                          'likes'.tr().toTitleCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: like() == true
                                ? MyColors.cPrimary
                                : MyColors.cTextSubtitleLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onPressedComment,
                    icon: Row(
                      children: [
                        const SizedBox(width: paddingSmall),
                        Text(
                          '${forums!.forumComments!.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.cTextSubtitleLight,
                          ),
                        ),
                        const SizedBox(width: paddingSmall),
                        Text(
                          'replies'.tr().toTitleCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.cTextSubtitleLight,
                          ),
                        ),
                      ],
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


