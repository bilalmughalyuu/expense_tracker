import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'signup_viewmodel.dart';

class SignupView extends StackedView<SignupViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
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
                Text(
                  'Create new account!',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: getIconTextColor(),
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
                    hintText: "Enter Email",
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
                  obscureText: viewModel.hideText,
                  style: TextStyle(color: getIconTextColor()),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                      hintText: "Enter Password",
                    hintStyle: TextStyle(color: getIconTextColor()),
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.toggleHidePassword();
                      },
                      icon: Icon(Icons.remove_red_eye, color: getIconTextColor(),),
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
                    viewModel.createAccount();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Sign-up",
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
                        viewModel.navigateToLogin();
                      },
                      child: Text(
                        "Already have account? Login!",
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
  SignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignupViewModel();

  @override
  void onDispose(SignupViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
  }
}
