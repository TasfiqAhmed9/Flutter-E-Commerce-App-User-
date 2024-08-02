import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid
    ? FirebaseOptions(
        apiKey: 'AIzaSyBI6N6y3auZ74m2aFJKL9I4YdL3rOxSsZs',
        appId: '1:285361344183:android:7ac5a62792d1351743c732',
        messagingSenderId: '285361344183',
        projectId: 'ecp-admin-ce001')
    : FirebaseOptions(
        apiKey: 'AIzaSyBI6N6y3auZ74m2aFJKL9I4YdL3rOxSsZs',
        appId: '1:285361344183:android:62af78a389b00df443c732',
        messagingSenderId: '285361344183',
        projectId: 'ecp-admin-ce001');
