// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ลงทะเบียนผู้ใช้และเก็บข้อมูลลงใน Firestore
  Future<User?> registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // เก็บข้อมูลเพิ่มเติมใน Firestore
      await _firestore.collection('users').doc(user?.uid).set({
        'username': username,
        'email': email,
        'uid': user?.uid,
      });

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // ล็อกอินผู้ใช้
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // ตรวจสอบสถานะผู้ใช้
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // ล็อกเอาท์ผู้ใช้
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
