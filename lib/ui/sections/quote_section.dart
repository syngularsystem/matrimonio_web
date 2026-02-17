import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/fade_on_scroll.dart';
import '../../data/l10n/app_localizations.dart';
import '../widgets/countdown_timer.dart';

class QuoteSection extends StatelessWidget {
  final double scrollOffset;

  const QuoteSection({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
      color: AppColors.scaffoldBackground,
      child: Column(
        children: [
          FadeOnScroll(
            scrollOffset: scrollOffset,
            triggerPoint: 300,
            child: Text(
              AppLocalizations.tr(context, 'quote'),
              textAlign: TextAlign.center,
              style: GoogleFonts.greatVibes(
                fontSize: 36,
                color: AppColors.sugarPaperDark,
              ),
            ),
          ),
          const SizedBox(height: 40),
          FadeOnScroll(
            scrollOffset: scrollOffset,
            triggerPoint: 400,
            child: const CountdownTimer(),
          ),
        ],
      ),
    );
  }
}
