import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/auth/model/signup_body.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/images.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_button.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/base/custom_text_field.dart';
import 'package:flutter_woocommerce/view/screens/auth/widget/condition_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'sign_up'.tr, isBackButtonExist : true),
      body: SafeArea(child: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          physics: BouncingScrollPhysics(),
          child: Center(
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(children: [
                SizedBox(height: 20),
                Image.asset(Get.isDarkMode ? Images.logo_dark : Images.logo_light, height: 50),
                SizedBox(height: 20),
                Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       Expanded(child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('first_name'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                           SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                           CustomTextField(
                             hintText: 'first_name'.tr,
                             controller: _firstNameController,
                             focusNode: _firstNameFocus,
                             nextFocus: _lastNameFocus,
                             inputType: TextInputType.name,
                             capitalization: TextCapitalization.words,
                             divider: false,
                          )],
                      )),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('last_name'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          CustomTextField(
                            hintText: 'last_name'.tr,
                            controller: _lastNameController,
                            focusNode: _lastNameFocus,
                            nextFocus: _usernameFocus,
                            inputType: TextInputType.name,
                            capitalization: TextCapitalization.words,
                            divider: false,
                          )],
                      ))],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Text('username'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  CustomTextField(
                    hintText: 'username'.tr,
                    controller: _usernameController,
                    focusNode: _usernameFocus,
                    nextFocus: _emailFocus,
                    inputType: TextInputType.text,
                    //formatter: FilteringTextInputFormatter.allow(RegExp(r'^[a-z0-9]+$')),
                    divider: false,
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Text('email'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  CustomTextField(
                    hintText: 'email'.tr,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    nextFocus: _passwordFocus,
                    inputType: TextInputType.emailAddress,
                    divider: false,
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Text('new_password'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  CustomTextField(
                    hintText: 'password'.tr,
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    nextFocus: _confirmPasswordFocus,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                    divider: false,
                    prefixIcon: Images.lock,
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Text('confirm_password'.tr, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  CustomTextField(
                    hintText: 'confirm_password'.tr,
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                    divider: false,
                    prefixIcon: Images.lock,
                    onSubmit: (text) => (GetPlatform.isWeb && authController.acceptTerms) ? _register(authController) : null,
                  ),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                ConditionCheckBox(authController: authController),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                !authController.isLoading ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 160,
                      radius: 50,
                      buttonText: 'sign_up'.tr,
                      onPressed: () => _register(authController),
                    ),
                  ],
                ) : Center(child: CircularProgressIndicator()),
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already_have_an_account'.tr+' ', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
                    InkWell(
                      child: Text('login'.tr+' ', style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.primaryContainer, decoration: TextDecoration.underline)),
                      onTap:  () => Get.toNamed(RouteHelper.getSignInRoute(),
                    )),
                  ]
                ),

              ]);
            }),
          ),
        ),
      )),
    );
  }

  void _register(AuthController authController) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _username = _usernameController.text.trim();
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();

    if(authController.acceptTerms == false) {
      showCustomSnackBar('please_agree_with'.tr);
    }
    else if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    }else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    }else if (_username.isEmpty) {
      showCustomSnackBar('enter_your_username'.tr);
    }else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    }else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    }else if (_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    }else {
      authController.registration(SignUpBody(
        firstName: _firstName, lastName: _lastName, email: _email, password: _password, username: _username,
      ));
    }
  }
}
