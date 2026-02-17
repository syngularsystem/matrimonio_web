import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa Consumer o Provider.of false per evitare rebuild inutili del bottone stesso
    return PopupMenuButton<String>(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.language, color: Colors.black87),
      ),
      onSelected: (String lang) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        provider.setLocale(Locale(lang));
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'it', child: Text('Italiano 🇮🇹')),
        const PopupMenuItem(value: 'es', child: Text('Español 🇪🇸')),
        const PopupMenuItem(value: 'uk', child: Text('Українська 🇺🇦')),
      ],
    );
  }
}
