//Signin-Signup Services Class
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:office_book_app/shared/hive_database/models/user_model.dart';
import 'package:office_book_app/shared/hive_database/services/hive_user_services.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';

class AuthenticationServices {
  AuthenticationServices._internal();
  static AuthenticationServices instance = AuthenticationServices._internal();
  factory AuthenticationServices() => instance;

  //Validate Sign up credentials
  String validateSignUpCredentials({
    required HiveUserModel userModel,
    required String confirmPassword,
  }) {
    //Check is user already Exists
    if (HiveUserServices.instance.checkUserExists(email: userModel.email)) {
      return "User Already Exists!";
    }
    // Check if fields are empty
    if (userModel.firstName.trim().isEmpty ||
        userModel.email.trim().isEmpty ||
        userModel.password.isEmpty ||
        confirmPassword.isEmpty) {
      return 'All fields are required.';
    }

    // Email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(userModel.email)) {
      return 'Invalid email format.';
    }

    // Password length
    if (userModel.password.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Confirm password check
    if (userModel.password !=
        AuthenticationServices.instance.hashPassword(confirmPassword)) {
      return 'Passwords do not match.';
    }

    return "";
  }

  //Validate-SignIn-Credentials
  String validateSignInCredentials({
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      return "All fields are required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format.';
    }
    return "";
  }

  //Encypt-password
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  //SignUp user
  Future<bool> signUpUser({required HiveUserModel userModel}) async {
    return await HiveUserServices.instance.addUser(userModel: userModel);
  }

  //SignIn User
  Future<HiveUserModel?> signInUser({
    required String email,
    required String password,
  }) async {
    final userModel = await HiveUserServices.instance.fetchUser(email: email);

    if (userModel != null) {
      //Check-password
      if (userModel.password == hashPassword(password)) {
        //Signin-Success
        return userModel;
      } else {
        return null;
      }
    }

    return userModel;
  }

  Future<bool> signOutUser() async {
    return await SharedPrefs.instance.deleteLoggedUser();
  }
}
