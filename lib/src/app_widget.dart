import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:my_fome/src/ui/bindings/app_bindings.dart';
import 'package:my_fome/src/ui/modules/home/home_module.dart';
import 'package:my_fome/src/ui/modules/product/product_module.dart';
import 'package:my_fome/src/ui/modules/store/store_module.dart';
import 'package:my_fome/src/ui/routes/app_routes.dart';
import 'package:uikit/uikit.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      bindings: AppBindings(),
      modules: [
        HomeModule(),
        StoreModule(),
        ProductModule(),
      ],
      builder: (context, routes, flutterGetItNavObserver) {
        return MaterialApp.router(
          title: 'Capricha AÍ',
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: AppRoutes.route,
        );
      },
    );
  }
}
