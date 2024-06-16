import 'package:bloc_flutter/screens/hpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({required this.email, super.key});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Timer _timer;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _countdown = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _resendVerificationEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      Fluttertoast.showToast(msg: 'Verification email resent');
      setState(() {
        _startCountdown();
      });
    }
  }

  void _checkEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    if (user != null && user.emailVerified) {
      Fluttertoast.showToast(msg: 'Email verified successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else {
      Fluttertoast.showToast(msg: 'Email not verified yet');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: const Color.fromARGB(255, 187, 72, 249),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A verification email has been sent to your email address. Please check your email and verify your account.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkEmailVerified,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: const Text('I have verified'),
            ),
            const SizedBox(height: 16),
            _countdown > 0
                ? Text('Resend verification email in $_countdown seconds')
                : TextButton(
                    onPressed: _resendVerificationEmail,
                    child: const Text('Resend verification email'),
                  ),
          ],
        ),
      ),
    );
  }
}
