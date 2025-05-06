import 'package:dio/dio.dart';

abstract interface class ClientService {
  Future get(String uri, {bool requiresAuth, String contentType, ResponseType? responseType});
  Future post(String uri, Object value, {bool requiresAuth, String contentType});
  Future put(String uri, {bool requiresAuth, String contentType});
  Future delete(String uri, {bool requiresAuth, String contentType});
}