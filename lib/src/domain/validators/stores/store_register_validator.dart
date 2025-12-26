import 'package:lucid_validation/lucid_validation.dart';
import 'package:my_fome/src/domain/dtos/stores/store_register_dto.dart';

class StoreRegisterValidator extends LucidValidator<StoreRegisterDto> {
  StoreRegisterValidator() {
    ruleFor((e) => e.name, key: "name").notEmptyOrNull();
    ruleFor((e) => e.description, key: "description").notEmptyOrNull();
    ruleFor((e) => e.schedules, key: "schedules").notEmptyOrNull();
    ruleFor((e) => e.pixKey, key: "pixKey").notEmptyOrNull();
  }
}
