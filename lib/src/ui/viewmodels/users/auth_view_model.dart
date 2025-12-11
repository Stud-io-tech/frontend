import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:my_fome/src/data/exceptions/rest_exception.dart';
import 'package:my_fome/src/data/services/messages/result_message_service.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/users/user_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/users/user_register_dto.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/local_storage_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/services/auth/auth_google_service.dart';
import 'package:my_fome/src/data/services/local/local_storage_service.dart';
import 'package:my_fome/src/domain/dtos/users/user_login_dto.dart';
import 'package:my_fome/src/domain/dtos/users/user_token_dto.dart';
import 'package:my_fome/src/domain/repositories/users/user_repository.dart';
import 'package:result_dart/result_dart.dart';

part 'auth_view_model.g.dart';

class AuthViewModel = AuthViewModelBase with _$AuthViewModel;

abstract class AuthViewModelBase with Store {
  final UserRepository userRepository;
  final AuthGoogleService authGoogleService;
  final LocalStorageService localStorageService;
  final ResultMessageService resultMessageService;
  AuthViewModelBase({
    required this.userRepository,
    required this.authGoogleService,
    required this.localStorageService,
    required this.resultMessageService,
  });

  @observable
  bool isLoading = false;

  @observable
  GoogleSignInAccount? googleCredentials;

  @observable
  UserDetailDto? userDetailDto;

  @observable
  StoreDetailDto? myStore;

  @observable
  bool serverError = false;

  @action
  Future<void> login() async {
    isLoading = true;
    googleCredentials = await authGoogleService.login();
    final user = UserLoginDto(email: googleCredentials!.email);
    final result = await userRepository.login(user);

    result.fold(
      (success) async {
        serverError = false;
        await localStorageService.put(
          LocalStorageConstant.token,
          result.getOrThrow(),
        );

        resultMessageService.showMessageSuccess(
            TextConstant.sucessLoggingAccountTitle,
            TextConstant.sucessLoggingAccountMessage,
            IconConstant.success);
      },
      (failure) async {
        if (failure is RestException && failure.statusCode == 404) {
          await register();
        } else {
          serverError = true;
          await logout();
          resultMessageService
              .showMessageError(TextConstant.errorLoggingAccountMessage);
        }
      },
    );
    isLoading = false;
  }

  @action
  Future register() async {
    isLoading = true;
    final result = await userRepository.register(UserRegisterDto(
      name: googleCredentials!.displayName!,
      email: googleCredentials!.email,
      image: googleCredentials?.photoUrl,
    ));

    result.fold((success) async {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessCreatingAccountTitle,
          TextConstant.sucessCreatingAccountMessage,
          IconConstant.success);
      await login();
      await details();
      await getStore();
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorCreatingAccountMessage);
    });

    isLoading = false;
  }

  @action
  Future logout() async {
    isLoading = true;
    await localStorageService.delete(LocalStorageConstant.token);
    await authGoogleService.logout();
    await localStorageService.get(LocalStorageConstant.token);
    myStore = null;
    userDetailDto = null;
    isLoading = false;
  }

  @action
  Future details() async {
    isLoading = true;

    final result = await userRepository.detail();
    serverError = false;

    result.fold((success) async {
      serverError = false;
      userDetailDto = success;
      await getStore();
    }, (failure) async {
      if (failure is RestException && failure.statusCode == 500) {
        serverError = true;
      }
      await updateToken();
    });

    isLoading = false;
  }

  @action
  Future updateToken() async {
    isLoading = true;

    final tokenData = await localStorageService.get(LocalStorageConstant.token);

    if (tokenData != null) {
      final userToken = UserTokenDto.fromJson(tokenData);

      if (userToken.refreshToken != null) {
        final result =
            await userRepository.updateToken(userToken.refreshToken!);

        serverError = false;

        result.fold((success) async {
          serverError = false;

          await localStorageService.put(
            LocalStorageConstant.token,
            UserTokenDto(
                accessToken: result.getOrThrow(),
                refreshToken: userToken.refreshToken),
          );
          await details();
        }, (failure) async {
          if (failure is RestException && (failure.statusCode == 500)) {
            serverError = true;
          }
          await logout();
        });
      }
    }

    isLoading = false;
  }

  @action
  Future getStore() async {
    isLoading = true;

    final result = await userRepository.getStoreByUser();
    serverError = false;

    result.fold((success) {
      serverError = false;
      if (success is Unit) {
        myStore = null;
      } else if (success is StoreDetailDto) {
        myStore = success;
      }
    }, (failure) async {
      if (failure is RestException && failure.statusCode == 500) {
        serverError = true;
      }
      myStore = null;
    });
    isLoading = false;
  }
}
