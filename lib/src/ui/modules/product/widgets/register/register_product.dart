// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/products/product_register_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/controllers/uploads/upload_controller.dart';
import 'package:my_fome/src/ui/modules/product/widgets/register/product_register_form.dart';

class RegisterProduct extends StatefulWidget {
  final StoreDetailDto store;
  const RegisterProduct({
    super.key,
    required this.store,
  });

  @override
  State<RegisterProduct> createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<RegisterProduct> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController();

  final descriptionEC = TextEditingController();

  final priceEC = TextEditingController();

  final amountEC = TextEditingController();

  final productController = Injector.get<ProductController>();

  final uploadController = Injector.get<UploadController>();

  final storeController = Injector.get<StoreController>();

  @override
  void dispose() {
    nameEC.dispose();
    descriptionEC.dispose();
    priceEC.dispose();
    amountEC.dispose();
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
                        onTap: () =>
                            context.push('/product/my', extra: widget.store),
                        icon: IconConstant.arrowLeft,
                      ),
                      const SizedBox(width: SizeToken.sm),
                      TextHeadlineH2(text: TextConstant.newProduct),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              ProductRegisterForm(
                nameEC: nameEC,
                descriptionEC: descriptionEC,
                priceEC: priceEC,
                amountEC: amountEC,
                formKey: formKey,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return ButtonLarge(
          key: const Key('buttonRegisterProduct'),
          isLoading: productController.isLoading,
          text: TextConstant.save,
          icon: IconConstant.success,
          onPressed: () async {
            if ((formKey.currentState?.validate() ?? false) &&
                uploadController.imageFile != null) {
              String price = MaskToken.formatCurrency(priceEC.text);
              ProductRegisterDto model = ProductRegisterDto(
                name: nameEC.text,
                description: descriptionEC.text,
                price: price,
                amount: amountEC.text,
                storeId: widget.store.id,
              );

              try {
                await productController.register(
                    model, uploadController.imageFile!);
              } finally {
                if (productController.isLoading == false) {
                  uploadController.removeImage();
                  context.push('/product/my', extra: widget.store);
                }
              }
            }
          },
        );
      }),
    );
  }
}
