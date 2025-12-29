// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_fome/src/domain/dtos/address/address_map_dto.dart';
import 'package:my_fome/src/domain/dtos/address/address_register_dto.dart';
import 'package:my_fome/src/ui/controllers/address/address_controller.dart';
import 'package:my_fome/src/ui/modules/address/controller/address_map_controller.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/modules/address/widgets/register/address_register_form.dart';

class RegisterAddressDeliveryPage extends StatefulWidget {
  final String userId;
  const RegisterAddressDeliveryPage({
    super.key,
    required this.userId,
  });

  @override
  State<RegisterAddressDeliveryPage> createState() =>
      _RegisterAddressDeliveryPageState();
}

class _RegisterAddressDeliveryPageState
    extends State<RegisterAddressDeliveryPage> {
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

  final addressController = Injector.get<AddressController>();

  @override
  void initState() {
    super.initState();
    getLocalLocalization();
  }

  void getLocalLocalization() async {
    await addressMapController.getCurrentPosition();
    await addressMapController.reverseAddress(
      LatLng(
        addressMapController.latitude,
        addressMapController.longitude,
      ),
    );
    if (addressMapController.addressMap != null) {
      addressForm(addressMapController.addressMap!);
    }
  }

  void addressForm(AddressMapDto data) {
    data.cep != null
        ? cepEC.text = MaskToken.formatCepNumber(
            MaskToken.removeAllMask(data.cep.toString()),
          )
        : '';
    stateEC.text = data.state ?? '';
    cityEC.text = data.city ?? '';
    districtEC.text = data.district ?? '';
    streetEC.text = data.street ?? '';
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
                          context.push('/');
                        },
                        icon: IconConstant.arrowLeft,
                      ),
                      const SizedBox(width: SizeToken.sm),
                      TextHeadlineH2(text: TextConstant.newDeliveryAddress),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: SizeToken.lg),
              Observer(builder: (_) {
                return AddressRegisterForm(
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
      bottomNavigationBar: Observer(builder: (_) {
        return ButtonLarge(
          key: const Key('buttonRegisterProduct'),
          isLoading: addressController.isLoading,
          text: TextConstant.save,
          icon: IconConstant.success,
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              String cep = MaskToken.removeAllMask(cepEC.text);
              String whatsapp = MaskToken.removeAllMask(whatsappEC.text);
              whatsapp = "+55$whatsapp";
              final model = AddressRegisterDto(
                userId: widget.userId,
                cep: cep,
                state: stateEC.text,
                city: cityEC.text,
                district: districtEC.text,
                street: streetEC.text,
                number: numberEC.text,
                whatsapp: whatsapp,
                complement: complementEC.text,
                latitude: addressMapController.latitude.toString(),
                longitude: addressMapController.longitude.toString(),
              );

              try {
                await addressController.register(model);
              } finally {
                if (addressController.isLoading == false) {
                  addressMapController.cleanAddress();
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
