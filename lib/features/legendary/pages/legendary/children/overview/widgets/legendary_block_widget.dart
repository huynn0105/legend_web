import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';

class LegendaryBlockWidget extends StatelessWidget {
  const LegendaryBlockWidget({
    super.key,
    required this.title,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.onShowToolTip,
  });

  final String title;
  final Widget child;
  final EdgeInsets margin;
  final Function(BuildContext)? onShowToolTip;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  style: UITextStyle.semiBold.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              if (title.isNotEmpty && onShowToolTip != null)
                Builder(
                  builder: (context) {
                    return SplashButton(
                      onTap: () => onShowToolTip?.call(context),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: 20,
                          color: UIColors.grayText,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          child,
        ],
      ),
    );
  }
}
