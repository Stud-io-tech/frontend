// ignore_for_file: constant_identifier_names

enum TypePaymentEnum {
  CREDITO('Cart. Crédito'),
  DEBITO('Cart. Débito'),
  PIX('Pix'),
  DINHEIRO('Dinheiro');

  final String type;
  const TypePaymentEnum(this.type);
}