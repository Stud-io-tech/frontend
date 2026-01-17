import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:my_fome/app/utils/constants/image_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/presentation/controllers/address/address_controller.dart';
import 'package:my_fome/app/presentation/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/app/presentation/controllers/cartItem/cart_item_controller.dart';
import 'package:uikit/uikit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  final authController = Injector.get<AuthGoogleController>();
  final addressController = Injector.get<AddressController>();
  final cartItemController = Injector.get<CartItemController>();

  Future<void> init() async {
    await authController.load();
    if (authController.user?.id != null) {
      await addressController.detailAddressUser(authController.user!.id);
      await cartItemController.getByGroupStoreByUser(authController.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await init(),
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Builder(
                  builder: (context) {
                    if (authController.isServerError) {
                      return BannerDefault(
                        image: ImageConstant.horizontalLogo,
                        text: TextConstant.serverError,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
