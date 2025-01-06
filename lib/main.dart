import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager_flutter/core/utils/theme_task.dart';
import 'package:task_manager_flutter/firebase_options.dart';
import 'package:task_manager_flutter/pages/authentication/page/auth_page.dart';
import 'package:task_manager_flutter/pages/home-page/page/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<bool> isDarkMode = ValueNotifier(false);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, isDark, child) => MaterialApp(
          title: 'Flutter Demo',
          builder: EasyLoading.init(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('id'), // indonesia
          ],
          theme: isDark ? darkTheme : lightTheme,
          home: AuthPage(isDarkMode: isDarkMode,)),
      );
  }
}
