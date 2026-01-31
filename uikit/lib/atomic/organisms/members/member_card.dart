// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class MemberCard extends StatelessWidget {
  final String image;
  final String name;
  final String position;
  final String textLink;
  final void Function()? onTap;
  const MemberCard({
    super.key,
    required this.image,
    required this.name,
    required this.position,
    required this.textLink,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: SizeToken.md),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeToken.xs),
          border: Border.all(color: ColorToken.semiDark, width: 0.2)),
      child: Center(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 250,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SizeToken.xl6),
                child: Image.asset(image),
              ),
            ),
            const SizedBox(
              height: SizeToken.sm,
            ),
            TextLabelL1Dark(
              text: name,
            ),
            TextBodyB2SemiDark(text: position),
            const SizedBox(
              height: SizeToken.sm,
            ),
            const DividerDefault(),
            const SizedBox(
              height: SizeToken.sm,
            ),
            InkWell(
              onTap: onTap,
              child: TextLabelL4Info(text: textLink),
            ),
          ],
        ),
      ),
    );
  }
}
