import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'CLOUDINARY_API_KEY', obfuscate: true)
  static final String cloudinaryApiKey = _Env.cloudinaryApiKey;

  @EnviedField(varName: 'CLOUDINARY_API_SECRET', obfuscate: true)
  static final String cloudinaryApiSecret = _Env.cloudinaryApiSecret;

  @EnviedField(varName: 'CLOUDINARY_CLOUD_NAME', obfuscate: true)
  static final String cloudinaryCloudName = _Env.cloudinaryCloudName;
}
