// ignore_for_file: unsafe_html

import 'dart:html' as html;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';

import '../../shared/components/image_assets.dart';
import '../../shared/themes/colors.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.cTextSubtitleLight.withOpacity(.1),
      padding: const EdgeInsets.all(paddingLarge * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // logo column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImagesInAssets.logoImage,
                  width: 90,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'LA VIE ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.cPrimary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "We're dedicated to giving you the very best of plants, with a focus on dependability",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.cTextSubtitleLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: paddingLarge * 4,
          ),
          // sections column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TitleOfFooter(txt: 'sections'),
                SubTitleOfFooter(
                  txt: 'home',
                ),
                SubTitleOfFooter(
                  txt: 'category',
                ),
                SubTitleOfFooter(
                  txt: 'new',
                ),
                SubTitleOfFooter(
                  txt: 'request to be seller',
                ),
              ],
            ),
          ),
          const SizedBox(
            width: paddingLarge * 4,
          ),
          // contact us
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TitleOfFooter(txt: 'contact us'),
                SubTitleOfFooter(
                  txt: 'phone: 01155368336',
                ),
                SubTitleOfFooter(
                  txt: 'phone: 01155368336',
                ),
                SubTitleOfFooter(
                  txt: "email: aowork307@gmail.com",
                ),
                SubTitleOfFooter(
                  txt: 'address: shoubra al-khema, giza, egypt',
                ),
              ],
            ),
          ),
          const SizedBox(
            width: paddingLarge * 4,
          ),
          // sign up for news
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleOfFooter(txt: "our social"),
                const SizedBox(
                  height: paddingSmall,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () async {
                        html.window
                            .open("https://facebook.com/ao30.7/", "_blank");
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.facebook,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        html.window
                            .open("https://instagram.com/ao30.7/", "_blank");
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.instagram,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        html.window
                            .open("https://twitter.com/AAhlawy14/", "_blank");
                        //launchUrlFun("https://twitter.com/AAhlawy14/");
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.twitter,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleOfFooter extends StatelessWidget {
  const TitleOfFooter({Key? key, required this.txt}) : super(key: key);
  final String? txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$txt'.tr().toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: MyColors.cPrimary,
        fontSize: textSizeMedium,
      ),
    );
  }
}

class SubTitleOfFooter extends StatelessWidget {
  const SubTitleOfFooter({Key? key, required this.txt}) : super(key: key);
  final String? txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$txt'.tr().toTitleCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: MyColors.cTextSubtitleLight,
        height: 2,
      ),
    );
  }
}
