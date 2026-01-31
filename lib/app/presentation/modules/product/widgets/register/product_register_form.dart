// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:uikit/uikit.dart';
import 'package:validatorless/validatorless.dart';

import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/presentation/controllers/switch/switch_controller.dart';
import 'package:my_fome/app/presentation/controllers/upload/local/local_upload_controller.dart';

class ProductRegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameEC;
  final TextEditingController descriptionEC;
  final TextEditingController priceEC;
  final TextEditingController amountEC;
  final bool isPerishable;
  final TextEditingController preparationTimeEC;

  ProductRegisterForm({
    super.key,
    required this.formKey,
    required this.nameEC,
    required this.descriptionEC,
    required this.priceEC,
    required this.amountEC,
    required this.isPerishable,
    required this.preparationTimeEC,
  });

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode amountFocusNode = FocusNode();

  final uploadController = Injector.get<LocalUploadController>();

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
              key: const Key("imageProductRegister"),
              image: uploadController.selectedImageFile,
              onTap: uploadController.uploadImage,
              labelText: TextConstant.image,
              hintText: TextConstant.uploadImage,
              icon: IconConstant.upload,
            );
          }),
          InputForm(
            key: const Key("nameProductRegister"),
            hintText: TextConstant.productName,
            controller: nameEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.name,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          InputForm(
            key: const Key("descriptionProductRegister"),
            hintText: TextConstant.productDescription,
            controller: descriptionEC,
            maxLines: 3,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.description,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          DividerDefault(),
          Row(
            children: [
              Expanded(
                child: InputForm(
                  key: const Key("priceProductRegister"),
                  prefix: "R\$ ",
                  inputFormatters: MaskToken.currencyInput,
                  hintText: TextConstant.productPrice,
                  controller: priceEC,
                  textInputAction: TextInputAction.next,
                  labelText: TextConstant.price,
                  keyBoardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: Validatorless.required(
                    TextConstant.fieldError,
                  ),
                ),
              ),
              const SizedBox(
                width: SizeToken.sm,
              ),
              Expanded(
                child: InputForm(
                  key: const Key("amountProductRegister"),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyBoardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  hintText: TextConstant.productAmount,
                  controller: amountEC,
                  textInputAction: TextInputAction.next,
                  labelText: TextConstant.amount,
                  validator: Validatorless.required(
                    TextConstant.fieldError,
                  ),
                ),
              ),
            ],
          ),
          DividerDefault(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLabelL1Dark(text: TextConstant.isPerishableProduct),
              SwicthDefault(
                value: isPerishable,
                onChanged: (value) => swicthController.toggleValue(),
              )
            ],
          ),
          DividerDefault(),
          InputForm(
            key: const Key("preparationTimeProductRegister"),
            hintText: TextConstant.preparationTimeHint,
            controller: preparationTimeEC,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.done,
            labelText: TextConstant.preparationTimeLabel,
            keyBoardType: const TextInputType.numberWithOptions(decimal: true),
            sufixIcon: IconConstant.help,
            sufixOnTap: () => showCustomModalBottomSheet(
              context: context,
              builder: (context) => ModalSheet(
                iconBack: IconConstant.arrowLeft,
                title: TextConstant.preparationTimeLabel,
                description: TextConstant.preparationTimeDetail,
              ),
            ),
            validator: Validatorless.required(
              TextConstant.fieldError,
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
