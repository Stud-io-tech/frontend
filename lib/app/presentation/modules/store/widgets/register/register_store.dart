// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/domain/dtos/stores/store_register_dto.dart';
import 'package:my_fome/app/presentation/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/app/presentation/controllers/store/store_controller.dart';
import 'package:my_fome/app/presentation/controllers/switch/switch_controller.dart';
import 'package:my_fome/app/presentation/controllers/upload/local/local_upload_controller.dart';
import 'package:my_fome/app/presentation/modules/store/widgets/register/store_register_form.dart';
import 'package:uikit/uikit.dart';

class RegisterStore extends StatefulWidget {
  const RegisterStore({super.key});

  @override
  State<RegisterStore> createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<RegisterStore> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController();

  final descriptionEC = TextEditingController();

  final schedulesEC = TextEditingController();

  final pixKeyEC = TextEditingController();

  final delieveryTimeKmEC = TextEditingController();

  final dynamicFreightKmEC = TextEditingController();

  final storeController = Injector.get<StoreController>();

  final uploadController = Injector.get<LocalUploadController>();

  final authController = Injector.get<AuthGoogleController>();

  final swicthController = Injector.get<SwitchController>();

  @override
  void dispose() {
    nameEC.dispose();
    descriptionEC.dispose();
    schedulesEC.dispose();
    pixKeyEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ContentDefault(
          child: Column(
            children: [
              const SizedBox(height: SizeToken.xl3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButtonLargeDark(
                        onTap: () => context.push('/'),
                        icon: IconConstant.arrowLeft,
                      ),
                      const SizedBox(width: SizeToken.sm),
                      TextHeadlineH2(text: TextConstant.newStore),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              Observer(builder: (context) {
                return StoreRegisterForm(
                  formKey: formKey,
                  nameEC: nameEC,
                  descriptionEC: descriptionEC,
                  schedulesEC: schedulesEC,
                  pixKeyEC: pixKeyEC,
                  dynamicFreightKmEC: dynamicFreightKmEC,
                  delieveryTimeKmEC: delieveryTimeKmEC,
                  isDelivery: swicthController.value,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          return ButtonLarge(
            key: const Key("buttonRegisterStore"),
            isLoading: storeController.isLoading,
            text: TextConstant.save,
            icon: IconConstant.success,
            onPressed: () async {
              if ((formKey.currentState?.validate()    ?? false) &&
                  uploadController.imageFile != null) {
                final bool isDelivered = swicthController.value;

                final String deliveryTimeKm = delieveryTimeKmEC.text.isNotEmpty
                    ? delieveryTimeKmEC.text
                    : '0';

                final double dynamicFreightKm = dynamicFreightKmEC.text.isNotEmpty
                    ? double.parse(dynamicFreightKmEC.text)
                    : 0;

                StoreRegisterDto model = StoreRegisterDto(
                  name: nameEC.text,
                  description: descriptionEC.text,
                  schedules: schedulesEC.text,
                  pixKey: pixKeyEC.text,
                  isDelivered: isDelivered,
                  deliveryTimeKm: deliveryTimeKm,
                  dynamicFreightKm: dynamicFreightKm,
                );

                try {
                  await storeController.register(
                      model, uploadController.imageFile!);
                } finally {
                  if (storeController.isLoading == false) {
                    uploadController.removeImage();
                    await authController.load();
                    context.push('/');
                  }
                }
              }
            },
          );
        },
      ),
    );
  }
}
