import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'images.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.url,
    required this.size,
    this.showEdit = false,
    this.showBorder = false,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.onEditTap,
    this.errorBuilder,
  }) : super(key: key);

  const AvatarWidget.edit({
    Key? key,
    required this.url,
    required this.size,
    this.showEdit = true,
    this.showBorder = false,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.onEditTap,
    this.errorBuilder,
  }) : super(key: key);

  final String? url;
  final double size;
  final bool showEdit;
  final bool showBorder;
  final BoxFit fit;
  final Color? backgroundColor;
  final Function()? onEditTap;
  final Widget Function()? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
                border: !showBorder
                    ? null
                    : Border.all(
                        color: UIColors.red,
                        width: 2,
                      ),
              ),
              child: AppImage.network(
                url: url,
                width: size,
                height: size,
                fit: fit,
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(size / 2),
                errorBuilder: errorBuilder ?? () {
                  return AppImage.asset(
                    asset: 'avatar_default_male',
                    width: size,
                    height: size,
                    fit: BoxFit.fill,
                  );
                },
              ),
            ),
          ),
          if (showEdit)
            Align(
              alignment: Alignment.bottomRight,
              child: SplashButton(
                onTap: onEditTap,
                child: Container(
                  width: 28,
                  height: 28,
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: UIColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: const AppImage.asset(
                    asset: "ic_camera",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
