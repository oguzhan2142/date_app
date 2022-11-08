/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/conversation.png
  AssetGenImage get conversation =>
      const AssetGenImage('assets/icons/conversation.png');

  /// File path: assets/icons/fire.png
  AssetGenImage get fire => const AssetGenImage('assets/icons/fire.png');

  /// File path: assets/icons/user.png
  AssetGenImage get user => const AssetGenImage('assets/icons/user.png');

  /// File path: assets/icons/user_placeholder.jpeg
  AssetGenImage get userPlaceholder =>
      const AssetGenImage('assets/icons/user_placeholder.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [conversation, fire, user, userPlaceholder];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/image_3.jpg
  AssetGenImage get image3 => const AssetGenImage('assets/images/image_3.jpg');

  /// File path: assets/images/image_4.jpg
  AssetGenImage get image4 => const AssetGenImage('assets/images/image_4.jpg');

  /// File path: assets/images/image_5.jpg
  AssetGenImage get image5 => const AssetGenImage('assets/images/image_5.jpg');

  /// File path: assets/images/test.jpeg
  AssetGenImage get test => const AssetGenImage('assets/images/test.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [image3, image4, image5, test];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
