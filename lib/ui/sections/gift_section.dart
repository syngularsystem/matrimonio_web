import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/fade_on_scroll.dart';
import '../../data/l10n/app_localizations.dart';

class GiftSection extends StatelessWidget {
  final double scrollOffset;
  const GiftSection({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return FadeOnScroll(
      scrollOffset: scrollOffset,
      triggerPoint: 2000.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppColors.sugarPaperLight,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.pureWhite.withOpacity(0.9),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, size: 50, color: AppColors.deepBlue),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.tr(context, 'gift'),
              style: GoogleFonts.greatVibes(
                fontSize: 32,
                color: AppColors.deepBlue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.tr(context, 'giftText'),
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildGiftBox(Icons.account_balance, "IT75B0306903207100000071081"),
            const SizedBox(height: 10),
            _buildGiftBox(Icons.payment, "paypal.me/DannyRuggiero1992"),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftBox(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.deepBlue),
          const SizedBox(width: 10),
          SelectableText(text, style: const TextStyle(fontFamily: "monospace")),
        ],
      ),
    );
  }
}
