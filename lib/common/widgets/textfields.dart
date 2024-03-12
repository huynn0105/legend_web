import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_mfast/common/enum/input_type.dart';
import 'package:legend_mfast/common/utils/text_util.dart';

import '../colors.dart';
import '../styles.dart';
import 'buttons.dart';
import 'images.dart';

class UITextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enable;
  final bool autoFocus;
  final bool isObscurePassword;
  final String? hintText;
  final String? labelText;
  final TextStyle? textStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? cursorColor;
  final EdgeInsets? contentPadding;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final InputType inputType;
  final bool hasError;
  final bool requiredField;
  final String? prefixText;
  final bool showBorder;

  const UITextField({
    Key? key,
    this.focusNode,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.enable = true,
    this.autoFocus = false,
    this.isObscurePassword = false,
    this.hintText,
    this.labelText,
    this.textStyle,
    this.labelTextStyle,
    this.hintTextStyle,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.cursorColor,
    this.contentPadding,
    this.textAlign = TextAlign.left,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.inputType = InputType.normal,
    this.hasError = false,
    this.requiredField = true,
    this.prefixText,
    this.showBorder = true,
  }) : super(key: key);

  const UITextField.dropdown({
    Key? key,
    this.focusNode,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.enable = true,
    this.autoFocus = false,
    this.isObscurePassword = false,
    this.hintText,
    this.labelText,
    this.textStyle,
    this.labelTextStyle,
    this.hintTextStyle,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.cursorColor,
    this.contentPadding,
    this.textAlign = TextAlign.left,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.inputType = InputType.dropdown,
    this.hasError = false,
    this.requiredField = true,
    this.prefixText,
    this.showBorder = true,
  }) : super(key: key);

  const UITextField.calendar({
    Key? key,
    this.focusNode,
    this.controller,
    this.onTap,
    this.readOnly = true,
    this.enable = true,
    this.autoFocus = false,
    this.isObscurePassword = false,
    this.hintText,
    this.labelText,
    this.textStyle,
    this.labelTextStyle,
    this.hintTextStyle,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.cursorColor,
    this.contentPadding,
    this.textAlign = TextAlign.left,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.inputType = InputType.calendar,
    this.hasError = false,
    this.requiredField = true,
    this.prefixText,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isObscurePassword,
      cursorColor: cursorColor ?? UIColors.primaryColor,
      style: textStyle ??
          UITextStyle.regular.copyWith(
            fontSize: 15,
          ),
      obscuringCharacter: '*',
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofocus: autoFocus,
      enabled: enable && !readOnly,
      readOnly: readOnly,
      textAlign: textAlign,
      onChanged: onChanged,
      autofillHints: null,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      maxLength: maxLength,
      onSubmitted: (value) {
        if (textInputAction == TextInputAction.next) {
          if (suffixIcon != null) {
            FocusScope.of(context).nextFocus();
          }
        }
        onSubmitted?.call(value);
      },
      onTap: onTap,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null || getSuffixIcon() != null
            ? Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            bottom: 8,
          ),
          child: suffixIcon ?? getSuffixIcon(),
        )
            : null,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ?? const EdgeInsets.only(bottom: 10),
        hintText: hintText,
        hintStyle: hintTextStyle ??
            UITextStyle.regular.copyWith(
              fontSize: 14,
              color: UIColors.defaultText.withOpacity(0.4),
            ),
        label: TextUtils.isNotEmpty(labelText)
            ? Text.rich(
          TextSpan(
            text: '$labelText ',
            children: <InlineSpan>[
              if (requiredField)
                TextSpan(
                  text: '*',
                  style: labelTextStyle?.copyWith(
                    color: UIColors.red.withOpacity(enable ? 1 : 0.4),
                    height: 1,
                  ) ??
                      UITextStyle.regular.copyWith(
                        color: UIColors.red.withOpacity(enable ? 1 : 0.4),
                        height: 1,
                        fontSize: 16,
                      ),
                ),
            ],
            style: labelTextStyle ??
                UITextStyle.regular.copyWith(
                  height: 1,
                  fontSize: 15,
                  color: UIColors.grayText.withOpacity(enable ? 1 : 0.4),
                ),
          ),
        )
            : null,
        prefixText: prefixText,
        alignLabelWithHint: true,
        enabledBorder: !showBorder
            ? InputBorder.none
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: hasError
                ? UIColors.red.withOpacity(enable ? 1 : 0.4)
                : UIColors.lightGray.withOpacity(enable ? 1 : 0.4),
          ),
        ),
        focusedBorder: !showBorder
            ? InputBorder.none
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: hasError
                ? UIColors.red.withOpacity(enable ? 1 : 0.4)
                : UIColors.primaryColor.withOpacity(enable ? 1 : 0.4),
          ),
        ),
        errorBorder: !showBorder
            ? InputBorder.none
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: UIColors.red.withOpacity(enable ? 1 : 0.4),
          ),
        ),
        border: !showBorder
            ? null
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: hasError
                ? UIColors.red.withOpacity(enable ? 1 : 0.4)
                : UIColors.lightGray.withOpacity(enable ? 1 : 0.4),
          ),
        ),
      ),
    );
  }

  getSuffixIcon() {
    if (inputType == InputType.dropdown) {
      return AppImage.asset(
        asset: 'ic_dropdown',
        width: 20,
        height: 20,
        color: enable ? UIColors.grayText : UIColors.gray,
      );
    }
    if (inputType == InputType.calendar) {
      return AppImage.asset(
        asset: 'calendar_icon',
        width: 20,
        height: 20,
        color: enable ? UIColors.grayText : UIColors.gray,
      );
    }
    return null;
  }
}

class UISearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final EdgeInsets? contentPadding;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;
  final bool readOnly;
  final bool autofocus;

  const UISearchTextField({
    Key? key,
    this.focusNode,
    this.controller,
    this.textStyle,
    this.hintText,
    this.hintTextStyle,
    this.contentPadding,
    this.textAlign = TextAlign.left,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.inputBorder,
    this.readOnly = false,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = inputBorder ??
        const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: UIColors.lightGray,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        );
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: textStyle ?? UITextStyle.regular.copyWith(),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textAlign: textAlign,
      onChanged: onChanged,
      readOnly: readOnly,
      autofocus: autofocus,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: hintTextStyle ??
            UITextStyle.regular.copyWith(
              color: UIColors.gray,
            ),
        filled: true,
        isDense: true,
        fillColor: UIColors.white,
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 20,
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 10, right: 12),
          child: AppImage.asset(
            asset: "ic_search_outline",
            width: 20,
            height: 20,
          ),
        ),
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        border: border,
      ),
    );
  }
}

class UITextFieldOutline extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final EdgeInsets? contentPadding;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final bool showClearButton;
  final Color fillColor;
  final double borderRadius;
  final List<TextInputFormatter>? inputFormatter;
  final Function()? onCleared;
  final int maxLines;
  final String? prefixText;

  const UITextFieldOutline({
    Key? key,
    this.focusNode,
    this.controller,
    this.textStyle,
    this.hintText,
    this.hintTextStyle,
    this.contentPadding,
    this.textAlign = TextAlign.left,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.inputBorder,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.showClearButton = false,
    this.fillColor = UIColors.white,
    this.borderRadius = 8,
    this.inputFormatter,
    this.onCleared,
    this.maxLines = 1,
    this.prefixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = inputBorder ??
        OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: UIColors.lightGray,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        );
    final focusedBorder = inputBorder ??
        OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: UIColors.primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        );
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: textStyle ?? UITextStyle.regular.copyWith(),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textAlign: textAlign,
      onChanged: onChanged,
      readOnly: readOnly,
      autofocus: autofocus,
      obscureText: obscureText,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: hintTextStyle ??
            UITextStyle.regular.copyWith(
              color: UIColors.gray,
            ),
        filled: true,
        isDense: true,
        fillColor: fillColor,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        errorBorder: border,
        border: border,
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 48,
          maxHeight: 48,
        ),
        suffixIconConstraints: const BoxConstraints(
          maxWidth: 48,
          maxHeight: 48,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon ??
            (!showClearButton
                ? const SizedBox(
              width: 48,
              height: 48,
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: AppSplashButton(
                onTap: () {
                  controller?.clear();
                  onCleared?.call();
                },
                child: const AppImage.asset(
                  asset: "ic_mtrade_clear_x",
                  width: 24,
                  height: 24,
                ),
              ),
            )),
        prefixText: prefixText,
      ),
      maxLines: maxLines,
    );
  }
}
