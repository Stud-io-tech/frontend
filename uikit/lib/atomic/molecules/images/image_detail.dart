// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ImageDetail extends StatelessWidget {
  final String? image;
  final String iconLeft;
  final String? iconRigth;
  final String? iconDown;
  final void Function() onTapIconLeft;
  final void Function()? onTapIconRight;
  final void Function()? onTapIconDown;
  final Widget? widgetDown;

  final Widget? widgetLeft;
  final Widget? widgetRigth;
  const ImageDetail({
    super.key,
    this.image,
    required this.iconLeft,
    this.iconRigth,
    this.iconDown,
    required this.onTapIconLeft,
    this.onTapIconRight,
    this.onTapIconDown,
    this.widgetDown,
    this.widgetLeft,
    this.widgetRigth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.width,
          minWidth: double.infinity),
      child: Stack(
        children: [
          Container(
            color: ColorToken.neutral,
            child: Image(
              image: CachedNetworkImageProvider(
                image != null ? image! : '',
                maxHeight: 1080,
                maxWidth: 1080,
              ),
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.width,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorToken.danger,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: SizeToken.xl3,
            right: SizeToken.md,
            left: SizeToken.md,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widgetLeft ??
                    IconButtonLargeDark(
                      onTap: onTapIconLeft,
                      icon: iconLeft,
                    ),
                widgetRigth ??
                    (iconRigth != null
                        ? IconButtonLargeDark(
                            onTap: onTapIconRight!,
                            icon: iconRigth!,
                          )
                        : const SizedBox.shrink()),
              ],
            ),
          ),
          Positioned(
            bottom: SizeToken.md,
            right: SizeToken.md,
            child: widgetDown ??
                (iconDown != null
                    ? IconButtonLargeDark(
                        onTap: onTapIconDown!,
                        icon: iconDown!,
                      )
                    : const SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}
