import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:my_fome/src/ui/modules/product/pages/product_by_my_store_page.dart';
import 'package:my_fome/src/ui/modules/product/widgets/register/register_product.dart';
import 'package:my_fome/src/ui/modules/product/widgets/update/update_product.dart';

class ProductModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/product';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/my': (context) => const ProductByMyStorePage(),
        '/register': (context) => const RegisterProduct(),
        '/update': (context) => const UpdateProduct(),
      };
}
