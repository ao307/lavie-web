import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/themes/colors.dart';

class SocialAuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;
  final Color? textColor;
  final String? image;

  const SocialAuthButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        // gradient: const LinearGradient(
        //     colors: [Color(0xffffffff), Color(0xffffffff)]),
      ),
      child: SizedBox(
        width: double.infinity,
        height:40,
        child: ElevatedButton(
          style: ButtonStyle(
            // elevation: MaterialStateProperty.all(0),
            overlayColor:
            MaterialStateProperty.all(Colors.grey.withOpacity(.5)),
            alignment: Alignment.center,
            backgroundColor:
            MaterialStateProperty.all(color ?? Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusMedium),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image!, height: 20),
              const SizedBox(
                width: paddingSmall,
              ),
              Expanded(
                child: Text(
                  text.tr().toCapitalized(),
                  style: TextStyle(
                    color: textColor ?? MyColors.cPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
