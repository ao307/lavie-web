import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';

import '../../../shared/themes/colors.dart';

class SearchTextFormField extends StatelessWidget {
  final TextEditingController? textController;
  final String hintText;
  final GestureTapCallback? onTap;
  final bool? readOnly;
  final ValueChanged<String>? onChanged;

  const SearchTextFormField({
    this.textController,
    required this.hintText,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 10,
            color: Colors.grey.withOpacity(.1),
          ),
        ],
      ),
      child: TextFormField(
        controller: textController,
        onTap: onTap,
        readOnly: readOnly!,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
          ),
          filled: true,
          fillColor: MyColors.cTextSubtitleLight.withOpacity(.1),
          hintText: hintText.tr().toCapitalized(),
          hintStyle: const TextStyle(color: MyColors.cTextSubtitleLight),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
