import 'package:expense_tracker/Models/UserModel.dart';
import 'package:expense_tracker/app/app.router.dart';
import 'package:expense_tracker/utils/SharedPref.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../utils/MethodHelpers.dart';

class SignupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hideText = true;

  toggleHidePassword() {
    hideText = !hideText;
    notifyListeners();
  }

  void navigateToLogin() {
    _navigationService.replaceWithLoginView();
  }

  createAccount() async {
    if (formKey.currentState!.validate()) {
      UserModel userModel = UserModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          timeStamp: DateTime.now());
      await SharedPref().setUserData(userModel);
      _navigationService.replaceWithRootView();
      MethodHelpers.showFlushBar(
          tittle: "Success",
          subTitle: "Account created successfully",
          color: Colors.green
      );
    }
  }
}
