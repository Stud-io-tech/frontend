// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/src/domain/validators/stores/store_register_validator.dart';
import 'package:my_fome/src/ui/controllers/switch/switch_controller.dart';
import 'package:my_fome/src/ui/controllers/upload/local/local_upload_controller.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:validatorless/validatorless.dart';

class StoreRegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameEC;
  final TextEditingController descriptionEC;
  final TextEditingController pixKeyEC;
  final TextEditingController schedulesEC;
  final bool isDelivery;
  final TextEditingController dynamicFreightKmEC;
  final TextEditingController delieveryTimeKmEC;

  StoreRegisterForm({
    super.key,
    required this.formKey,
    required this.nameEC,
    required this.descriptionEC,
    required this.pixKeyEC,
    required this.schedulesEC,
    required this.isDelivery,
    required this.dynamicFreightKmEC,
    required this.delieveryTimeKmEC,
  });
  final uploadController = Injector.get<LocalUploadController>();
  final validator = StoreRegisterValidator();
  final swicthController = Injector.get<SwitchController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: SizeToken.sm,
        children: [
          Observer(builder: (_) {
            return InputUploadImage(
              key: const Key("imageStoreRegister"),
              image: uploadController.selectedImageFile,
              onTap: uploadController.uploadImage,
              labelText: TextConstant.image,
              hintText: TextConstant.uploadImage,
              icon: IconConstant.upload,
            );
          }),
          InputForm(
            key: const Key("nameStoreRegister"),
            hintText: TextConstant.storeName,
            controller: nameEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.name,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          InputForm(
            key: const Key("descriptionStoreRegister"),
            hintText: TextConstant.storeDescription,
            maxLines: 3,
            controller: descriptionEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.description,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          DividerDefault(),
          InputForm(
            key: const Key("schedulesStoreRegister"),
            hintText: TextConstant.schedulesDescription,
            maxLines: 3,
            controller: schedulesEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.schedules,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          DividerDefault(),
          InputForm(
            key: const Key("pixKeyStoreRegister"),
            hintText: TextConstant.storePixKey,
            controller: pixKeyEC,
            textInputAction: TextInputAction.done,
            labelText: TextConstant.pixKey,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          DividerDefault(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLabelL1Dark(text: TextConstant.isDeliveryStore),
              SwicthDefault(
                value: isDelivery,
                onChanged: (value) => swicthController.toggleValue(),
              )
            ],
          ),
          InputForm(
            key: const Key("delieveryTimeKmStoreRegister"),
            enable: isDelivery,
            hintText: TextConstant.delieveryTimeKmHint,
            controller: delieveryTimeKmEC,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.next,
            labelText: TextConstant.delieveryTimeKmLabel,
            keyBoardType: const TextInputType.numberWithOptions(decimal: true),
            validator: isDelivery
                ? Validatorless.required(
                    TextConstant.fieldError,
                  )
                : null,
            sufixIcon: IconConstant.help,
            sufixOnTap: () => showCustomModalBottomSheet(
              context: context,
              builder: (context) => ModalSheet(
                iconBack: IconConstant.arrowLeft,
                title: TextConstant.delieveryTimeKmLabel,
                description: TextConstant.delieveryTimeKmDetail,
              ),
            ),
          ),
          InputForm(
            key: const Key("dynamicFreightKmStoreRegister"),
            enable: isDelivery,
            hintText: TextConstant.dynamicFreightKmHint,
            controller: dynamicFreightKmEC,
            prefix: "R\$ ",
            inputFormatters: MaskToken.currencyInput,
            textInputAction: TextInputAction.done,
            labelText: TextConstant.dynamicFreightKmLabel,
            keyBoardType: const TextInputType.numberWithOptions(decimal: true),
            validator: isDelivery
                ? Validatorless.required(
                    TextConstant.fieldError,
                  )
                : null,
            sufixIcon: IconConstant.help,
            sufixOnTap: () => showCustomModalBottomSheet(
              context: context,
              builder: (context) =>  ModalSheet(
                iconBack: IconConstant.arrowLeft,
                title: TextConstant.dynamicFreightKmLabel,
                description: TextConstant.dynamicFreightKmDetail,
              ),
            ),
          ),
          SizedBox(
            height: SizeToken.sm,
          )
        ],
      ),
    );
  }
}
