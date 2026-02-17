import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/l10n/app_localizations.dart';
import '../widgets/timeline_painter.dart';
import '../widgets/timeline_row.dart';

class TimelineSection extends StatelessWidget {
  final double scrollOffset;
  const TimelineSection({super.key, required this.scrollOffset});

  double get _timelineProgress {
    const double start = 800;
    const double end = 1800;
    final clamped = (scrollOffset - start).clamp(0, end - start);
    return (clamped / (end - start));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: TimelineCurvePainter(
                lineColor: AppColors.sugarPaperDark,
                progress: _timelineProgress,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                AppLocalizations.tr(context, 'timelineTitle'),
                style: GoogleFonts.greatVibes(
                  fontSize: 48,
                  color: AppColors.deepBlue,
                ),
              ),
              const SizedBox(height: 80),
              TimelineRow(
                time: "17:30",
                label: AppLocalizations.tr(context, 'ceremony'),
                isLeft: false,
                icon: Icons.church,
                isMobile: isMobile,
              ),
              const SizedBox(height: 80),
              TimelineRow(
                time: "19:30",
                label: AppLocalizations.tr(context, 'cocktail'),
                isLeft: true,
                icon: Icons.local_bar,
                isMobile: isMobile,
              ),
              const SizedBox(height: 80),
              TimelineRow(
                time: "21:00",
                label: AppLocalizations.tr(context, 'dinner'),
                isLeft: false,
                icon: Icons.restaurant,
                isMobile: isMobile,
              ),
              const SizedBox(height: 80),
              TimelineRow(
                time: "23:30",
                label: AppLocalizations.tr(context, 'cake'),
                isLeft: true,
                icon: Icons.cake,
                isMobile: isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
