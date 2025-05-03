// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/image_error_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:uikit/uikit.dart';

class UserNotFoundPage extends StatefulWidget {
  const UserNotFoundPage({super.key});

  @override
  State<UserNotFoundPage> createState() => _UserNotFoundPageState();
}

class _UserNotFoundPageState extends State<UserNotFoundPage> {
  final authController = Injector.get<AuthGoogleController>();
  @override
  void initState() {
    super.initState();
    authController.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentDefault(
        child: Column(
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
                        onTap: () => context.push('/'),
                        icon: IconConstant.arrowLeft),
                    const SizedBox(
                      width: SizeToken.sm,
                    ),
                    TextHeadlineH2(text: TextConstant.loggin)
                  ],
                ),
              ],
            ),
            const Spacer(),
            Observer(builder: (_) {
              if (authController.isServerError) {
                return BannerError(
                  image: ImageErrorConstant.serverError,
                  text: TextConstant.serverError,
                );
              }
              return BannerError(
                image: ImageErrorConstant.login,
                text: TextConstant.requiredLogin,
              );
            }),
            const Spacer(),
            const Spacer()
          ],
        ),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return ButtonLarge(
          text: TextConstant.loggin,
          icon: IconConstant.user,
          onPressed: () async {
            await authController.login();
            await authController.load();
            if (authController.user != null) {
              if (authController.store != null) {
                context.push('/store/my');
              } else {
                context.push('/store/register');
              }
            }
          },
        );
      }),
    );
  }
}
