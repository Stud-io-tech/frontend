import 'package:lucid_validation/lucid_validation.dart';
import 'package:my_fome/app/domain/dtos/products/product_register_dto.dart';

class ProductRegisterValidator extends LucidValidator<ProductRegisterDto> {
  ProductRegisterValidator() {
    ruleFor((e) => e.name, key: "name").notEmptyOrNull();
    ruleFor((e) => e.description, key: "description").notEmptyOrNull();
    ruleFor((e) => e.price, key: "price").isNotNull();
    ruleFor((e) => e.amount, key: "amout").isNotNull();
    ruleFor((e) => e.storeId, key: "storeId").notEmptyOrNull();
  }
}
