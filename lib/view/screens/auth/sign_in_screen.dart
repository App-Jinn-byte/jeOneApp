import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  final String from;

  const SignInScreen({Key key, this.from}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text =  Get.find<AuthController>().getUserEmail() ?? '';
    _passwordController.text = Get.find<AuthController>().getUserPassword() ?? '';
   // Get.find<AuthController>().authenticateWithBiometric(null, true);
    if(_passwordController.text != ''){
      Get.find<AuthController>().setRememberMe();
    }
    print(widget.from);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'sign_in'.tr,
        onBackPressed: () {
          if(widget.from ==  RouteHelper.resetPassword) {
            Get.offAllNamed(RouteHelper.getInitialRoute());
          } else {
            Get.back();
          }
        }
      ),

      body: WillPopScope(
           onWillPop: () async {
          if(widget.from ==  RouteHelper.resetPassword) {
            return Get.offAllNamed(RouteHelper.getInitialRoute());
          }else {
            Get.back();
            return true;
          }
        },

        child: SafeArea(child: Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Container(
              width: context.width > 700 ? 700 : context.width,
              padding: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
              decoration: context.width > 700 ? BoxDecoration(
                color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], blurRadius: 5, spreadRadius: 1)],
              ) : null,
              child: GetBuilder<AuthController>(builder: (authController) {
                return Column(children: [
                  SizedBox(height: 40),

                  Image.asset(Get.isDarkMode ? Images.logo_dark : Images.logo_light, height: 70),

                  SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('username_email'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    SizedBox(
                      child: CustomTextField(
                        hintText: 'enter_your_username_email'.tr,
                        controller: _emailController,
                        focusNode: _emailFocus,
                        nextFocus: _passwordFocus,
                        inputType: TextInputType.emailAddress,
                        divider: false,
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE), child: Divider(height: 1)),
                    SizedBox(height: 20),

                      Text('password'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      CustomTextField(
                      hintText: 'password'.tr,
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      onSubmit: (text) => (GetPlatform.isWeb && authController.acceptTerms)
                          ? _login(authController) : null,
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                  Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    InkWell(
                      onTap : () {
                        authController.toggleRememberMe();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 20,height: 20,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              activeColor: Get.isDarkMode ? Theme.of(context).colorScheme.primaryContainer  : Theme.of(context).primaryColor,
                              value: authController.isActiveRememberMe,
                              onChanged: (bool isChecked) => authController.toggleRememberMe(),
                            ),
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                          Text('remember_me'.tr),
                        ],
                      ),
                    ),

                    InkWell(
                      child: Text('${'forgot_password'.tr}?',
                        style: poppinsRegular.copyWith(decoration: TextDecoration.underline, color: Theme.of(context).colorScheme.primaryContainer)),
                      onTap: () { Get.toNamed(RouteHelper.getForgotPassRoute());},
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                  !authController.isLoading ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        width: 160,
                        radius: 50,
                        buttonText: 'login'.tr,
                        onPressed: authController.acceptTerms ? () => _login(authController) : null,
                      ),
                    ],
                  ) : Center(child: CircularProgressIndicator()),
                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('don\'t_have_an_account'.tr+' ', style: poppinsRegular.copyWith(color: Theme.of(context).hintColor)),

                      InkWell(
                        child: Text('sign_up'.tr+' ',
                          style: poppinsRegular.copyWith(color: Theme.of(context).colorScheme.primaryContainer, decoration: TextDecoration.underline)),
                        onTap:  () => Get.toNamed(RouteHelper.getSignUpRoute(),
                      )),
                    ]
                  ),
                  SizedBox(height: 70),

                  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getHtmlRoute('terms-and-condition'));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Text('terms_conditions'.tr, style: poppinsRegular.copyWith(color: Theme.of(context).colorScheme.primaryContainer, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ]),

                ]);
              }),
            ),
          ),
        )),
      ),
    );
  }

  void _login(AuthController authController) async {
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();
    if (_email.isEmpty) {
      showCustomSnackBar('enter_username_or_email'.tr);
    }
    // else if (_email.contains('@') && !GetUtils.isEmail(_email)) {
    //   showCustomSnackBar('invalid_email_address'.tr);
    // }
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    }else {
      authController.login(_email, _password, fromLogin: true);
    }
  }
}
