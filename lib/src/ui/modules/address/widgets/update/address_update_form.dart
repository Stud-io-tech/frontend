// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_fome/src/constants/api_constant.dart';
import 'package:my_fome/src/domain/dtos/address/address_map_dto.dart';
import 'package:my_fome/src/ui/modules/address/controller/address_map_controller.dart';
import 'package:uikit/uikit.dart';
import 'package:validatorless/validatorless.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';

class AddressUpdateForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController cepEC;

  final TextEditingController stateEC;

  final TextEditingController cityEC;

  final TextEditingController districtEC;

  final TextEditingController streetEC;

  final TextEditingController numberEC;

  final TextEditingController whatsappEC;

  final TextEditingController complementEC;

  final MapController mapController = MapController();

  AddressUpdateForm({
    super.key,
    required this.formKey,
    required this.cepEC,
    required this.stateEC,
    required this.cityEC,
    required this.districtEC,
    required this.streetEC,
    required this.numberEC,
    required this.whatsappEC,
    required this.complementEC,
  });

  final addressMapController = Injector.get<AddressMapController>();

  void clearForm() {
    cepEC.clear();
    stateEC.clear();
    cityEC.clear();
    districtEC.clear();
    streetEC.clear();
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
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: SizeToken.sm,
        children: [
          Observer(builder: (_) {
            return AddressSelectMap(
              urlTemplate: ApiConstant.tileOpenStreetMap,
              userAgentPackageName: ApiConstant.userAgent,
              searchHintText: TextConstant.search,
              searchPrefixIcon: IconConstant.search,
              latitude: addressMapController.latitude,
              longitude: addressMapController.longitude,
              onChangedSearch: (value) =>
                  addressMapController.searchText = value,
              onCurrentPosition: () async {
                await addressMapController.getCurrentPosition();
                await addressMapController.reverseAddress(
                  LatLng(addressMapController.latitude,
                      addressMapController.longitude),
                );
                if (addressMapController.addressMap != null) {
                  clearForm();
                  addressForm(addressMapController.addressMap!);
                }
              },
              onTapMap: (point) async {
                addressMapController.onTapMap(point);
                await addressMapController.reverseAddress(
                  LatLng(addressMapController.latitude,
                      addressMapController.longitude),
                );
                clearForm();
                addressForm(addressMapController.addressMap!);
              },
              searchSufixIcon: IconConstant.send,
              sufixOnTapSearch: addressMapController.searchAddress,
              currentLocalIcon: IconConstant.currentLocation,
            );
          }),
          InputForm(
            key: const Key("cepAddressRegister"),
            hintText: TextConstant.cep,
            controller: cepEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.cep,
            inputFormatters: MaskToken.cepInput,
            keyBoardType: const TextInputType.numberWithOptions(decimal: true),
            validator: Validatorless.multiple(
              [
                Validatorless.required(TextConstant.fieldError),
                Validatorless.min(9, TextConstant.minCaractersPhone),
                Validatorless.max(9, TextConstant.maxCaractersPhone)
              ],
            ),
            sufixIcon: IconConstant.send,
            sufixOnTap: () async {
              if (cepEC.text != '') {
                await addressMapController.getAddressCep(cepEC.text);
                if (addressMapController.addressMap != null) {
                  clearForm();
                  addressForm(addressMapController.addressMap!);
                }
              }
            },
          ),
          InputForm(
            key: const Key("stateAddressRegister"),
            hintText: TextConstant.state,
            controller: stateEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.state,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          InputForm(
            key: const Key("cityAddressRegister"),
            hintText: TextConstant.city,
            controller: cityEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.city,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          InputForm(
            key: const Key("districAddressRegister"),
            hintText: TextConstant.district,
            controller: districtEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.district,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          InputForm(
            key: const Key("StreetAddressRegister"),
            hintText: TextConstant.street,
            controller: streetEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.street,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          InputForm(
            key: const Key("numberAddressRegister"),
            hintText: TextConstant.number,
            controller: numberEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.number,
            validator: Validatorless.required(
              TextConstant.fieldError,
            ),
          ),
          DividerDefault(),
          InputForm(
            key: const Key("whatsappAddressRegister"),
            inputFormatters: MaskToken.phoneInput,
            validator: Validatorless.multiple(
              [
                Validatorless.required(TextConstant.fieldError),
                Validatorless.min(15, TextConstant.minCaractersPhone),
                Validatorless.max(15, TextConstant.maxCaractersPhone)
              ],
            ),
            keyBoardType: const TextInputType.numberWithOptions(decimal: true),
            hintText: TextConstant.whatsapp,
            controller: whatsappEC,
            textInputAction: TextInputAction.next,
            labelText: TextConstant.whatsapp,
          ),
          DividerDefault(),
          InputForm(
            key: const Key("complementAddressRegister"),
            hintText: TextConstant.complement,
            controller: complementEC,
            maxLines: 3,
            textInputAction: TextInputAction.done,
            labelText: TextConstant.complement,
          ),
          SizedBox(
            height: SizeToken.sm,
          )
        ],
      ),
    );
  }
}
