import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonio/data/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';

class LocationCard extends StatelessWidget {
  final String title;
  final String place;
  final String address;
  final String imgAsset;
  final bool isReversed;
  final Size size;
  final String urlMap;

  const LocationCard({
    super.key,
    required this.title,
    required this.place,
    required this.address,
    required this.imgAsset,
    required this.isReversed,
    required this.size,
    this.urlMap = "",
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = size.width < 800;

    Widget imageSection = Container(
      height: isMobile ? 300 : 400,
      width: isMobile ? double.infinity : 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        image: DecorationImage(image: AssetImage(imgAsset), fit: BoxFit.cover),
      ),
    );

    Widget textSection = Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.greatVibes(
            fontSize: 36,
            color: AppColors.sugarPaperDark,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          place,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.deepBlue,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          address,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: urlMap.isEmpty
              ? null
              : () async {
                  final uri = Uri.parse(urlMap);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
          icon: const Icon(Icons.map),
          label: Text(AppLocalizations.tr(context, 'seeMap')),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.deepBlue,
            side: const BorderSide(color: AppColors.deepBlue),
          ),
        ),
      ],
    );

    if (isMobile) {
      return Column(
        children: [imageSection, const SizedBox(height: 30), textSection],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isReversed
            ? [textSection, const SizedBox(width: 50), imageSection]
            : [imageSection, const SizedBox(width: 50), textSection],
      );
    }
  }
}
