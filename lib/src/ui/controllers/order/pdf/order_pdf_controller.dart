import 'package:mobx/mobx.dart';
import 'package:my_fome/src/data/services/files/file_service.dart';
import 'package:my_fome/src/data/services/map/map_service.dart';
import 'package:my_fome/src/data/services/payments/payment_service.dart';
import 'package:my_fome/src/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_group_store_dto.dart';
import 'package:my_fome/src/domain/dtos/payments/payment_pix_dto.dart';
import 'package:my_fome/src/ui/controllers/order/code/code_order_random_controller.dart';
part 'order_pdf_controller.g.dart';

class OrderPdfController = OrderPdfControllerBase with _$OrderPdfController;

abstract class OrderPdfControllerBase with Store {
  final FileService fileService;
  final MapService mapService;
  final PaymentService paymentService;
  final CodeOrderRandomController codeOrderRandomController;

  OrderPdfControllerBase({
    required this.fileService,
    required this.mapService,
    required this.paymentService,
    required this.codeOrderRandomController,
  });

  @observable
  bool isLoading = false;

  @observable
  String? pdfPath;

  @observable
  String? code;

  @computed
  bool get hasPdf => pdfPath != null;

  @action
  Future<void> generate({
    required CartItemGroupStoreDto cart,
    required AddressDetailDto address,
    required String userName,
  }) async {
    isLoading = true;

    final addressLinkMap = mapService.getLocalOpenMapLink(
      double.parse(address.latitude!),
      double.parse(address.longitude!),
    );

    code = codeOrderRandomController.generate4DigitCode();

    final whatsappLink = 'https://wa.me/${address.whatsapp}';

    final pixDto = PaymentPixDto(
      keyPix: cart.storePix,
      name: cart.storeOwnerName.toString(),
      city: cart.storeCity.toString(),
      value: cart.total,
    );

    final pixQrCode = await paymentService.generateQRCode(pixDto);

    pdfPath = await fileService.generatePDFOrder(
      cart,
      address,
      code.toString(),
      userName,
      whatsappLink,
      addressLinkMap: addressLinkMap,
      pixQrCode: pixQrCode,
    );

    isLoading = false;
  }

  @action
  void clear() {
    pdfPath = null;
    code = null;
    isLoading = false;
  }
}
