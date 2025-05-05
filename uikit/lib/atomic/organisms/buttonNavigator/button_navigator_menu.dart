// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ButtonNavigatorMenu extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final String firstLabel;
  final String secoundLabel;
  final String thirdLabel;
  final String firstIcon;
  final String secoundIcon;
  final String thirdIcon;

  const ButtonNavigatorMenu({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.firstLabel,
    required this.secoundLabel,
    required this.thirdLabel,
    required this.firstIcon,
    required this.secoundIcon,
    required this.thirdIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeToken.xl5,
      child: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: Style.l4(
          color: ColorToken.danger,
        ),
        items: [
          BottomNavigationBarItem(
              icon: currentIndex != 0
                  ? IconLargeDark(icon: firstIcon)
                  : const SizedBox.shrink(),
              label: firstLabel),
          BottomNavigationBarItem(
              icon: currentIndex != 1
                  ? IconLargeDark(icon: secoundIcon)
                  : const SizedBox.shrink(),
              label: secoundLabel),
          BottomNavigationBarItem(
              icon: currentIndex != 2
                  ? IconLargeDark(icon: thirdIcon)
                  : const SizedBox.shrink(),
              label: thirdLabel),
        ],
      ),
    );
  }
}
