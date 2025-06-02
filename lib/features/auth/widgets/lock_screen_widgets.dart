import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';

class LockScreenWidgetsContainer extends StatelessWidget {
  LockScreenWidgetsContainer({super.key});

  //Text-field-controllers
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      elevation: 10,
      //Base-container
      child: Container(
        width: 500,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A3A3A), Color(0xFF2C2C2C)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Top-Logo
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.blue[100],
                radius: 40,
                child: Image.asset(AppAssets.officeBookImage1),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome Back,",
              style: GoogleFonts.publicSans(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryOrangeLight,
              ),
            ),
            //User-fullname
            FutureBuilder<String>(
              future: _getUserName(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: AppColors.iconColor);
                } else if (snapshot.hasData && snapshot.data != null) {
                  final userFullName = snapshot.data;
                  return Text(
                    userFullName!,
                    style: GoogleFonts.publicSans(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return Text("");
                }
              },
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter your pin to unlock",
                style: GoogleFonts.publicSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Pin-Text-field
            PinTextField(
              pinController: _pinController,
              onPress: (String pin) async {
                // await Future.delayed(Duration(milliseconds: 300));
                return pin == "1234";
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getUserName() async {
    final loggedUser = await SharedPrefs.instance.getLoggedUser();

    return "${loggedUser!.firstName} ${loggedUser.lastName ?? ""}";
  }
}

//Pin-text-form-field
class PinTextField extends StatefulWidget {
  const PinTextField({
    super.key,
    required this.pinController,
    required this.onPress,
  });

  final TextEditingController pinController;
  final Future<bool> Function(String pin) onPress;

  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField>
    with SingleTickerProviderStateMixin {
  bool isEnabled = false;
  late AnimationController _animationController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<double>(begin: 0, end: 24)
      .chain(CurveTween(curve: Curves.elasticIn))
      .animate(_animationController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleUnlock() async {
    final pin = widget.pinController.text;
    bool isValid = await widget.onPress(pin);
    if (!isValid) {
      _animationController.forward();
      widget.pinController.clear();
      setState(() {
        isEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _offsetAnimation.value *
                sin(DateTime.now().millisecondsSinceEpoch / 100),
            0,
          ),
          child: child,
        );
      },
      child: Container(
        width: 400,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.inactiveDateColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Pin Text Field
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                obscureText: true,
                controller: widget.pinController,
                onChanged: (String pin) {
                  setState(() {
                    isEnabled = widget.pinController.text.length >= 4;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Pin",
                  hintStyle: TextStyle(color: AppColors.textPrimary),
                  prefixIcon: Icon(Icons.pin, color: AppColors.primaryOrange),
                ),
              ),
            ),
            // Unlock Button
            InkWell(
              onTap: isEnabled ? _handleUnlock : null,
              child: Container(
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      isEnabled
                          ? AppColors.primaryOrangeLight
                          : Colors.grey[400],
                ),
                child: Center(
                  child: Text(
                    "Unlock",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isEnabled ? Colors.black : Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
