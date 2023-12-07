import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery_app/environment.dart';
import 'package:food_delivery_app/routes/route_names.dart';
import 'package:food_delivery_app/routes/screen_routes.dart';
import 'package:food_delivery_app/services/local_db/db_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// loading env file
  await dotenv.load(fileName: Environment.fileName);

  /// Screen Orientation is restricted to Portrait Mode Only
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  /// Local Database Is Initialized
  await DBHandler.initializeDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(199, 176, 186, 36)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white
      ),
      
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
