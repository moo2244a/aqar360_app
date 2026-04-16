import 'dart:async';

import 'package:aqar360/app/features/login/presentation/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isLoading = false;
  bool isVerified = false;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    resendEmail();
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      checkEmailVerified();
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerified) {
      timer.cancel();
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    }
  }

  Future<void> resendEmail() async {
    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال رسالة التحقق مرة أخرى')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('حدث خطأ أثناء الإرسال')));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تحقق من البريد الإلكتروني')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mark_email_unread_outlined,
              size: 100,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              'تم إرسال رسالة تأكيد إلى بريدك الإلكتروني\nافتح البريد واضغط على رابط التفعيل',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: isLoading ? null : resendEmail,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('إعادة إرسال الرسالة'),
            ),
          ],
        ),
      ),
    );
  }
}
