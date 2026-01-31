import 'package:my_fome/app/domain/dtos/users/user_token_dto.dart';

abstract interface class LocalStorageService {
  Future get(String key);
  Future put(String key, UserTokenDto value);
  Future delete(String key);
}
