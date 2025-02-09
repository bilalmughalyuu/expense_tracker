import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceLarge,
                Center(
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: getIconTextColor()),
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  "Enter email",
                  style: TextStyle(color: getIconTextColor()),
                ),
                TextFormField(
                  controller: viewModel.emailController,
                  style: TextStyle(color: getIconTextColor()),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter email",
                    hintStyle: TextStyle(color: getIconTextColor()),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a email';
                    }
                    String emailPattern =
                        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                    RegExp regex = RegExp(emailPattern);
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                verticalSpaceMedium,
                Text(
                  "Enter password",
                  style: TextStyle(color: getIconTextColor()),
                ),
                TextFormField(
                  controller: viewModel.passwordController,
                  style: TextStyle(color: getIconTextColor()),
                  obscureText: viewModel.hideText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter password",
                    hintStyle: TextStyle(color: getIconTextColor()),
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.toggleHidePassword();
                      },
                      icon: Icon(Icons.remove_red_eye,color: getIconTextColor()),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 4) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                ),
                verticalSpaceMedium,
                GestureDetector(
                  onTap: () {
                    viewModel.login();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Sign-in",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToSignUp();
                      },
                      child: Text(
                        "Don't have account, Create now",
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          color: getIconTextColor(),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();

  @override
  void onDispose(LoginViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
  }
}
