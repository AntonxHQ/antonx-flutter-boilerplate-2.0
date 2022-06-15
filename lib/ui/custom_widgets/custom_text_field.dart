import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final bool? obscure;
  final String? errorText;
  final String? hintText;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final validator;
  final double? fontSize;
  final String? label;
  final onSaved;
  final onTap;
  final bool disableBorder;
  final onChanged;
  CustomTextField(
      {this.controller,
      this.onTap,
      this.disableBorder = false,
      this.label,
      this.obscure = false,
      this.enabled = true,
      this.validator,
      this.errorText,
      this.fontSize = 15.0,
      this.hintText,
      this.onSaved,
      this.suffixIcon,
      @required this.prefixIcon,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
      enabled: enabled,
      // style: textStyleWithHacenFont.copyWith(
      // fontSize: this.fontSize, color: greyColor),
      // cursorColor: primaryColor,
      controller: this.controller,
      obscureText: this.obscure!,
      validator: validator ??
          (value) {
            if (value != null) {
              return this.errorText;
            } else {
              return null;
            }
          },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        // alignLabelWithHint: true,
        prefixIconConstraints: BoxConstraints(
//            maxHeight: 25.h,
//            maxWidth: 25.w,
            ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: prefixIcon!,
        ),
        suffixIcon: Padding(
            padding: const EdgeInsets.only(),
            child: suffixIcon != null ? suffixIcon : Container()),
        suffixIconConstraints: BoxConstraints(maxHeight: 40, maxWidth: 50),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(
              // color: disableBorder ? Colors.transparent : primaryColor,
              width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : Color(0XFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : Color(0XFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : Color(0XFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        contentPadding: EdgeInsets.only(
          left: 21.0,
        ),
        hintText: this.hintText,
//         hintStyle: textStyleWithHacenFont.copyWith(
// //              color: Color(0XFF686868),
//             color: Color(0XFFE4E4E4),
//             fontSize: fontSize),
//       ),
      ),
    );
  }
}
