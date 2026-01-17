import 'package:lucid_validation/lucid_validation.dart';
import 'package:my_fome/app/domain/dtos/users/user_login_dto.dart';

class UserLoginValidator extends LucidValidator<UserLoginDto> {
  UserLoginValidator() {
    ruleFor((e) => e.email, key: "email").validEmail().notEmptyOrNull();
  }
}
