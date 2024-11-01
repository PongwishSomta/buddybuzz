// lib/providers/auth_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/authservice.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  String? _username;
  User? get user => _user;
  String? get username => _username;
  

  AuthProvider() {
    _authService.user.listen((User? user) {
      _user = user;
      if (_user != null) {
        _fetchUsername(); 
      }
      notifyListeners();
    });
  }

  Future<void> _fetchUsername() async {
    if (_user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      _username = userDoc.data()?['username'];
      notifyListeners(); 
    }
  }
  Future<void> register(String email, String password, String username) async {
    await _authService.registerWithEmailAndPassword(email, password, username);
  }

  Future<void> login(String email, String password) async {
    await _authService.loginWithEmailAndPassword(email, password);
    _fetchUsername();
  }

  Future<void> logout() async {
    await _authService.signOut();
    _username = null;
    notifyListeners();
  }
}
