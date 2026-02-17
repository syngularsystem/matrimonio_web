import 'package:flutter/material.dart';
import 'package:matrimonio/ui/sections/hero_section.dart';
import 'package:matrimonio/ui/sections/quote_section.dart';
import 'package:matrimonio/ui/sections/timeline_section.dart';
import 'package:matrimonio/ui/sections/locations_section.dart';
import 'package:matrimonio/ui/sections/dresscode_section.dart';
import 'package:matrimonio/ui/sections/gift_section.dart';
import 'package:matrimonio/ui/sections/rsvp_section.dart';
import 'package:matrimonio/ui/sections/footer_section.dart';
import 'package:matrimonio/ui/widgets/intro_overlay.dart';
// Importa gli altri widget necessari...

class WeddingHomePage extends StatefulWidget {
  const WeddingHomePage({super.key});

  @override
  State<WeddingHomePage> createState() => _WeddingHomePageState();
}

class _WeddingHomePageState extends State<WeddingHomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _showIntroOverlay = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(scrollOffset: _scrollOffset, size: size),
                QuoteSection(scrollOffset: _scrollOffset),
                TimelineSection(scrollOffset: _scrollOffset),
                LocationsSection(scrollOffset: _scrollOffset, size: size),
                DressCodeSection(scrollOffset: _scrollOffset),
                GiftSection(scrollOffset: _scrollOffset),
                RsvpSection(scrollOffset: _scrollOffset),
                const FooterSection(),
              ],
            ),
          ),
          // Intro Overlay Widget (potresti estrarre anche questo)
          if (_showIntroOverlay)
            IntroOverlay(
              onDismiss: () => setState(() => _showIntroOverlay = false),
            ),
        ],
      ),
    );
  }
}
