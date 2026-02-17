// ignore_for_file: unused_field, unused_element

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'providers/locale_provider.dart';
import 'providers/rsvp_provider.dart';
import 'ui/view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider(create: (_) => RSVPProvider()),
      ],
      child: WeddingApp(),
    ),
  );
}

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) => MaterialApp(
        locale: localeProvider.locale,
        supportedLocales: const [Locale('it'), Locale('es'), Locale('uk')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: 'Danny & Nataliya',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEAF4F8),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C8EA4)),
          useMaterial3: true,
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        home: WeddingHomePage(),
      ),
    );
  }
}
