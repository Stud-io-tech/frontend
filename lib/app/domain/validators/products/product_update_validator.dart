import 'package:lucid_validation/lucid_validation.dart';
import 'package:my_fome/app/domain/dtos/products/product_update_dto.dart';

class ProductUpadteValidator extends LucidValidator<ProductUpdateDto> {
  ProductUpadteValidator() {
        ruleFor((e) => e.name, key: "name")
        .when((entity) => entity.name != null)
        .notEmptyOrNull();
    ruleFor((e) => e.description, key: "description")
        .when((entity) => entity.description != null)
        .notEmptyOrNull();
    ruleFor((e) => e.price, key: "image")
        .when((entity) => entity.price != null)
        .isNotNull();
  }
}
