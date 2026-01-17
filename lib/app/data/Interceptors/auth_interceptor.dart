// auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:my_fome/app/utils/constants/api_constant.dart';
import 'package:my_fome/app/utils/constants/local_storage_constant.dart';
import 'package:my_fome/app/data/services/local/local_storage_service.dart';
import 'package:my_fome/app/domain/dtos/users/user_token_dto.dart';

final class AuthInterceptor extends InterceptorsWrapper {
  final LocalStorageService localStorageService;
  final Dio dio;
  AuthInterceptor({required this.localStorageService, required this.dio});

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['requiredAuth'] == true) {
      final accessToken =
          await localStorageService.get(LocalStorageConstant.token);

      if (accessToken != null) {
        options.headers['Authorization'] =
            'Bearer ${UserTokenDto.fromJson(accessToken).accessToken}';
      }
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (shouldHandleError(err)) {
      final tokenData =
          await localStorageService.get(LocalStorageConstant.token);

      if (tokenData != null) {
        final userToken = UserTokenDto.fromJson(tokenData);
        if (userToken.refreshToken != null) {
          try {
            final accessToken = await refreshToken(userToken.refreshToken!);

            if (accessToken != null) {
              late UserTokenDto newToken = UserTokenDto(
                  refreshToken: userToken.refreshToken,
                  accessToken: accessToken);
              await localStorageService.put(
                LocalStorageConstant.token,
                newToken,
              );

              err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
              final response = await dio.fetch(err.requestOptions);
              return handler.resolve(response);
            }
          } catch (_) {
            await localStorageService.delete(LocalStorageConstant.token);
          }
        }
      }
    }
    return handler.reject(err);
  }

  bool shouldHandleError(DioException err) {
    return err.response?.statusCode == 401 &&
        err.requestOptions.extra['requiresAuth'] == true &&
        err.requestOptions.path != ApiConstant.refreshToken;
  }

  Future<String?> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        ApiConstant.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      return response.data['access_token'] as String?;
    } on DioException {
      return null;
    }
  }
}
