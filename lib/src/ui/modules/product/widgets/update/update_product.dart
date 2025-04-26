// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_update_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/modules/product/widgets/update/product_update_form.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/controllers/uploads/upload_controller.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();

  final priceEC = TextEditingController();

  final amountEC = TextEditingController();

  final productController = Injector.get<ProductController>();
  final storeController = Injector.get<StoreController>();

  final uploadController = Injector.get<UploadController>();

  late ProductDetailDto product;

  late StoreDetailDto store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product = ModalRoute.of(context)!.settings.arguments as ProductDetailDto;
    nameEC.text = product.name;
    descriptionEC.text = product.description;
    priceEC.text = product.price;
    amountEC.text = product.amount.toString();
    store = storeController.store!;
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
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              ProductUpdateForm(
                image: product.image,
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
                storeId: product.storeId,
              );
              try {
                await productController.update(product.id, model,
                    image: uploadController.imageFile);
              } finally {
                if (productController.isLoading == false) {
                  uploadController.removeImage();
                  Navigator.of(context)
                      .pushReplacementNamed('/store/my', arguments: store);
                }
              }
            }
          },
        );
      }),
    );
  }
}
