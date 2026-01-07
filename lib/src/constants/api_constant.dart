import 'env/env.dart';

final class ApiConstant {
  static final String address = "$baseUrl/address";
  static const String basePix = "https://gerarqrcodepix.com.br/api/v1";
  static const String baseOpenStreetMap = 'https://nominatim.openstreetmap.org';
  static final String baseUrl = Env.baseUrl;
  static final String cartItem = "$baseUrl/cart-item";
  static final String login = "$baseUrl/login";
  static final String product = "$baseUrl/product";
  static final String refreshToken = "$baseUrl/refresh-token";
  static final String register = "$baseUrl/register";
  static final String store = "$baseUrl/store";
  static const String tileOpenStreetMap =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static final String user = "$baseUrl/user";
  static const String userAgent = 'br.com.caprichaai.app';
  static String baseOpenMapLinkGoogle(double latitude, double longitude) =>
      "https://www.google.com/maps?q=$latitude,$longitude";
  static String baseViaCep(String? cep) =>
      'https://viacep.com.br/ws/$cep/json/';
  static String searchOSM(String? query) =>
      '$baseOpenStreetMap/search?q=$query&format=json&limit=1';
  static String reverseLatLng(double latitude, double longitude) =>
      '$baseOpenStreetMap/reverse?lat=$latitude&lon=$longitude&format=json&addressdetails=1';
}
