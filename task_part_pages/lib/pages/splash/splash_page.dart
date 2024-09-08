import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212832),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  height: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.orange,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text(
                  "Manage your Task with DayTask",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PilatExtended',
                    fontSize: 36,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                InkWell(
                  child: Container(
                    height: 70,
                    color: Colors.orange,
                    child: Center(
                      child: Text("Lets Start"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
