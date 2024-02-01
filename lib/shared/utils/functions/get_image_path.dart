import 'package:flutter/material.dart';

ImageProvider getImageProvider(
  String imagePath, {
  ImageType imageType = ImageType.asset,
  double? width,
  double? height,
  Color? color,
  BoxFit? fit,
  double? scale,
}) {
  return switch (imageType) {
    ImageType.asset => Image.asset(
        imagePath,
        width: width,
        height: height,
        color: color,
        fit: fit,
        scale: scale,
      ).image,
    ImageType.network => Image.network(
        imagePath,
        width: width,
        height: height,
        color: color,
        fit: fit,
        scale: scale ?? 1.0,
      ).image,
  };
}

enum ImageType {
  asset,
  network,
}
