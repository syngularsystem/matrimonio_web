import 'package:flutter/material.dart';

class FadeOnScroll extends StatelessWidget {
  final double scrollOffset;
  final double triggerPoint;
  final Widget child;

  const FadeOnScroll({
    super.key,
    required this.scrollOffset,
    required this.triggerPoint,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Logica: quando scrollOffset > triggerPoint - 600, mostra l'elemento
    // Ho mantenuto il 600 del tuo codice originale come offset visivo
    bool isVisible = scrollOffset > triggerPoint - 600;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: isVisible ? 1.0 : 0.0,
      curve: Curves.easeOutQuad,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 800),
        offset: isVisible ? Offset.zero : const Offset(0, 0.1),
        curve: Curves.easeOutQuad,
        child: child,
      ),
    );
  }
}
