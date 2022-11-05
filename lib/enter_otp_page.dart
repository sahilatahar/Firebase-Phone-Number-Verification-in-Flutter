import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phonenumber_verification/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatefulWidget {
  OtpPage({required this.verificationId, super.key});
  String verificationId = "";
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final oneController = TextEditingController();
  final twoController = TextEditingController();
  final threeController = TextEditingController();
  final fourController = TextEditingController();
  final fiveController = TextEditingController();
  final sixController = TextEditingController();
  final focusNode = FocusNode();

  static String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your OTP",
              style: TextStyle(fontSize: 26.0),
            ),
            const SizedBox(
              height: 18.0,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: const Color(0xFF512DA8),
              showFieldAsBox: true,
              onSubmit: (verificationCode) {
                otp = verificationCode;
              },
            ),
            const SizedBox(
              height: 36.0,
            ),
            SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: widget.verificationId, smsCode: otp));

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/tick.png",
                              height: 100.0,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            const Text(
                              "Verification Succesful",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(userCredential.user!.phoneNumber.toString()),
                          ]),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                            child: const Text("Ok"))
                      ],
                    ),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        const Color(0xFF512DA8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))))),
                child: const Text("Verify OTP"),
              ),
            )
          ],
        )),
      ),
    );
  }
}
