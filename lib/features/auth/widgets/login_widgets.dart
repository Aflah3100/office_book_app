// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/home/screens/home_screen.dart';
import 'package:office_book_app/shared/hive_database/models/user_model.dart';
import 'package:office_book_app/shared/providers/login_provider.dart';
import 'package:office_book_app/shared/services/authentication_services.dart';
import 'package:provider/provider.dart';

class LoginContainer extends StatelessWidget {
  LoginContainer({super.key});

  //Text-field-controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                    SizedBox(
                      width: 450,
                      child: LoginTextField(
                        hintText: 'Email',
                        textEditingController: emailController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 450,
                      child: LoginTextField(
                        hintText: "Password",
                        textEditingController: passwordController,
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 20),
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

                    const SizedBox(height: 30),

                    //Authentication-Button
                    LoginButton(
                      emailController: emailController,
                      passwordController: passwordController,
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                      confirmPasswordController: confirmPasswordController,
                    ),
                    const SizedBox(height: 10),

                    //SignIn-SignUp-Button
                    const SignInSignUpButton(),
                  ],
                );
              },
            ),
          ],
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

//SignIn/SignUp Button
class SignInSignUpButton extends StatelessWidget {
  const SignInSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final currentLoginState = context.read<Loginprovider>().getLoginMode();

        context.read<Loginprovider>().setLoginMode(
          loginMode:
              (currentLoginState == LoginState.signIn)
                  ? LoginState.signUp
                  : LoginState.signIn,
        );
      },
      child: Consumer<Loginprovider>(
        builder: (ctx, loginProvider, _) {
          return Text(
            (loginProvider.getLoginMode() == LoginState.signIn)
                ? 'New to Office Desk? Sign Up'
                : "Already a user? Sign In",
            style: GoogleFonts.publicSans(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: AppColors.iconColor,
            ),
          );
        },
      ),
    );
  }
}

//User-Authentication Button
class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.confirmPasswordController,
  });

  //Text-field-controllers
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final LoginState loginMode =
            context.read<Loginprovider>().getLoginMode();

        //Signin-State
        if (loginMode == LoginState.signIn) {
          await _validateUserSignIn(context);
        } else {
          //SignUp-state
          await _validateUserSignUp(context);
        }
      },
      child: Container(
        width: 450,
        height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE35C35), Color(0xFFCC6B3D)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Consumer<Loginprovider>(
            builder: (ctx, loginProvider, _) {
              return Text(
                ((loginProvider.getLoginMode() == LoginState.signIn))
                    ? 'LOGIN'
                    : 'SIGNUP',
                style: GoogleFonts.publicSans(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _validateUserSignUp(BuildContext context) async {
    final userModel = UserModel(
      firstName: firstNameController.text,
      email: emailController.text,
      password: AuthenticationServices.instance.hashPassword(
        passwordController.text,
      ),
      joinDate: "",
    );
    final validationStatus = AuthenticationServices.instance
        .validateSignUpCredentials(
          userModel: userModel,
          confirmPassword: confirmPasswordController.text,
        );
    if (validationStatus.isEmpty) {
      //Signup-validation-success
      final signUpStatus = await AuthenticationServices.instance.signUpUser(
        userModel: userModel,
      );

      if (signUpStatus) {
        //Signup-Success
        Navigator.pushNamed(context, HomeScreen.routeName);
      } else {
        //Signup-Failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OOPS! ,Something went wrong!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      //Signup-validation-failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationStatus), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _validateUserSignIn(BuildContext context) async {
    final validationStatus = AuthenticationServices.instance
        .validateSignInCredentials(
          email: emailController.text,
          password: passwordController.text,
        );

    if (validationStatus.isEmpty || validationStatus == "") {
      //Signin-validation-success
      final userModel = await AuthenticationServices.instance.signInUser(
        email: "",
        password: "",
      );
      if (userModel != null) {
        //Sign-In-Success
        Navigator.pushNamed(context, HomeScreen.routeName);
      } else {
        //Sign-in-failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OOPS! ,Something went wrong!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      //Signin-Validation-failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationStatus),
          backgroundColor: Colors.red,
          elevation: 10,
        ),
      );
    }
  }
}
