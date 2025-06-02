import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';

class LockScreenContainer extends StatelessWidget {
  LockScreenContainer({super.key});

  //Text-field-controllers
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      elevation: 10,
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

            //Pin-Text-field-container
            Container(
              width: 400,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.inactiveDateColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  //Pin-text-field
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      controller: _pinController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Pin",
                        hintStyle: TextStyle(color: AppColors.textPrimary),
                        prefixIcon: Icon(
                          Icons.pin,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    ),
                  ),
                  //Unlock-button
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryOrangeLight,
                      ),
                      child: Center(
                        child: Text(
                          "Unlock",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
