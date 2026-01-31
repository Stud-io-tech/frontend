import 'dart:math';

import 'package:mobx/mobx.dart';
part 'code_order_random_controller.g.dart';

class CodeOrderRandomController = CodeOrderRandomControllerBase
    with _$CodeOrderRandomController;

abstract class CodeOrderRandomControllerBase with Store {
  @action
  String generate4DigitCode() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }
}
