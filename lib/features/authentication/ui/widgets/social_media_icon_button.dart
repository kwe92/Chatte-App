import 'package:chatapp/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaIconButton extends StatelessWidget {
  final String iconPath;
  final bool isSVG;
  final double assetImageScale;

  final double svgImageScale;

  const SocialMediaIconButton({
    required this.iconPath,
    this.isSVG = false,
    this.assetImageScale = 1.0,
    this.svgImageScale = 1.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const sharedBorderRadius = BorderRadius.all(Radius.circular(12));
    return InkWell(
      borderRadius: sharedBorderRadius,
      splashColor: AppColor.primaryThemeColor.withOpacity(0.20),
      highlightColor: AppColor.primaryThemeColor.withOpacity(0.5),
      onTap: () {
        // TODO: implement sign in feature based on what social media platform the user would like to use
      },
      child: Ink(
        child: Container(
          width: 76,
          height: 76,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.grey0,
            ),
            borderRadius: sharedBorderRadius,
          ),
          child: !isSVG
              ? Transform.scale(
                  scale: assetImageScale,
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.contain,
                  ),
                )
              : Transform.scale(
                  scale: svgImageScale,
                  child: SvgPicture.asset(iconPath),
                ),
        ),
      ),
    );
  }
}

// TODO: notes | Changing Image Sizes with Transform.scale
