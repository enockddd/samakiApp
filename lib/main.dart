import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:samaki_social_app/login/LoginSignupScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // final redisService = RedisService();

  // Connect to Redis server
 // await redisService.connect(host: 'localhost');

  // Perform operations
 // await redisService.set('key', 'value');
  //print(await redisService.get('key'));

  // Close the connection when done
 // await redisService.close();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samaki App',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ComplexLoginScreen(),
    );
  }
}