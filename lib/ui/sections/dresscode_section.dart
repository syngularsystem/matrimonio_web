import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/fade_on_scroll.dart';
import '../../data/l10n/app_localizations.dart';
import '../widgets/color_circle.dart';

class DressCodeSection extends StatelessWidget {
  final double scrollOffset;

  const DressCodeSection({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          FadeOnScroll(
            scrollOffset: scrollOffset,
            triggerPoint: 1600,
            child: Column(
              children: [
                Text(
                  AppLocalizations.tr(context, 'dressCode'),
                  style: GoogleFonts.greatVibes(
                    fontSize: 36,
                    color: AppColors.deepBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isMobile ? 4 : 6,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                  children: [
                    ColorCircle(
                      color: AppColors.oliveGreen,
                      isMobile: isMobile,
                    ),
                    ColorCircle(
                      color: AppColors.goldYellow,
                      isMobile: isMobile,
                    ),
                    ColorCircle(
                      color: AppColors.pastelYellow,
                      isMobile: isMobile,
                    ),
                    ColorCircle(color: AppColors.skyBlue, isMobile: isMobile),
                    ColorCircle(color: AppColors.blushPink, isMobile: isMobile),
                    ColorCircle(
                      color: AppColors.terracotta,
                      isMobile: isMobile,
                    ),
                    ColorCircle(color: AppColors.mintGreen, isMobile: isMobile),
                    ColorCircle(color: AppColors.lightGray, isMobile: isMobile),
                    ColorCircle(
                      color: const Color(0xFFEAF4F8),
                      isMobile: isMobile,
                    ),
                    ColorCircle(
                      color: const Color(0xFFB0C4DE),
                      isMobile: isMobile,
                    ),
                    ColorCircle(
                      color: AppColors.sugarPaperDark,
                      isMobile: isMobile,
                    ),
                    ColorCircle(color: AppColors.deepBlue, isMobile: isMobile),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.sugarPaperLight.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.deepBlue.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.tr(context, 'dressCodeText'),
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.deepBlue.withOpacity(0.9),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
