import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PRoutes.dart';
import 'package:jora_customer/Settings/until/PText_styles.dart';
import 'package:jora_customer/utils/providers.dart';
import 'package:jora_customer/view/chat_section/chat_pages/view_model/view_model.dart';
import 'package:jora_customer/view/notifications/notification_pages/view_model/view_model.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:provider/provider.dart';

import 'view_model/auth_view_model.dart';

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
        textTheme: TextTheme(
          bodySmall: TextStyle(),
          bodyMedium: TextStyle(),
          bodyLarge: TextStyle(),
        ).apply(
          bodyColor: PColors.white,
          displayColor: PColors.white,
        ),
        scaffoldBackgroundColor: PColors.seed,
        // fontFamily: PFonts.plusJakartaSansBold,
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
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..maskColor = Colors.white
    ..indicatorColor = Colors.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..textColor = Colors.transparent
    ..contentPadding = const EdgeInsets.all(8)
    ..textPadding = EdgeInsets.zero
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..indicatorSize = 23
    ..lineWidth = 2.2
    ..radius = 20
    ..boxShadow = <BoxShadow>[
      const BoxShadow(
          offset: Offset(2, 2),
          blurRadius: 10,
          color: Color.fromRGBO(0, 0, 0, .15))
    ];
}
