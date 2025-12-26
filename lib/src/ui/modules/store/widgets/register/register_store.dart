// ignore_for_file: use_build_context_synchronously

/* import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/stores/store_register_dto.dart';
import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/controllers/upload/local/local_upload_controller.dart';
import 'package:my_fome/src/ui/modules/store/widgets/register/store_register_form.dart';
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

  final whatsappEC = TextEditingController();

  final pixKeyEC = TextEditingController();

  final storeController = Injector.get<StoreController>();

  final uploadController = Injector.get<LocalUploadController>();

  final authController = Injector.get<AuthGoogleController>();

  @override
  void dispose() {
    nameEC.dispose();
    descriptionEC.dispose();
    whatsappEC.dispose();
    pixKeyEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentDefault(
        child: SingleChildScrollView(
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
              StoreRegisterForm(
                formKey: formKey,
                nameEC: nameEC,
                descriptionEC: descriptionEC,
                whatsappEC: whatsappEC,
                pixKeyEC: pixKeyEC,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return ButtonLarge(
          key: const Key("buttonRegisterStore"),
          isLoading: storeController.isLoading,
          text: TextConstant.save,
          icon: IconConstant.success,
          onPressed: () async {
            if ((formKey.currentState?.validate() ?? false) &&
                uploadController.imageFile != null) {
              String whatsapp = MaskToken.removeAllMask(whatsappEC.text);
              whatsapp = "+55$whatsapp";
              StoreRegisterDto model = StoreRegisterDto(
                name: nameEC.text,
                description: descriptionEC.text,
                whatsapp: whatsapp,
                chavePix: pixKeyEC.text,
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
      }),
    );
  }
} */

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/stores/store_register_dto.dart';
import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/controllers/switch/switch_controller.dart';
import 'package:my_fome/src/ui/controllers/upload/local/local_upload_controller.dart';
import 'package:my_fome/src/ui/modules/store/widgets/register/store_register_form.dart';
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
                  isDelivery: swicthController.value,
                  dynamicFreightKmEC: dynamicFreightKmEC,
                  delieveryTimeKmEC: delieveryTimeKmEC,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return ButtonLarge(
          key: const Key("buttonRegisterStore"),
          isLoading: storeController.isLoading,
          text: TextConstant.save,
          icon: IconConstant.success,
          onPressed: () async {
            if ((formKey.currentState?.validate() ?? false) &&
                uploadController.imageFile != null) {

              final bool isDelivered = swicthController.value;
              
              StoreRegisterDto model = StoreRegisterDto(
                name: nameEC.text,
                description: descriptionEC.text,
                schedules: schedulesEC.text,
                pixKey: pixKeyEC.text,
                isDelivered: isDelivered,
                deliveryTimeKm: delieveryTimeKmEC.text,
                dynamicFreightKm: double.parse(dynamicFreightKmEC.text) 
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
      }),
    );
  }
}
