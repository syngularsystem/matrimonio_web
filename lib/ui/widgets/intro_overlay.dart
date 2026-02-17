import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class IntroOverlay extends StatefulWidget {
  final VoidCallback onDismiss;

  const IntroOverlay({super.key, required this.onDismiss});

  @override
  State<IntroOverlay> createState() => _IntroOverlayState();
}

class _IntroOverlayState extends State<IntroOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
  }

  void _handlePress() {
    _fadeController.forward().then((_) {
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_fadeAnimation),
      child: Container(
        color: const Color.fromARGB(255, 111, 157, 182),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _handlePress,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(40),
                  backgroundColor: AppColors.softWhite,
                  foregroundColor: AppColors.deepBlue,
                  elevation: 8,
                ),
                child: const Icon(
                  Icons.favorite,
                  size: 40,
                  color: AppColors.deepBlue,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Tap here...",
                textAlign: TextAlign.center,
                style: GoogleFonts.greatVibes(
                  fontSize: 32,
                  color: AppColors.softWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
