import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PRoutes.dart';
import 'package:jora_customer/Settings/until/PText_styles.dart';
import 'package:jora_customer/features/chat_section/chat_pages/view_model/view_model.dart';
import 'package:jora_customer/features/notifications/notification_pages/view_model/view_model.dart';
import 'package:jora_customer/features/wrapper/view_model/view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WrapperViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationViewModel(),
        ),
         ChangeNotifierProvider(
          create: (context) => ChatViewModel(),
        ),
      ],
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
      initialRoute: PPages.splash,
      onGenerateRoute: Routes.genericRoute,
    );
  }
}
