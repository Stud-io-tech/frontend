import 'package:mobx/mobx.dart';
part 'switch_controller.g.dart';

class SwitchController = SwitchControllerBase with _$SwitchController;

abstract class SwitchControllerBase with Store {
  @observable
  bool value = true;

  @action
  void toggleValue() {
    value = !value;
  }

   @action
  void setValue(bool newValue) {
    value = newValue;
  }
}
