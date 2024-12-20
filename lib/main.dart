import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/core/core.dart';
import 'src/presentation/screen/home_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        // iPhone 15 Pro resolution
        designSize: const Size(1179, 2556),
        builder: (context, _) {
          return const MaterialApp(home: HomeScreen());
        });
  }
}
