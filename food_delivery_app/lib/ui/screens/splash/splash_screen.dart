import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String key = "Nothing loaded";

  loadKey() async {
    DotEnv dotEnv = DotEnv();
    await dotEnv.load(fileName: 'lib/keys/api_key.env');
    key = dotEnv.get("API_KEY");
    if(mounted) setState((){});
  }

  @override
  void initState() {
    loadKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(key)),
    );
  }
}