import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/locale_provider.dart';
import '../../core/constants/app_colors.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      tooltip: 'Cambia lingua',
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.softWhite.withOpacity(
            0.9,
          ), // Sfondo bianco semitrasparente
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.language, color: AppColors.deepBlue),
      ),
      onSelected: (Locale newLocale) {
        // Usa read() perché siamo dentro un callback, non serve watch()
        context.read<LocaleProvider>().setLocale(newLocale);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: Locale('it'),
          child: Row(children: [Text('🇮🇹 Italiano')]),
        ),
        const PopupMenuItem(
          value: Locale('es'),
          child: Row(children: [Text('🇪🇸 Español')]),
        ),
        const PopupMenuItem(
          value: Locale('uk'),
          child: Row(children: [Text('🇺🇦 Українська')]),
        ),
      ],
    );
  }
}
