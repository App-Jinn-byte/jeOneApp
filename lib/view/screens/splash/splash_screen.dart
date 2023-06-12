import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/product/controller/product_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  final String pendingDynamicLink;
  final String notyType;
  const SplashScreen({Key key, this.pendingDynamicLink, this.notyType}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  bool _navigate = true;
  // StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    int _count = 0;
    // _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   _count += 1;
    //   if(_count > 2) {
    //     bool isNotConnected = result != ConnectivityResult.wifi || result != ConnectivityResult.mobile;
    //     isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: isNotConnected ? Colors.red : Colors.green,
    //       duration: Duration(seconds: isNotConnected ? 6000 : 3),
    //       content: Text(
    //         isNotConnected ? 'no_connection'.tr : 'connected'.tr,
    //         textAlign: TextAlign.center,
    //       ),
    //     ));
    //     if(!isNotConnected) {
    //
    //     }
    //   }
    // });


    Get.find<ConfigController>().getGeneralSettings();
    Get.find<ConfigController>().initSharedData();
    Get.find<CartController>().getCartList();
    Get.find<ConfigController>().getTaxClasses();
    Get.find<CartController>().initList();
    Get.find<LocationController>().initList();
    Get.find<ProductController>().initDynamicLinks();
    print('NotificationType: ${widget.notyType}');
  }



  @override
  void dispose() {
    super.dispose();
    // _onConnectivityChanged.cancel();
  }

  void _route(){
    // Future.delayed(Duration(seconds: 3), (){
    // });

    Get.find<ConfigController>().getGeneralSettings().then((isSuccess) {
      if(isSuccess) {
        Get.offNamed(RouteHelper.getInitialRoute());

        // double _minimumVersion = 0;
        // if (GetPlatform.isAndroid) {
        //   _minimumVersion = double.parse(Get.find<ConfigController>().settings.appSettings. googleStore.minimumVersion.toString());
        // } else if (GetPlatform.isIOS) {
        //   _minimumVersion = double.parse(Get.find<ConfigController>().settings.appSettings.appleStore.minimumVersion.toString());
        // }
        // if (AppConstants.APP_VERSION < _minimumVersion || Get.find<ConfigController>().settings.businessSettings.maintenanceMode == 1) {
        //   Get.offNamed(RouteHelper.getUpdateRoute(AppConstants.APP_VERSION < _minimumVersion));
        // } else {
        //   Get.offNamed(RouteHelper.getInitialRoute());
        // }

        // if(widget.pendingDynamicLink != null) {
        //   Get.offNamed(RouteHelper.getProductDetailsRoute(-1, widget.pendingDynamicLink, true));
        // }
        // else if (widget.notyType != '' && widget.notyType != null) {
        //   Get.offNamed(RouteHelper.notificationViewRoute(widget.notyType));
        // }

      }});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfigController>(builder: (configController) {
      if(configController.settings != null && configController.taxClassList != null && _navigate) {
        _navigate = false;
        _route();
      }
      return Scaffold(
        key: _globalKey,
        backgroundColor: Get.isDarkMode ? Theme.of(context).primaryColorLight : Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset( Get.isDarkMode ? Images.logo_dark : Images.logo_light, height: 175 ),
            ],
          ),
        ),
      );

    });
  }
}
