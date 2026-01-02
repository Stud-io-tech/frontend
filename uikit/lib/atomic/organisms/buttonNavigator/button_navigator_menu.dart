import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ButtonNavigatorMenu extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final String firstLabel;
  final String secoundLabel;
  final String thirdLabel;
  final String fourthLabel;
  final String firstIcon;
  final String secoundIcon;
  final String thirdIcon;
  final String fourthIcon;
  final int? fourthCount;

  const ButtonNavigatorMenu({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.firstLabel,
    required this.secoundLabel,
    required this.thirdLabel,
    required this.fourthLabel,
    required this.firstIcon,
    required this.secoundIcon,
    required this.thirdIcon,
    required this.fourthIcon,
    this.fourthCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeToken.xl5,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: Style.l4(),
        onTap: onTap,
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: ColorToken.danger,
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
          BottomNavigationBarItem(
            icon: currentIndex != 3
                ? IconLargeDark(
                    icon: fourthIcon,
                    count: fourthCount == 0 ? null: fourthCount! > 99? '99+': fourthCount.toString(),
                  )
                : const SizedBox.shrink(),
            label: fourthLabel,
          ),
        ],
      ),
    );
  }
}
