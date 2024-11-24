import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PRoutes.dart';
import 'package:jora_customer/Settings/until/PText_styles.dart';
import 'package:jora_customer/utils/providers.dart';
import 'package:provider/provider.dart';


void main() {
  configLoading();
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jora Customer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall:  TextStyle(),
          bodyMedium: TextStyle(),
          bodyLarge: TextStyle(),
        ).apply(
          bodyColor: PColors.white,
          displayColor: PColors.white,
        ),
        scaffoldBackgroundColor: PColors.seed,
        colorScheme: ColorScheme.fromSeed(seedColor: PColors.seed),
        iconTheme: IconThemeData(color: PColors.white),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: PColors.seed,
          surfaceTintColor: PColors.seed,
          foregroundColor: PColors.white,
          centerTitle: true,
          titleTextStyle: PTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      builder: EasyLoading.init(
        builder: (context, child) {
          // SnackBarMessages().init(context);
          return child!;
        },
      ),
      initialRoute: PPages.splash,
      onGenerateRoute: Routes.genericRoute,
    );
  }
}

void configLoading() {
EasyLoading.instance
  ..displayDuration = const Duration(milliseconds: 2000)
  ..indicatorType = EasyLoadingIndicatorType.fadingCircle
  ..loadingStyle = EasyLoadingStyle.dark
  ..indicatorSize = 45.0
  ..radius = 10.0
  ..progressColor = Colors.yellow
  ..backgroundColor = Colors.green
  ..indicatorColor = Colors.yellow
  ..textColor = Colors.yellow
  ..maskColor = Colors.blue.withOpacity(0.5)
  ..userInteractions = true
  ..dismissOnTap = false;
}
