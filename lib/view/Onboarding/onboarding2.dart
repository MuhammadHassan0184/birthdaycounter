import 'package:flutter/material.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/top2.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    width: double.infinity,
                    child: Image.asset("assets/onboarding2.png")
                    ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Never forget a birthday that matters.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}