import 'package:lucid_validation/lucid_validation.dart';
import 'package:my_fome/app/domain/dtos/stores/store_update_dto.dart';

class StoreUpadteValidator extends LucidValidator<StoreUpdateDto> {
  StoreUpadteValidator() {
    ruleFor((e) => e.name, key: "name")
        .when((entity) => entity.name != null)
        .notEmptyOrNull();
    ruleFor((e) => e.description, key: "description")
        .when((entity) => entity.description != null)
        .notEmptyOrNull();
  }
}
