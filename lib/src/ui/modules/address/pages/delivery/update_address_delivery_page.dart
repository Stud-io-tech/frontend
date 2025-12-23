// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/ui/modules/address/controller/address_map_controller.dart';
import 'package:my_fome/src/ui/modules/address/widgets/update/address_update_form.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/address/address_user_register_dto.dart';

class UpdateAddressDeliveryPage extends StatefulWidget {
  final AddressUserRegisterDto address;

  const UpdateAddressDeliveryPage({
    super.key,
    required this.address,
  });

  @override
  State<UpdateAddressDeliveryPage> createState() =>
      _UpdateAddressDeliveryPageState();
}

class _UpdateAddressDeliveryPageState extends State<UpdateAddressDeliveryPage> {
  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();
  final stateEC = TextEditingController();
  final cityEC = TextEditingController();
  final districtEC = TextEditingController();
  final streetEC = TextEditingController();
  final numberEC = TextEditingController();
  final whatsappEC = TextEditingController();
  final complementEC = TextEditingController();

  final addressMapController = Injector.get<AddressMapController>();

  @override
  void initState() {
    super.initState();

    cepEC.text = MaskToken.formatCepNumber(widget.address.cep);
    stateEC.text = widget.address.state;
    cityEC.text = widget.address.city;
    districtEC.text = widget.address.district;
    streetEC.text = widget.address.street;
    numberEC.text = widget.address.number;
    whatsappEC.text = MaskToken.formatPhoneNumber(
        widget.address.whatsapp.replaceFirst("+55", ""));
    complementEC.text = widget.address.complement ?? '';
    addressMapController.latitude =
        widget.address.latitude ?? addressMapController.latitude;
    addressMapController.longitude =
        widget.address.longitude ?? addressMapController.longitude;
  }

  @override
  void dispose() {
    cepEC.dispose();
    cityEC.dispose();
    districtEC.dispose();
    streetEC.dispose();
    numberEC.dispose();
    whatsappEC.dispose();
    complementEC.dispose();
    addressMapController.cleanAddress();
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
                        onTap: () {
                          addressMapController.cleanAddress();
                          context.push(
                            '/',
                          );
                        },
                        icon: IconConstant.arrowLeft,
                      ),
                      const SizedBox(width: SizeToken.sm),
                      TextHeadlineH2(text: TextConstant.updateDeliveryAddress),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              Observer(builder: (_) {
                return AddressUpdateForm(
                  formKey: formKey,
                  cepEC: cepEC,
                  stateEC: stateEC,
                  cityEC: cityEC,
                  complementEC: complementEC,
                  districtEC: districtEC,
                  numberEC: numberEC,
                  streetEC: streetEC,
                  whatsappEC: whatsappEC,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          return ButtonLarge(
            key: const Key('buttonRegisterProduct'),
            isLoading: false,
            text: TextConstant.save,
            icon: IconConstant.success,
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                String cep = MaskToken.removeAllMask(cepEC.text);
                String whatsapp = MaskToken.removeAllMask(whatsappEC.text);
                whatsapp = "+55$whatsapp";
                final model = AddressUserRegisterDto(
                  userId: widget.address.userId,
                  cep: cep,
                  state: stateEC.text,
                  city: cityEC.text,
                  district: districtEC.text,
                  street: streetEC.text,
                  number: numberEC.text,
                  whatsapp: whatsapp,
                  complement: complementEC.text,
                  latitude: widget.address.latitude,
                  longitude: widget.address.longitude,
                );

                debugPrint(model.toString());
                addressMapController.cleanAddress();

                context.push('/');
              }
            },
          );
        },
      ),
    );
  }
}
