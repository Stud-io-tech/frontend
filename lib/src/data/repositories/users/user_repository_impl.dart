import 'package:dio/dio.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/users/user_detail_dto.dart';
import 'package:result_dart/result_dart.dart';

import 'package:my_fome/src/constants/api_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/exceptions/rest_exception.dart';
import 'package:my_fome/src/data/services/client/client_service.dart';
import 'package:my_fome/src/domain/dtos/users/user_login_dto.dart';
import 'package:my_fome/src/domain/dtos/users/user_register_dto.dart';
import 'package:my_fome/src/domain/dtos/users/user_token_dto.dart';
import 'package:my_fome/src/domain/repositories/users/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ClientService clientService;

  UserRepositoryImpl({
    required this.clientService,
  });

  @override
  AsyncResult<UserTokenDto> login(UserLoginDto login) async {
    try {
      final Response response =
          await clientService.post(ApiConstant.login, login.toMap());
      final UserTokenDto resultLogin = UserTokenDto.fromMap(response.data);
      return Success(resultLogin);
    } on DioException catch (e) {
      return Failure(
        RestException(
            message: TextConstant.errorLoggingAccountMessage,
            statusCode: e.response?.statusCode ?? 500),
      );
    }
  }

  @override
  AsyncResult<UserRegisterDto> register(UserRegisterDto register) async {
    try {
      final Response response =
          await clientService.post(ApiConstant.register, register.toMap());
      final UserRegisterDto userRegister =
          UserRegisterDto.fromMap(response.data['user']);
      return Success(userRegister);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorCreatingAccountMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<UserDetailDto> detail() async {
    try {
      final Response response =
          await clientService.get(ApiConstant.user, requiresAuth: true);

      final UserDetailDto resultProduct =
          UserDetailDto.fromMap(response.data['user']);
      return Success(resultProduct);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorDetailsUserMessage,
          statusCode: e.hashCode,
        ),
      );
    }
  }

  @override
  AsyncResult<Object> getStoreByUser() async {
    try {
      final Response response =
          await clientService.get(ApiConstant.user, requiresAuth: true);

      final result = response.data['store'];

      if (result == null) {
        return const Success(Unit);
      }

      final StoreDetailDto resultProduct = StoreDetailDto.fromMap(result);

      return Success(resultProduct);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorDetailsUserMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<String> updateToken(String token) async {
    try {
      final Response response =
          await clientService.post(ApiConstant.refreshToken, {'refresh_token': token});
      return Success(response.data['access_token']);
    } on DioException catch (e) {
      return Failure(
        RestException(
            message: TextConstant.errorLoggingAccountMessage,
            statusCode: e.response?.statusCode ?? 500),
      );
    }
  }
}
