// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:my_fome/src/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_group_store_dto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/logo_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/services/payments/payment_service.dart';
import 'package:my_fome/src/data/services/share/share_service.dart';

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
  Future<String> generatePDFOrder(
      CartItemGroupStoreDto cartItemsGroupStore,
      AddressDetailDto addressUser,
      String code,
      String userName,
      String whatsappLink,
      {Uint8List? pixQrCode,
      String? addressLinkMap}) async {
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
                  textLabelLgBoldDark("Pedido #$code", boldFont),
                  textLabelLgBoldDark(
                      "Total:  ${TextConstant.monetaryValue(double.parse(cartItemsGroupStore.total))}",
                      boldFont),
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
                  textLabelSmBold(userName, boldFont),
                  textLabelSmNormal(
                      "! O pedido será entregue em ", regularFont),
                  textLabelSmBold(
                      "${cartItemsGroupStore.minPreparationTime} a ${cartItemsGroupStore.maxPreparationTime} minutos.",
                      boldFont),
                ],
              ),
              pw.SizedBox(
                height: 15,
              ),
              textLabelSmBold(
                  "Não esqueça de enviar este comprovante! Veja os dados de pedido abaixo:",
                  boldFont),
              pw.SizedBox(
                height: 15,
              ),
              textLabelSmNormal(
                  "Veja os dados de pedido abaixo:",
                  regularFont),
              pw.SizedBox(
                height: 28,
              ),
              textLabelMdBold(
                  "${cartItemsGroupStore.storeName} - ${cartItemsGroupStore.total}",
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
                ...cartItemsGroupStore.cartItems.map(
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
                          child: textLabelSmNormal(
                              item.name.toString(), regularFont),
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
                                double.parse(
                                  item.price.toString(),
                                ),
                              ),
                              regularFont),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(12),
                          child: textLabelSmNormal(
                              TextConstant.monetaryValue(
                                double.parse(item.price.toString()) *
                                    item.amount,
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
                            "Total do pedido: ${TextConstant.monetaryValue(double.parse(cartItemsGroupStore.total))}",
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
                "${addressUser.number}, ${addressUser.street}, ${addressUser.district}, ${addressUser.city}, ${addressUser.state}",
                regularFont,
              ),
              pw.SizedBox(
                height: 15,
              ),
              textLabelSmNormal(
                  "Whatsapp: ${addressUser.whatsapp}", regularFont,
                  link: whatsappLink),
              if (addressLinkMap != null)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 15,
                    ),
                    textLabelSmNormal(
                        "Whatsapp: ${addressUser.whatsapp}", regularFont,
                        link: whatsappLink),
                  ],
                ),
            ],
          ),
          pw.SizedBox(
            height: 28,
          ),
          if (pixQrCode != null)
            pw.Column(
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
                pixWidget(pixQrCode, regularFont),
                pw.SizedBox(
                  height: 28,
                ),
              ],
            ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              textLabelMdBoldDanger(TextConstant.thanks, boldFont),
              textLabelMdBoldDanger(
                  TextConstant.formatDateTime(dateTime), boldFont),
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

  pw.Widget textLabelSmNormal(String value, pw.Font font, {String? link}) {
    return link != null
        ? pw.UrlLink(
            child: pw.Text(
              value,
              style: pw.TextStyle(
                color: PdfColor.fromHex(
                  ColorToken.colorToHex(ColorToken.dark),
                ),
                font: font,
                fontWeight: pw.FontWeight.normal,
                fontSize: 15,
                decoration: pw.TextDecoration.underline,
              ),
            ),
            destination: link)
        : pw.Text(
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
