import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:my_fome/src/ui/modules/store/pages/my_store_page_widget.dart';
import 'package:my_fome/src/ui/modules/store/widgets/register/register_store.dart';
import 'package:my_fome/src/ui/modules/store/widgets/update/update_store.dart';

class StoreModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/store';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/my': (context) => const MyStorePage(),
        '/register': (context) => const RegisterStore(),
        '/update': (context) => const UpdateStore(),
      };
}
