import 'package:lucid_validation/lucid_validation.dart';
import 'package:my_fome/app/domain/dtos/users/user_register_dto.dart';

class UserRegisterValidator extends LucidValidator<UserRegisterDto> {
  UserRegisterValidator() {
    ruleFor((e) => e.name, key: "name").notEmptyOrNull();
    ruleFor((e) => e.email, key: "email").notEmptyOrNull().validEmail();
  }
}
