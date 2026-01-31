import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/image_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:uikit/uikit.dart';
import 'package:url_launcher/url_launcher_string.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentDefault(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: SizeToken.xl3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButtonLargeDark(
                          onTap: () => context.go('/home'),
                          icon: IconConstant.arrowLeft),
                      const SizedBox(
                        width: SizeToken.sm,
                      ),
                      TextHeadlineH2(
                        text: TextConstant.about,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 250,
                  maxHeight: 80,
                ),
                child: ClipRRect(
                  child: SvgPicture.asset(
                    ImageConstant.horizontalLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: SizeToken.lg),
              TextBodyB1Dark(
                text: TextConstant.descriptionAbout,
                center: true,
              ),
              const SizedBox(
                height: SizeToken.md,
              ),
              TextHeadlineH2(text: TextConstant.members),
              const SizedBox(
                height: SizeToken.md,
              ),
              Column(
                spacing: SizeToken.md,
                children: [
                  MemberCard(
                    image: ImageConstant.lazaro,
                    name: TextConstant.lazaroMembers,
                    position: TextConstant.engSoftwareMembers,
                    textLink: TextConstant.linkdinMembers,
                    onTap: () => launchUrlString(
                        'https://www.linkedin.com/in/lazaro-alexandre/'),
                  ),
                  MemberCard(
                    image: ImageConstant.welen,
                    name: TextConstant.welenMembers,
                    position: TextConstant.engSoftwareMembers,
                    textLink: TextConstant.linkdinMembers,
                    onTap: () => launchUrlString(
                        'https://www.linkedin.com/in/welen-almeida/'),
                  ),
                ],
              ),
              const SizedBox(
                height: SizeToken.xl3,
              ),
              TextLabelL4Dark(
                  text: TextConstant.copyRight),
              const SizedBox(
                height: SizeToken.lg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
