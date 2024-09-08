import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_part_pages/uikit/ui_kit.dart' as ui_kit;

class LoginPage extends StatelessWidget {
  //

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ui_kit.Theme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: heightOfScreen * 0.25),
                Text(
                  "Welcome Back !",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  textAlign: TextAlign.left,
                  "Email Adress",
                  style: GoogleFonts.inter(
                    color: Color(0xff8CAAB9),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 70,
                  child: TextField(),
                ),
                Text(
                  textAlign: TextAlign.left,
                  "Password",
                  style: GoogleFonts.inter(
                    color: Color(0xff8CAAB9),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 70,
                  child: TextField(),
                ),
                ui_kit.Button(
                    text: "login",
                    textColor: Colors.black,
                    onButtonPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
