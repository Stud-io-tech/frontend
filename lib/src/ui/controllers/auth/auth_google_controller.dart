// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';

import 'package:my_fome/src/domain/dtos/users/user_detail_dto.dart';
import 'package:my_fome/src/ui/viewmodels/users/auth_view_model.dart';

part 'auth_google_controller.g.dart';

class AuthGoogleController = AuthGoogleControllerBase
    with _$AuthGoogleController;

abstract class AuthGoogleControllerBase with Store {
  final AuthViewModel authViewModel;
  AuthGoogleControllerBase({
    required this.authViewModel,
  });

  @computed
  bool get isLoading => authViewModel.isLoading;

  @computed
  bool get isServerError => authViewModel.serverError;

  @computed
  UserDetailDto? get user => authViewModel.userDetailDto;

  @computed
  StoreDetailDto? get store => authViewModel.myStore;

  login() async {
    await authViewModel.login();
    await load();
  }

  logout() async {
    await authViewModel.logout();
    await load();
  }

  load() async {
    await authViewModel.details();
  }
}
