import 'package:expense_tracker/app/app.router.dart';
import 'package:expense_tracker/utils/MethodHelpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../Models/UserModel.dart';
import '../../../app/app.locator.dart';
import '../../../utils/SharedPref.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hideText = true;

  toggleHidePassword() {
    hideText = !hideText;
    notifyListeners();
  }

  void login() async {
    if(formKey.currentState!.validate()) {
      UserModel? userModel = await SharedPref().getUserData();
      if (userModel != null) {
        if (emailController.text == userModel.email &&
            passwordController.text == userModel.password) {
          userModel.timeStamp = DateTime.now();
          print(userModel);
          await SharedPref().setUserData(userModel);
          _navigationService.replaceWithRootView();
        } else {
          MethodHelpers.showFlushBar(
              tittle: "Error",
              subTitle: "Wrong email or password",
              color: Colors.red
          );
        }
      } else {
        MethodHelpers.showFlushBar(
            tittle: "Error",
            subTitle: "Please create account first",
            color: Colors.red
        );
      }
    }
  }

  void navigateToSignUp() {
    _navigationService.replaceWithSignupView();
  }
}
