import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class TimelineRow extends StatelessWidget {
  final String time;
  final String label;
  final bool isLeft;
  final IconData icon;
  final bool isMobile;

  const TimelineRow({
    super.key,
    required this.time,
    required this.label,
    required this.isLeft,
    required this.icon,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: isMobile ? 75 : 100,
          height: isMobile ? 75 : 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.sugarPaperDark, width: 2),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
          ),
          child: Icon(icon, color: AppColors.sugarPaperDark, size: 28),
        ),
        Text(
          label,
          textAlign: isLeft ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.greatVibes(
            fontSize: isMobile ? 32 : 45,
            color: AppColors.deepBlue,
          ),
        ),
        Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: isMobile ? 22 : 28,
            fontWeight: FontWeight.w300,
            color: AppColors.sugarPaperDark,
          ),
        ),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: isLeft
              ? Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: content,
                )
              : const SizedBox(),
        ),
        Expanded(
          child: !isLeft
              ? Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: content,
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
