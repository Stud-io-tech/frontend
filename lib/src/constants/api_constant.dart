import 'env/env.dart';

final class ApiConstant {
  static const String basePix = "https://gerarqrcodepix.com.br/api/v1";
  static final String baseUrl = Env.baseUrl;
  static final String login = "$baseUrl/login";
  static final String product = "$baseUrl/product";
  static final String refreshToken = "$baseUrl/refresh-token";
  static final String register = "$baseUrl/register";
  static final String store = "$baseUrl/store";
  static final String user = "$baseUrl/user";
}
