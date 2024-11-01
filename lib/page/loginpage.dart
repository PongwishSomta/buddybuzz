import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/authprovider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ยินดีต้อนรับ.',
                style: GoogleFonts.notoSansThai(
                    fontSize: 24, fontWeight: FontWeight.w600)),
            Text('เริ่มต้นกิจกรรมใหม่ๆสำหรับคุณ',
                style: GoogleFonts.notoSansThai(
                    fontSize: 24, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('ค้นพบกิจกรรมสนุกๆ ใกล้คุณ แค่ปลายนิ้ว',
                style: GoogleFonts.notoSansThai(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8E8E93))),
            const SizedBox(height: 24),
            Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                child: Text(
                  'Email',
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w500),
                )),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF2F2F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                child: Text(
                  'Password',
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w500),
                )),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF2F2F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFF6201),
                  textStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // มุมโค้ง
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                ),
                onPressed: () async {
                  await authProvider.login(
                    emailController.text,
                    passwordController.text,
                  );
                  if (authProvider.user != null) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    showErrorDialog(context);
                  }
                },
                child: Text(
                  "เข้าสู่ระบบ",
                  style: GoogleFonts.notoSansThai(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "สร้างบัญชีผู้ใช้งาน",
                  style: GoogleFonts.notoSansThai(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                  textAlign: TextAlign.end,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('ล็อกอินไม่สำเร็จ',
            style: GoogleFonts.notoSansThai(
                fontSize: 20, fontWeight: FontWeight.w600)),
        content: Text('กรุณาตรวจสอบอีเมลและรหัสผ่านของคุณอีกครั้ง',
            style: GoogleFonts.notoSansThai(
                fontSize: 14, fontWeight: FontWeight.w500)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // ปิด AlertDialog
            },
            child: Text(
              'ตกลง',
              style: GoogleFonts.notoSansThai(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
