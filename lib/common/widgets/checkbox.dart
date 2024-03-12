import 'package:flutter/material.dart';
import '../colors.dart';
import '../styles.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox.circle({
    Key? key,
    required this.value,
    this.title = "",
    this.isEnable = true,
    this.isError = false,
    this.size = 24,
    this.onChanged,
    this.checkedTitleColor = UIColors.boldText,
    this.uncheckedTitleColor = UIColors.boldText,
    this.mainAxisSize = MainAxisSize.max,
    this.fit = FlexFit.tight,
    this.customBackgroundColor,
    this.customCheckedColor,
  })  : shape = BoxShape.circle,
        super(key: key);

  const AppCheckbox.rectangle({
    Key? key,
    required this.value,
    this.title = "",
    this.isEnable = true,
    this.isError = false,
    this.size = 24,
    this.onChanged,
    this.checkedTitleColor = UIColors.boldText,
    this.uncheckedTitleColor = UIColors.boldText,
    this.mainAxisSize = MainAxisSize.max,
    this.fit = FlexFit.tight,
    this.customBackgroundColor,
    this.customCheckedColor,
  })  : shape = BoxShape.rectangle,
        super(key: key);

  final String title;
  final bool value;
  final BoxShape shape;
  final bool isEnable;
  final bool isError;
  final Function(bool)? onChanged;
  final double size;
  final Color checkedTitleColor;
  final Color uncheckedTitleColor;
  final MainAxisSize mainAxisSize;
  final FlexFit fit;
  final Color? customBackgroundColor;
  final Color? customCheckedColor;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        (shape == BoxShape.rectangle) ? BorderRadius.circular(5) : BorderRadius.circular(12);
    final OutlinedBorder shapeBorder =
        (shape == BoxShape.rectangle) ? RoundedRectangleBorder(borderRadius: borderRadius) : const CircleBorder();
    final Color backgroundColor = !isEnable
        ? UIColors.gray
        : value
            ? customBackgroundColor ?? UIColors.primaryColor
            : Colors.white;
    final Color borderColor = !isEnable
        ? UIColors.gray
        : isError
            ? UIColors.red
            : value
                ? customBackgroundColor ?? UIColors.primaryColor
                : UIColors.gray;

    ///
    final Widget checkbox = Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          width: 2,
          color: borderColor,
        ),
        borderRadius: borderRadius,
      ),
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Checkbox(
          shape: shapeBorder,
          value: value,
          checkColor: customCheckedColor ?? Colors.white,
          focusColor: Colors.transparent,
          activeColor: Colors.transparent,
          onChanged: (value) {
            if (isEnable) {
              onChanged?.call(value == true);
            }
          },
        ),
      ),
    );

    ///
    if (title.isEmpty) {
      return checkbox;
    }
    return Row(
      mainAxisSize: mainAxisSize,
      children: [
        checkbox,
        const SizedBox(width: 12),
        Flexible(
          fit: fit,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            style: value
                ? UITextStyle.bold.copyWith(
                    color: checkedTitleColor,
                    fontSize: 14,
                  )
                : UITextStyle.regular.copyWith(
                    color: uncheckedTitleColor,
                    fontSize: 14,
                  ),
            child: Text(
              title,
            ),
          ),
        ),
      ],
    );
  }
}

class AppOutlineCheckbox extends StatelessWidget {
  const AppOutlineCheckbox({
    super.key,
    required this.value,
    this.title = "",
    this.isEnable = true,
    this.isError = false,
    this.size = 24,
    this.onChanged,
    this.checkedTitleColor = UIColors.boldText,
    this.uncheckedTitleColor = UIColors.boldText,
  });

  final String title;
  final bool value;
  final bool isEnable;
  final bool isError;
  final Function(bool)? onChanged;
  final double size;
  final Color checkedTitleColor;
  final Color uncheckedTitleColor;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = !isEnable
        ? UIColors.gray
        : value
            ? UIColors.primaryColor
            : Colors.transparent;
    final Color borderColor = !isEnable
        ? UIColors.gray
        : isError
            ? UIColors.red
            : value
                ? UIColors.primaryColor
                : UIColors.border;

    final Widget checkbox = Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: borderColor,
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
      ),
    );

    return title.isEmpty
        ? checkbox
        : const Row(
            children: [],
          );
  }
}
