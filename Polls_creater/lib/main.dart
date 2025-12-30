import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'forms.dart';
import 'buttomnav.dart';
import 'providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBPN8HMtzgqzqXbAPVN_r5bimTqRL73-pE",
        authDomain: "decision-a4644.firebaseapp.com",
        projectId: "decision-a4644",
        storageBucket: "decision-a4644.firebasestorage.app",
        messagingSenderId: "691565838000",
        appId: "1:691565838000:web:7d575d321296f739c1c575",
        measurementId: "G-QRQTWNGXGM",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PollsProvider())],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        home: Authentication(),
        routes: {'/home': (context) => Bottomnavigation()},
      ),
    );
  }
}
