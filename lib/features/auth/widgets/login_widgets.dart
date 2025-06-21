// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/auth/widgets/login_buttons.dart';
import 'package:office_book_app/shared/providers/login_provider.dart';

import 'package:provider/provider.dart';

class LoginContainer extends StatelessWidget {
  LoginContainer({super.key});

  //Text-field-controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pinController = TextEditingController();
  final confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      elevation: 10,
      child: Container(
        width: 500,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A3A3A), Color(0xFF2C2C2C)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                radius: 40,
                child: Image.asset(AppAssets.officeBookImage1),
              ),
              const SizedBox(height: 10),
              Consumer<Loginprovider>(
                builder: (ctx, provider, _) {
                  return Text(
                    (provider.getLoginMode() == LoginState.signUp)
                        ? 'Welcome In'
                        : "Welcome Back",
                    style: GoogleFonts.publicSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryOrangeLight,
                    ),
                  );
                },
              ),
              Text(
                'Organize Your Work Day',
                style: GoogleFonts.publicSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              //SignIn-SignUp-Fields
              Consumer<Loginprovider>(
                builder: (ctx, loginProvider, _) {
                  return Column(
                    children: [
                      (loginProvider.getLoginMode() == LoginState.signUp)
                          //First&LastName-Text Field
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: LoginTextField(
                                  hintText: 'First Name',
                                  textEditingController: firstNameController,
                                ),
                              ),
                              SizedBox(width: 50),
                              SizedBox(
                                width: 200,
                                child: LoginTextField(
                                  hintText: 'LastName',
                                  textEditingController: lastNameController,
                                ),
                              ),
                            ],
                          )
                          : SizedBox(),
                      (loginProvider.getLoginMode() == LoginState.signUp)
                          ? SizedBox(height: 20)
                          : SizedBox(),
                      //Email-TextField
                      SizedBox(
                        width: 450,
                        child: LoginTextField(
                          hintText: 'Email',
                          textEditingController: emailController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Password-TextField
                      SizedBox(
                        width: 450,
                        child: LoginTextField(
                          hintText: "Password",
                          textEditingController: passwordController,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      //ConfirmPassword-TextField
                      (loginProvider.getLoginMode() == LoginState.signUp)
                          ? SizedBox(
                            width: 450,
                            child: LoginTextField(
                              hintText: "Confirm Password",
                              textEditingController: confirmPasswordController,
                              obscureText: true,
                            ),
                          )
                          : SizedBox(),

                      //Pin&Aggrement -heckfields
                      (loginProvider.getLoginMode() == LoginState.signUp)
                          ? Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: loginProvider.getmPinChecked(),
                                      onChanged: (value) {
                                        loginProvider.setmPinChecked(value!);
                                      },
                                    ),
                                    Text(
                                      "Set MPIN for Lock Screen",
                                      style: GoogleFonts.publicSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              if (loginProvider.getmPinChecked()) ...[
                                SizedBox(
                                  width: 450,
                                  child: LoginTextField(
                                    hintText: "Set MPIN",
                                    textEditingController: pinController,
                                    obscureText: true,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 450,
                                  child: LoginTextField(
                                    hintText: "Confirm MPIN",
                                    textEditingController: confirmPinController,
                                    obscureText: true,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: loginProvider.getAggrementChecked(),
                                    onChanged: (value) {
                                      loginProvider.setAggrementChecked(value!);
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                      'I agree to the Terms and Conditions',
                                      style: GoogleFonts.publicSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          : SizedBox(),

                      const SizedBox(height: 30),

                      //Authentication-Button
                      LoginButton(
                        emailController: emailController,
                        passwordController: passwordController,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        confirmPasswordController: confirmPasswordController,
                        pinController: pinController,
                        confirmPinController: confirmPinController,
                        clickable:
                            (loginProvider.getAggrementChecked() &&
                                loginProvider.getLoginMode() ==
                                    LoginState.signUp) ||
                            (loginProvider.getLoginMode() == LoginState.signIn),
                      ),
                      const SizedBox(height: 10),

                      //SignIn-SignUp-Button
                      SignInSignUpTextButton(
                        emailController: emailController,
                        passwordController: passwordController,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        confirmPasswordController: confirmPasswordController,
                        pinController: pinController,
                        confirmPinController: confirmPinController,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Login-TextFormField
class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.obscureText,
  });

  final String hintText;
  final TextEditingController textEditingController;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: textEditingController,
      obscureText: obscureText != null ? obscureText! : false,
      style: TextStyle(color: AppColors.textSecondary),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        hintText: hintText,
        labelStyle: TextStyle(color: AppColors.textPrimary),
        hintStyle: GoogleFonts.publicSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
