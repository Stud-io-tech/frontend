import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:my_fome/app/app_bindings.dart';
import 'package:my_fome/app/presentation/modules/address/address_module.dart';
import 'package:my_fome/app/presentation/modules/home/home_module.dart';
import 'package:my_fome/app/presentation/modules/product/product_module.dart';
import 'package:my_fome/app/presentation/modules/store/store_module.dart';
import 'package:my_fome/app/app_routes.dart';
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
        AddressModule(),
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
