// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/image_error_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/controllers/address/address_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/store_detail_screen_widget.dart';
import 'package:uikit/uikit.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final storeController = Injector.get<StoreController>();
  @override
  void initState() {
    super.initState();
    storeController.listStore();
  }

  final addressController = Injector.get<AddressController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: SizeToken.md,
          ),
          InputSearch(
            onChanged: storeController.filterStores,
            hintText: TextConstant.search,
            prefixIcon: IconConstant.search,
            sufixIcon: IconConstant.filter,
            sufixOnTap: () {},
          ),
          const SizedBox(
            height: SizeToken.xxs,
          ),
          Observer(builder: (_) {
            return Container(
              padding: const EdgeInsets.only(right: SizeToken.xs),
              alignment: Alignment.centerRight,
              child: TextBodyB2SemiDark(
                text: TextConstant.found(storeController.founds),
              ),
            );
          }),
          const SizedBox(
            height: SizeToken.md,
          ),
          Observer(builder: (_) {
            if (storeController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (storeController.isServerError) {
              return BannerError(
                image: ImageErrorConstant.serverError,
                text: TextConstant.serverError,
              );
            }
            if (storeController.stores!.isEmpty) {
              return BannerError(
                  image: ImageErrorConstant.empty,
                  text: TextConstant.storeNotFound);
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const DividerDefault(),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: storeController.stores?.length ?? 0,
              itemBuilder: (context, index) {
                final store = storeController.stores![index];
                return StoreItem(
                  name: store.name,
                  description: store.description,
                  image: store.image,
                  icon: IconConstant.chevronRigth,
                  onTap: () async {
                    await addressController.detailAddressStore(store.id);
                    if (addressController.address?.storeId != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StoreDetailScreenWidget(
                            storeModel: store,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
