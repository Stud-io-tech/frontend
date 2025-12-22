// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/domain/dtos/address/address_user_register_dto.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/image_error_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/enum/login_redirect_enum.dart';
import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';

class UserNotFoundPage extends StatefulWidget {
  final LoginRedirectEnum loginRedirectEnum;

  const UserNotFoundPage({
    super.key,
    required this.loginRedirectEnum,
  });

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

  AddressUserRegisterDto? address;

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
              switch (widget.loginRedirectEnum) {
                case LoginRedirectEnum.STORE:
                  if (authController.store != null) {
                    context.push('/store/my/${authController.store!.id}');
                  } else {
                    context.push('/store/register');
                  }
                  break;
                case LoginRedirectEnum.ADDRESS:
                  /* address = AddressUserRegisterDto(
                    userId: "a0a62973-06d8-4326-bd9c-1284449c8e3b",
                    cep: "58278000",
                    state: "Paraíba",
                    city: "Jacaraú",
                    district: "Zona rural",
                    street: "Sitio Tanque Dantas",
                    number: "S/N",
                    whatsapp: "84992017118",
                    complement: "",
                    latitude: -6.5437362,
                    longitude: -35.3653759,
                  ); */
                  if (address == null) {
                    context.push('/address/register/delivery',
                        extra: authController.user!.id);
                    return;
                  } else {
                    context.push(
                      '/address/update/delivery',
                      extra: address,
                    );
                    return;
                  }
              }
            }
          },
        );
      }),
    );
  }
}
