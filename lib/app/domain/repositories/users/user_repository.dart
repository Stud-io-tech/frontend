import 'package:my_fome/app/domain/dtos/users/user_detail_dto.dart';
import 'package:my_fome/app/domain/dtos/users/user_login_dto.dart';
import 'package:my_fome/app/domain/dtos/users/user_register_dto.dart';
import 'package:my_fome/app/domain/dtos/users/user_token_dto.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class UserRepository {
  AsyncResult<UserTokenDto> login(UserLoginDto login);
  AsyncResult<UserRegisterDto> register(UserRegisterDto register);
  AsyncResult<UserDetailDto> detail();
  AsyncResult<Object> getStoreByUser();
  AsyncResult<String> updateToken(String token);
}
