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
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.orange,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                const Text(
                  "Manage your Task with DayTask",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PilatExtended',
                    fontSize: 36,
                  ),
                ),
                InkWell(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 70,
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
