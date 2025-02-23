import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoit/themes/theme_provider.dart';
import 'pages/auth_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider); // Watch the theme mode

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode, // Apply the theme mode
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: AuthPage(), // Start with the authentication page
    );
  }
}