// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String quantity;
  final String price;
  final String? icon;
  final void Function() onTap;
  final void Function()? onTapIcon;
  const ProductItem({
    super.key,
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
    this.icon,
    required this.onTap,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
        topLeft: Radius.circular(SizeToken.sm),
        topRight: Radius.circular(SizeToken.sm),
      ),
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width < 375 ? double.infinity : 175,
          maxHeight: 270,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
            topLeft: Radius.circular(SizeToken.sm),
            topRight: Radius.circular(SizeToken.sm),
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(SizeToken.sm),
                  child: Container(
                    color: ColorToken.neutral,
                    height: 203,
                    width: double.infinity,
                    child: Image(
                      image: CachedNetworkImageProvider(image, maxHeight: 400, maxWidth: 400,), 
                      fit: BoxFit.cover,
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
                ),
                icon != null
                    ? Positioned(
                        top: SizeToken.xs,
                        right: SizeToken.xs,
                        child: IconButtonMediumDark(
                            key: const Key("openModalConfirmProduct"),
                            onTap: onTapIcon!,
                            icon: icon!),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(SizeToken.xxs),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextLabelL5Dark(
                    text: name,
                    maxLines: 2,
                    overflow: true,
                  ),
                  const SizedBox(
                    height: SizeToken.xxs,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextBodyB2SemiDark(
                          text: quantity,
                          overflow: true,
                        ),
                      ),
                      TextLabelL4Dark(
                        text: price,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
