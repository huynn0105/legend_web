import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/env_config.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';
import 'package:transparent_image/transparent_image.dart';

import '../colors.dart';

class AppImage extends StatelessWidget {
  const AppImage.asset({
    Key? key,
    required this.asset,
    this.url,
    this.base64,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.alignment,
    this.cached = true,
    this.gaplessPlayback = false,
    this.errorBuilder,
  }) : super(key: key);

  const AppImage.base64({
    Key? key,
    required this.base64,
    this.url,
    this.asset,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.alignment,
    this.cached = true,
    this.gaplessPlayback = false,
    this.errorBuilder,
  }) : super(key: key);

  const AppImage.network({
    Key? key,
    required this.url,
    this.asset,
    this.base64,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.alignment,
    this.cached = true,
    this.gaplessPlayback = false,
    this.errorBuilder,
  }) : super(key: key);

  /// Source
  final String? url;
  final String? base64;
  final String? asset;

  /// Properties
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Color? color;
  final AlignmentGeometry? alignment;
  final bool cached;
  final bool gaplessPlayback;
  final Widget Function()? errorBuilder;

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return _buildNetwork();
    }
    if (base64 != null) {
      return _buildBase64();
    }
    if (asset != null) {
      return _buildAsset();
    }
    return const SizedBox();
  }

  _buildAsset() {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        "assets/images/$asset.png",
        height: height == 0 ? null : height,
        width: width == 0 ? null : width,
        fit: fit,
        color: color,
        alignment: alignment ?? Alignment.center,
        package: EnvConfig.instance.package,
        errorBuilder: (_, __, ___) {
          return Container(
            height: height == 0 ? null : height,
            width: width == 0 ? null : width,
            decoration: BoxDecoration(
              color: UIColors.lightGray,
              borderRadius: borderRadius,
            ),
          );
        },
      ),
    );
  }

  _buildBase64() {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.memory(
        base64Decode(base64!),
        height: height == 0 ? null : height,
        width: width == 0 ? null : width,
        fit: fit,
        color: color,
        gaplessPlayback: gaplessPlayback,
        errorBuilder: (_, __, ___) {
          return Container(
            height: height == 0 ? null : height,
            width: width == 0 ? null : width,
            decoration: BoxDecoration(
              color: UIColors.lightGray,
              borderRadius: borderRadius,
            ),
          );
        },
      ),
    );
  }

  _buildNetwork() {
    if (TextUtils.isEmpty(this.url)) {
      if (errorBuilder != null) {
        return errorBuilder!();
      }
      return Container(
        height: height == 0 ? null : height,
        width: width == 0 ? null : width,
        decoration: BoxDecoration(
          color: UIColors.lightGray,
          borderRadius: borderRadius,
        ),
      );
    }
    final String url = FirebaseDatabaseUtil.convertUrlAvatar(this.url!.trim());
    if (kIsWeb && url.isNotEmpty) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          url,
          height: height == 0 ? null : height,
          width: width == 0 ? null : width,
          fit: fit,
        ),
      );
      // return IgnorePointer(
      //   child: ImageNetwork(
      //     image: url,
      //     imageCache: CachedNetworkImageProvider(url),
      //     height: height,
      //     width: width,
      //     // duration: 500,
      //     // curve: Curves.easeIn,
      //     onPointer: false,
      //     debugPrint: false,
      //     fullScreen: false,
      //     fitAndroidIos: fit,
      //     fitWeb: fitWeb,
      //     // borderRadius: borderRadius,
      //     onLoading: const CircularProgressIndicator(
      //       color: Colors.indigoAccent,
      //     ),
      //     onError: const Icon(
      //       Icons.error,
      //       color: Colors.red,
      //     ),
      //   ),
      // );
    }
    if (cached == true) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 400),
          imageUrl: url,
          height: height == 0 ? null : height,
          width: width == 0 ? null : width,
          fit: fit,
          color: color,
          placeholder: (BuildContext context, String url) {
            return const SizedBox();
            // if (Platform.isAndroid) {
            //   return const Center(
            //     child: SizedBox(
            //       width: 16,
            //       height: 16,
            //       child: CircularProgressIndicator(
            //         valueColor: AlwaysStoppedAnimation<Color>(
            //           UIColors.primaryColor,
            //         ),
            //       ),
            //     ),
            //   );
            // }
            // return const CupertinoActivityIndicator();
          },
          errorWidget: (BuildContext context, String url, _) {
            if (errorBuilder != null) {
              return errorBuilder!();
            }
            return Container(
              height: height == 0 ? null : height,
              width: width == 0 ? null : width,
              decoration: BoxDecoration(
                color: UIColors.lightGray,
                borderRadius: borderRadius,
              ),
            );
            // return AppImage.asset(
            //   asset: "ic_error_image",
            //   height: height,
            //   width: width,
            //   fit: BoxFit.contain,
            //   color: UIColors.grayText,
            //   borderRadius: borderRadius,
            // );
          },
        ),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        height: height == 0 ? null : height,
        width: width == 0 ? null : width,
        fit: fit,
      ),
    );
  }
}

class AutoHeightImage extends StatefulWidget {
  const AutoHeightImage({super.key, required this.url});
  final String url;

  @override
  State<AutoHeightImage> createState() => _AutoHeightImageState();
}

class _AutoHeightImageState extends State<AutoHeightImage> {
  double? aspectRatio;

  @override
  void initState() {
    super.initState();
    _onGetSize();
  }

  @override
  Widget build(BuildContext context) {
    if (aspectRatio is double) {
      return AspectRatio(
        aspectRatio: aspectRatio!,
        child: Image.network(widget.url),
      );
    }
    return const SizedBox();
  }

  _onGetSize() async {
    final ByteData data = await NetworkAssetBundle(Uri.parse(widget.url)).load(widget.url);
    final Uint8List bytes = data.buffer.asUint8List();
    final decodedImage = await decodeImageFromList(bytes);
    setState(() {
      aspectRatio = decodedImage.width / decodedImage.height;
    });
  }
}
