// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/ui/controllers/switch/switch_controller.dart';
import 'package:my_fome/src/ui/controllers/upload/local/local_upload_controller.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_update_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/modules/product/widgets/update/product_update_form.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({
    super.key,
    required this.product,
  });
  final ProductDetailDto product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();

  final priceEC = TextEditingController();

  final amountEC = TextEditingController();

  final preparationTimeEC = TextEditingController();

  final productController = Injector.get<ProductController>();
  final storeController = Injector.get<StoreController>();

  final uploadController = Injector.get<LocalUploadController>();

  late StoreDetailDto store;

  final swicthController = Injector.get<SwitchController>();

  @override
  void initState() {
    super.initState();
    nameEC.text = widget.product.name;
    descriptionEC.text = widget.product.description;
    priceEC.text = widget.product.price;
    amountEC.text = widget.product.amount.toString();
    store = storeController.store!;
    preparationTimeEC.text = widget.product.preparationTime.toString();
    swicthController.setValue(widget.product.isPerishable);
  }

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
                        onTap: () => Navigator.of(context).pop(),
                        icon: IconConstant.arrowLeft,
                      ),
                      const SizedBox(width: SizeToken.sm),
                      TextHeadlineH2(text: TextConstant.updateProduct),
                    ],
                  ),
                  Observer(
                    builder: (_) {
                      return widget.product.active
                          ? IconButtonLargeLight(
                              backgroundColor: ColorToken.danger,
                              isSquareBorderRadius: true,
                              onTap: () {
                                showCustomModalBottomSheet(
                                  context: context,
                                  builder: (context) => ModalSheet(
                                    iconBack: IconConstant.arrowLeft,
                                    title: TextConstant.suspendProductTitle,
                                    description:
                                        TextConstant.suspendProductMessage(
                                            widget.product.name),
                                    cancelText: TextConstant.no,
                                    continueText: TextConstant.yes,
                                    continueOnTap: () async {
                                      await productController.toggleActive(
                                          widget.product.id, store.id);
                                      context.push('/store/my/${store.id}');
                                    },
                                  ),
                                );
                              },
                              icon: IconConstant.remove,
                            )
                          : IconButtonLargeLight(
                              backgroundColor: ColorToken.dark,
                              isSquareBorderRadius: true,
                              onTap: () {
                                showCustomModalBottomSheet(
                                  context: context,
                                  builder: (context) => ModalSheet(
                                    iconBack: IconConstant.arrowLeft,
                                    title: TextConstant.reactivedProductTitle,
                                    description:
                                        TextConstant.reactivedProductMessage(
                                            widget.product.name),
                                    cancelText: TextConstant.no,
                                    continueText: TextConstant.yes,
                                    continueOnTap: () async {
                                      await productController.toggleActive(
                                          widget.product.id, store.id);
                                      context.push('/store/my/${store.id}');
                                    },
                                  ),
                                );
                              },
                              icon: IconConstant.restore,
                            );
                    },
                  ),
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              Observer(builder: (_) {
                return ProductUpdateForm(
                  image: widget.product.image,
                  nameEC: nameEC,
                  descriptionEC: descriptionEC,
                  priceEC: priceEC,
                  amountEC: amountEC,
                  formKey: formKey,
                  preparationTimeEC: preparationTimeEC,
                  isPerishable: swicthController.value,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return ButtonLarge(
          key: const Key('buttonUpdateProduct'),
          isLoading: productController.isLoading,
          text: TextConstant.save,
          icon: IconConstant.success,
          onPressed: () async {
            if ((formKey.currentState?.validate() ?? false)) {
              String price = MaskToken.formatCurrency(priceEC.text);

              ProductUpdateDto model = ProductUpdateDto(
                name: nameEC.text,
                description: descriptionEC.text,
                price: price,
                amount: amountEC.text,
                storeId: widget.product.storeId,
                isPerishable: swicthController.value,
                preparationTime: int.parse(preparationTimeEC.text),
              );
              try {
                await productController.update(widget.product.id, model,
                    image: uploadController.imageFile);
              } finally {
                if (productController.isLoading == false) {
                  uploadController.removeImage();
                  context.push('/store/my/${store.id}');
                }
              }
            }
          },
        );
      }),
    );
  }
}
