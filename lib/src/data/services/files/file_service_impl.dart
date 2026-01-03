/* // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/logo_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/services/payments/payment_service.dart';
import 'package:my_fome/src/data/services/share/share_service.dart';
import 'package:my_fome/src/domain/dtos/order/order_dto.dart';
import 'package:my_fome/src/domain/enum/type_payment_enum.dart';

import './file_service.dart';

class FileServiceImpl implements FileService {
  final PaymentService paymentService;
  final ShareService shareService;
  FileServiceImpl({
    required this.paymentService,
    required this.shareService,
  });
  final dateTime = DateTime.now();

  @override
  Future<String> generatePDFOrder(OrderDto data,
      {Uint8List? pixQrCode, double? bring}) async {
    final regularFont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Inter-Regular.ttf'));
    final boldFont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Inter-SemiBold.ttf'));

    final svgString = await rootBundle.loadString(LogoConstant.horizontal);

    final pw.Document pdf = pw.Document(deflate: zlib.encode);

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(SizeToken.xl),
        build: (context) => [
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                alignment: pw.Alignment.center,
                padding: const pw.EdgeInsets.symmetric(vertical: 50),
                child: pw.SvgImage(svg: svgString, height: 50),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  textLabelLgBoldDark(
                      "Pedido #${data.code} | ${data.typePayment.type}",
                      boldFont),
                  textLabelLgBoldDark(
                      TextConstant.monetaryValue(data.total), boldFont),
                ],
              ),
              pw.SizedBox(
                height: 23,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  textLabelSmNormal("Olá, ", regularFont),
                  textLabelSmBold(data.user.name, boldFont),
                  textLabelSmNormal(
                      "! Confira os dados do pedido abaixo.", regularFont),
                ],
              ),
              pw.SizedBox(
                height: 28,
              ),
              textLabelMdBold(
                  "${data.store.name} - Total ${TextConstant.monetaryValue(data.total)}:",
                  boldFont),
              pw.SizedBox(
                height: 23,
              ),
              pw.Table(columnWidths: {
                0: const pw.FlexColumnWidth(3.75),
                1: const pw.FlexColumnWidth(1.5),
                2: const pw.FlexColumnWidth(2.05),
                3: const pw.FlexColumnWidth(2.15),
              }, children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex(
                      ColorToken.colorToHex(ColorToken.neutral),
                    ),
                  ),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: textLabelSmBold('Produto', boldFont),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: textLabelSmBold('Unid.', boldFont),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: textLabelSmBold('Preço/Unit.', boldFont),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: textLabelSmBold('Total', boldFont),
                    ),
                  ],
                ),
                ...data.cartItens.map(
                  (item) {
                    return pw.TableRow(
                      decoration: pw.BoxDecoration(
                        border: pw.TableBorder(
                          bottom: pw.BorderSide(
                            color: PdfColor.fromHex(
                              ColorToken.colorToHex(ColorToken.semiDark),
                            ),
                            width: 0.1,
                          ),
                        ),
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(12),
                          child:
                              textLabelSmNormal(item.product.name, regularFont),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(12),
                          child: textLabelSmNormal(
                              item.amount.toString(), regularFont),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(12),
                          child: textLabelSmNormal(
                              TextConstant.monetaryValue(
                                  double.parse(item.product.price)),
                              regularFont),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(12),
                          child: textLabelSmNormal(
                              TextConstant.monetaryValue(
                                double.parse(item.product.price) * item.amount,
                              ),
                              regularFont),
                        ),
                      ],
                    );
                  },
                ),
              ]),
              pw.Table(
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex(
                        ColorToken.colorToHex(ColorToken.neutral),
                      ),
                    ),
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(12),
                        alignment: pw.Alignment.centerRight,
                        child: textLabelMdBold(
                            "Total do pedido: ${TextConstant.monetaryValue(data.total)}",
                            boldFont),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(
            height: 28,
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              textLabelLgBoldDark(
                "Endereço:",
                boldFont,
              ),
              pw.SizedBox(
                height: 19,
              ),
              textLabelSmNormal(
                data.city,
                regularFont,
              ),
            ],
          ),
          pw.SizedBox(
            height: 28,
          ),
          data.typePayment == TypePaymentEnum.PIX
              ? pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    textLabelLgBoldDark(
                      TextConstant.payment,
                      boldFont,
                    ),
                    pw.SizedBox(
                      height: 23,
                    ),
                    pixWidget(pixQrCode!, regularFont)
                  ],
                )
              : data.typePayment == TypePaymentEnum.DINHEIRO
                  ? pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        textLabelLgBoldDark(
                          TextConstant.payment,
                          boldFont,
                        ),
                        pw.SizedBox(
                          height: 23,
                        ),
                        textLabelSmNormal(
                          "${TextConstant.bringChange(bring!)} ${TextConstant.paymentOnDelivery}",
                          regularFont,
                        ),
                      ],
                    )
                  : pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        textLabelLgBoldDark(
                          TextConstant.payment,
                          boldFont,
                        ),
                        pw.SizedBox(
                          height: 23,
                        ),
                         textLabelSmNormal(
                          TextConstant.paymentOnDelivery,
                          regularFont,
                        ),
                      ],
                    ),
          pw.SizedBox(
            height: 28,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              textLabelMdBoldDanger(TextConstant.thanks, boldFont),
              textLabelMdBoldDanger(TextConstant.formatDateTime(dateTime), boldFont),
            ],
          ),
        ],
      ),
    );
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/pedido.pdf';
    final File file = File(path);
    final Uint8List pdfBytes = await pdf.save();
    await file.writeAsBytes(pdfBytes);
    return path;
  }

  pw.Text textLabelSmNormal(
    String value,
    pw.Font font,
  ) {
    return pw.Text(
      value,
      style: pw.TextStyle(
        color: PdfColor.fromHex(
          ColorToken.colorToHex(ColorToken.dark),
        ),
        font: font,
        fontWeight: pw.FontWeight.normal,
        fontSize: 15,
      ),
    );
  }

  pw.Text textLabelSmBold(
    String value,
    pw.Font font,
  ) {
    return pw.Text(
      value,
      style: pw.TextStyle(
        color: PdfColor.fromHex(
          ColorToken.colorToHex(ColorToken.dark),
        ),
        fontWeight: pw.FontWeight.bold,
        fontSize: 15,
      ),
    );
  }

  pw.Text textLabelMdBold(
    String value,
    pw.Font font,
  ) {
    return pw.Text(
      value,
      style: pw.TextStyle(
        color: PdfColor.fromHex(
          ColorToken.colorToHex(ColorToken.dark),
        ),
        fontWeight: pw.FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  pw.Text textLabelMdNormal(
    String value,
    pw.Font font,
  ) {
    return pw.Text(
      value,
      style: pw.TextStyle(
        color: PdfColor.fromHex(
          ColorToken.colorToHex(ColorToken.dark),
        ),
        fontWeight: pw.FontWeight.normal,
        fontSize: 17,
      ),
    );
  }

  pw.Text textLabelLgBoldDark(
    String value,
    pw.Font font,
  ) {
    return pw.Text(
      value,
      style: pw.TextStyle(
        color: PdfColor.fromHex(
          ColorToken.colorToHex(ColorToken.dark),
        ),
        fontWeight: pw.FontWeight.bold,
        fontSize: 23,
      ),
    );
  }

  pw.Text textLabelMdBoldDanger(
    String value,
    pw.Font font,
  ) {
    return pw.Text(
      value,
      style: pw.TextStyle(
        color: PdfColor.fromHex(
          ColorToken.colorToHex(ColorToken.danger),
        ),
        fontWeight: pw.FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  pw.Widget pixWidget(Uint8List qrcode, pw.Font font) {
    final image = pw.MemoryImage(qrcode);
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex(
                ColorToken.colorToHex(ColorToken.neutral),
              ),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            padding: const pw.EdgeInsets.all(15),
            child: textLabelSmNormal(TextConstant.pixPayment, font),
          ),
        ),
        pw.SizedBox(width: 15),
        pw.Image(image, height: 125),
      ],
    );
  }
}
 */