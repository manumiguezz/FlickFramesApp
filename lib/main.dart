
import 'package:app_cinema/presentation/providers/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_cinema/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future <void> main() async {

  await dotenv.load(fileName: '.env');
  runApp(
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDarkModeEnabled = false;

  void toggleTheme(){
    setState(() {
      isDarkModeEnabled = !isDarkModeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final themeProvider = ref.watch(themeProviderNotifier);
        return MaterialApp.router(
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.currentThemeMode,
        );
      },
    );
  }
}
