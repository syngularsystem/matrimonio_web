import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/fade_on_scroll.dart';
import '../../data/l10n/app_localizations.dart';
import '../widgets/language_selector.dart'; // <--- Assicurati di importarlo

class HeroSection extends StatelessWidget {
  final double scrollOffset;
  final Size size;

  const HeroSection({
    super.key,
    required this.scrollOffset,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = size.width < 800;

    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Immagine di Sfondo
          Image.asset(
            isMobile
                ? "assets/images/post_matrimonio_2.jpg"
                : "assets/images/post_land.png",
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),

          // 2. Gradiente per leggibilità
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.deepBlue.withOpacity(0.3),
                  Colors.transparent,
                  AppColors.deepBlue.withOpacity(0.6),
                ],
              ),
            ),
          ),

          // 3. Selettore Lingua (NUOVO)
          // Lo posizioniamo in alto a destra. SafeArea evita sovrapposizioni su mobile.
          const Positioned(
            top: 20,
            right: 20,
            child: SafeArea(child: LanguageSelector()),
          ),

          // 4. Testi Centrali (Benvenuto)
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Column(
              children: [
                FadeOnScroll(
                  scrollOffset: scrollOffset,
                  triggerPoint: 0,
                  child: Text(
                    AppLocalizations.tr(context, 'welcome'),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.greatVibes(
                      fontSize: isMobile ? 40 : 80,
                      color: AppColors.softWhite,
                      shadows: const [
                        Shadow(blurRadius: 10, color: Colors.black38),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // 5. Icona freccia giù
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.softWhite.withOpacity(0.8),
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
