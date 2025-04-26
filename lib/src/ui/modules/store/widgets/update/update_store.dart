// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_update_dto.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/modules/store/widgets/update/store_update_form.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/controllers/uploads/upload_controller.dart';

class UpdateStore extends StatefulWidget {
  const UpdateStore({super.key});

  @override
  State<UpdateStore> createState() => _UpdateStoreState();
}

class _UpdateStoreState extends State<UpdateStore> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final whatsappEC = TextEditingController();

  final storeController = Injector.get<StoreController>();
  final uploadController = Injector.get<UploadController>();

  late StoreDetailDto store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = ModalRoute.of(context)!.settings.arguments as StoreDetailDto;
    nameEC.text = store.name;
    descriptionEC.text = store.description;
    whatsappEC.text =
        MaskToken.formatPhoneNumber(store.whatsapp.replaceFirst("+55", ""));
  }

  @override
  void dispose() {
    nameEC.dispose();
    descriptionEC.dispose();
    whatsappEC.dispose();
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
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed('/store/my'),
                        icon: IconConstant.arrowLeft,
                      ),
                      const SizedBox(width: SizeToken.sm),
                      TextHeadlineH2(text: TextConstant.updateStore),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              StoreUpdateForm(
                image: store.image,
                nameEC: nameEC,
                descriptionEC: descriptionEC,
                whatsappEC: whatsappEC,
                formKey: formKey,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return ButtonLarge(
          key: const Key('buttonUpdateStore'),
          isLoading: storeController.isLoading,
          text: TextConstant.save,
          icon: IconConstant.success,
          onPressed: () async {
            if ((formKey.currentState?.validate() ?? false)) {
              String whatsapp = MaskToken.removeAllMask(whatsappEC.text);
              whatsapp = "+55$whatsapp";
              StoreUpdateDto model = StoreUpdateDto(
                name: nameEC.text,
                description: descriptionEC.text,
                whatsapp: whatsapp,
              );
              try {
                await storeController.update(store.id, model,
                    image: uploadController.imageFile);
              } finally {
                if (storeController.isLoading == false) {
                  uploadController.removeImage();
                  Navigator.of(context).pushReplacementNamed('/store/my');
                }
              }
            }
          },
        );
      }),
    );
  }
}
