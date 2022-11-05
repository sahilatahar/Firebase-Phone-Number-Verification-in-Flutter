import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phonenumber_verification/enter_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                const Text(
                  "Enter Your Mobile Number",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
                ),
                LottieBuilder.asset("assets/phone.json", height: 200.0),
                const SizedBox(
                  height: 18.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: phoneNoController,
                  //keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefix: Text("+91 "),
                    prefixStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3.0, color: Colors.blue),
                      borderRadius: BorderRadius.all(
                        Radius.circular(18.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18.0),
                      ),
                    ),
                    hintText: "Phone No",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF512DA8)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))))),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+91${phoneNoController.text}",
                          timeout: const Duration(minutes: 1),
                          verificationCompleted: (message) {
                            // ignore: avoid_print
                            print(message);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Verification successful.",
                                      style: TextStyle(color: Colors.white),
                                    )));
                          },
                          verificationFailed: (message) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Verification Failed.",
                                      style: TextStyle(color: Colors.white),
                                    )));
                            // ignore: avoid_print
                            print(message);
                          },
                          codeSent: (verificationId, otp) async {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    behavior: SnackBarBehavior.fixed,
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "OTP send to your mobile no",
                                      style: TextStyle(color: Colors.white),
                                    )));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpPage(
                                    verificationId: verificationId,
                                  ),
                                ));
                          },
                          codeAutoRetrievalTimeout: (verificationId) {});
                    },
                    child: const Text("Send OTP"))),
          ],
        ),
      ),
    );
  }
}
