import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/fade_on_scroll.dart';
import '../../data/l10n/app_localizations.dart';
import '../widgets/location_card.dart';

class LocationsSection extends StatelessWidget {
  final double scrollOffset;
  final Size size;

  const LocationsSection({
    super.key,
    required this.scrollOffset,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackground,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            AppLocalizations.tr(context, 'locations'),
            style: GoogleFonts.greatVibes(
              fontSize: 50,
              color: AppColors.deepBlue,
            ),
          ),
          const SizedBox(height: 60),
          FadeOnScroll(
            scrollOffset: scrollOffset,
            triggerPoint: 1200,
            child: LocationCard(
              title: AppLocalizations.tr(context, 'church'),
              place: "Chiesa di San Pietro in Montorio",
              address: "Piazza di S. Pietro in Montorio, 2, 00153 Roma",
              imgAsset: "assets/images/chiesa3.jpg",
              isReversed: false,
              size: size,
              urlMap:
                  "https://www.google.com/maps/place/Chiesa+di+San+Pietro+in+Montorio/@41.8886261,12.4666187,764m/data=!3m2!1e3!4b1!4m6!3m5!1s0x132f603f333c90ef:0xd0fed33d1900ee7b!8m2!3d41.8886261!4d12.4666187!16zL20vMDhkMW0x?entry=ttu&g_ep=EgoyMDI2MDEyMS4wIKXMDSoASAFQAw%3D%3D",
            ),
          ),
          const SizedBox(height: 80),
          FadeOnScroll(
            scrollOffset: scrollOffset,
            triggerPoint: 1600,
            child: LocationCard(
              title: AppLocalizations.tr(context, 'venue'),
              place: "La Porta del Principe",
              address: "Via della Muratella Mezzana, Roma",
              imgAsset: "assets/images/location2.png",
              isReversed: true,
              size: size,
              urlMap:
                  "https://www.google.com/maps/place/La+Porta+del+Principe/@41.8886261,12.4666187,764m/data=!3m2!1e3!4b1!4m6!3m5!1s0x1325f6b399a17053:0x45831a6f7420ed9e!8m2!3d41.8886261!4d12.4666187!16zL20vMDhkMW0x?entry=ttu&g_ep=EgoyMDI2MDEyMS4wIKXMDSoASAFQAw%3D%3D",
            ),
          ),
        ],
      ),
    );
  }
}
