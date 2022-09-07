import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/ritch_text_button_.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/themes/colors.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final bool? obscure;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? underWidget;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText!.tr().toTitleCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: textSizeLarge,
            color: MyColors.cTextSubtitleLight,
          ),
        ),
        const SizedBox(
          height: paddingSmall,
        ),
        TextFormField(
          controller: textEditingController,
          keyboardType: keyboardType,
          obscureText: obscure ?? false,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: maxLines,
          decoration: InputDecoration(
            // hintText: "$hintText".tr().toCapitalized(),
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusMedium),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: paddingMedium,vertical: paddingLarge,),
            hintStyle: const TextStyle(
              color: MyColors.cTextSubtitleLight,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
        const SizedBox(
          height: paddingSmall,
        ),
        if (underWidget != null)
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: ReuseTextButton(
              text: 'forgot password?'.tr(),
              onPressed: () {},
            ),
          ),
      ],
    );
  }

  const AuthTextFormField({
    Key? key,
    this.textEditingController,
    this.keyboardType,
    this.validator,
    this.obscure,
    required this.hintText,
    required this.labelText,
    this.suffixIcon,
    this.underWidget,
    this.maxLines=1,
  }) : super(key: key);
}
