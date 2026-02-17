import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/l10n/app_localizations.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: AppColors.deepBlue,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Danny & Nataliya",
            style: GoogleFonts.greatVibes(fontSize: 30, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.tr(context, 'footerThansk'),
            style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
