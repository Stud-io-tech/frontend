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
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_update_dto.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/modules/store/widgets/update/store_update_form.dart';

class UpdateStore extends StatefulWidget {
  final StoreDetailDto store;
  const UpdateStore({
    super.key,
    required this.store,
  });
  @override
  State<UpdateStore> createState() => _UpdateStoreState();
}

class _UpdateStoreState extends State<UpdateStore> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();

  final schedulesEC = TextEditingController();

  final pixKeyEC = TextEditingController();

  final delieveryTimeKmEC = TextEditingController();

  final dynamicFreightKmEC = TextEditingController();

  final storeController = Injector.get<StoreController>();
  final uploadController = Injector.get<LocalUploadController>();

  final swicthController = Injector.get<SwitchController>();

  @override
  void initState() {
    super.initState();
    nameEC.text = widget.store.name;
    descriptionEC.text = widget.store.description;
    pixKeyEC.text = widget.store.pixKey;
    schedulesEC.text = widget.store.schedules;
    delieveryTimeKmEC.text = widget.store.deliveryTimeKm.toString();
    dynamicFreightKmEC.text = widget.store.dynamicFreightKm.toString();
    swicthController.setValue(widget.store.isDelivered);
  }

  @override
  void dispose() {
    nameEC.dispose();
    descriptionEC.dispose();
    schedulesEC.dispose();
    pixKeyEC.dispose();
    delieveryTimeKmEC.dispose();
    dynamicFreightKmEC.dispose();
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
                        onTap: () => context.pop(),
                        icon: IconConstant.arrowLeft,
                      ),
                      const SizedBox(width: SizeToken.sm),
                      TextHeadlineH2(text: TextConstant.updateStore),
                    ],
                  ),
                  Observer(
                    builder: (_) {
                      return widget.store.active? IconButtonLargeLight(
                        backgroundColor: ColorToken.danger,
                        isSquareBorderRadius: true,
                        onTap: () {
                          showCustomModalBottomSheet(
                            context: context,
                            builder: (context) => ModalSheet(
                              iconBack: IconConstant.arrowLeft,
                              title: TextConstant.suspendStoreTitle,
                              description: TextConstant.suspendStoreMessage(widget.store.name),
                              cancelText: TextConstant.no,
                              continueText: TextConstant.yes,
                              continueOnTap: () async{
                                await storeController.toggleActive(widget.store.id);
                                context.push('/store/my/${widget.store.id}');
                              },
                            ),
                          );
                        },
                        icon: IconConstant.remove,
                      ): IconButtonLargeLight(
                        backgroundColor: ColorToken.dark,
                        isSquareBorderRadius: true,
                        onTap: () {
                          showCustomModalBottomSheet(
                            context: context,
                            builder: (context) => ModalSheet(
                              iconBack: IconConstant.arrowLeft,
                              title: TextConstant.reactivedStoreTitle,
                              description: TextConstant.reactivedStoreMessage(widget.store.name),
                              cancelText: TextConstant.no,
                              continueText: TextConstant.yes,
                              continueOnTap: () async{
                                await storeController.toggleActive(widget.store.id);
                                context.push('/store/my/${widget.store.id}');
                              },
                            ),
                          );
                        },
                        icon: IconConstant.restore,
                      );
                    }
                  )
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              Observer(builder: (_) {
                return StoreUpdateForm(
                  formKey: formKey,
                  image: widget.store.image,
                  nameEC: nameEC,
                  descriptionEC: descriptionEC,
                  pixKeyEC: pixKeyEC,
                  schedulesEC: schedulesEC,
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
          key: const Key('buttonUpdateStore'),
          isLoading: storeController.isLoading,
          text: TextConstant.save,
          icon: IconConstant.success,
          onPressed: () async {
            if ((formKey.currentState?.validate() ?? false)) {
              final bool isDelivered = swicthController.value;

              StoreUpdateDto model = StoreUpdateDto(
                name: nameEC.text,
                description: descriptionEC.text,
                schedules: schedulesEC.text,
                pixKey: pixKeyEC.text,
                isDelivered: isDelivered,
                deliveryTimeKm: delieveryTimeKmEC.text,
                dynamicFreightKm: dynamicFreightKmEC.text,
              );
              try {
                await storeController.update(widget.store.id, model,
                    image: uploadController.imageFile);
              } finally {
                if (storeController.isLoading == false) {
                  uploadController.removeImage();
                  context.push('/store/my/${widget.store.id}');
                }
              }
            }
          },
        );
      }),
    );
  }
}
