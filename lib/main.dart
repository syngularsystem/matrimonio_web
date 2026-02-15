// ignore_for_file: unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async'; // Per il countdown
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const WeddingApp());
}

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nataliya & Danny',
      theme: ThemeData(
        // Sfondo generale Carta da Zucchero molto chiaro/polvere
        scaffoldBackgroundColor: const Color(0xFFEAF4F8), 
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C8EA4)),
        useMaterial3: true,
      ),
      home: const WeddingHomePage(),
    );
  }
}

class WeddingHomePage extends StatefulWidget {
  const WeddingHomePage({super.key});

  @override
  State<WeddingHomePage> createState() => _WeddingHomePageState();
}

class _WeddingHomePageState extends State<WeddingHomePage> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  
  // Form Controllers
  final _nameController = TextEditingController();
  final _guestsController = TextEditingController(); // Aggiunto per ospiti
  String _attendance = 'sì';
  final List<String> _alcoholPrefs = [];

  // Palette Colori "Carta da Zucchero & Modern"
  final Color sugarPaperLight = const Color(0xFFD0E1E8); // Carta zucchero chiaro
  final Color sugarPaperDark = const Color(0xFF6C8EA4);  // Carta zucchero intenso
  final Color deepBlue = const Color(0xFF1B3A4B);        // Blu notte elegante
  final Color softWhite = const Color(0xFFFBFCFD);       // Bianco quasi puro

bool _showIntroOverlay = true;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

double get _timelineProgress {
  // valori da tarare in base a dove sta la sezione nella pagina
  const double start = 800;   // scrollOffset in cui la puntina entra nella linea
  const double end = 1800;    // scrollOffset in cui arriva in fondo

  final clamped = (_scrollOffset - start).clamp(0, end - start);
  return (clamped / (end - start));
}

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
      _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
  }
@override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _nameController.dispose();
    _guestsController.dispose();
    super.dispose();
  }

  void _onIntroButtonPressed() {
    // Avvia il fade out dell'overlay
    // _fadeController.forward().then((_) {
    //   setState(() {
    //     _showIntroOverlay = false;
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
          builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    
                    // 1. HERO SECTION (Immagine Nuova)
                    SizedBox(
                      height: size.height, 
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Immagine Background
                          Image.network(
                            "https://i1.wp.com/www.immaginesposiatelier.it/wp-content/uploads/2020/08/Coppia.jpg?resize=768%2C1024&ssl=1",
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter, // Centra bene i volti
                          ),
                          
                          // Gradiente Sfumato Moderno (Sopra e Sotto)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  deepBlue.withOpacity(0.3), // Leggero scuro sopra
                                  Colors.transparent,
                                  deepBlue.withOpacity(0.6), // Scuro sotto per testo
                                ],
                              ),
                            ),
                          ),
              
                          // Testi Hero
                          Positioned(
                            bottom: 100,
                            left: 20,
                            right: 20,
                            child: Column(
                              children: [
                                _FadeOnScroll(
                                  scrollOffset: _scrollOffset,
                                  triggerPoint: 0,
                                  child: Text(
                                    "Nataliya & Danny",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.greatVibes(
                                      fontSize: isMobile ? 55 : 90,
                                      color: softWhite,
                                      shadows: [const Shadow(blurRadius: 10, color: Colors.black38)],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _FadeOnScroll(
                                  scrollOffset: _scrollOffset,
                                  triggerPoint: 50,
                                  child: Text(
                                    "31 MAGGIO 2026",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: softWhite.withOpacity(0.9),
                                      letterSpacing: 4,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Icona scroll animata
                          Positioned(
                            bottom: 30,
                            left: 0, 
                            right: 0,
                            child: Center(
                              child: Icon(Icons.keyboard_arrow_down, color: softWhite.withOpacity(0.8), size: 35),
                            ),
                          )
                        ],
                      ),
                    ),
              
                    // SEZIONE 2: CITAZIONE & COUNTDOWN
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                      color: const Color(0xFFEAF4F8), // Sfondo continuo
                      child: Column(
                        children: [
                          _FadeOnScroll(
                            scrollOffset: _scrollOffset,
                            triggerPoint: 300,
                            child: Text(
                              "\"L'amore è l'unica cosa che raddoppia quando la si condivide.\"",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.greatVibes(fontSize: 36, color: sugarPaperDark),
                            ),
                          ),
                          const SizedBox(height: 40),
                          _FadeOnScroll(
                            scrollOffset: _scrollOffset,
                            triggerPoint: 400,
                            child: const CountdownTimer(),
                          ),
                        ],
                      ),
                    ),
              
                    // SEZIONE 3: TIMELINE (Solo qui binario curvo)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      color: Colors.white, // Stacco netto bianco per pulizia timeline
                      child: Stack(
                        children: [
                           Positioned.fill(
        child: CustomPaint(
          painter: TimelineCurvePainter(
            lineColor: sugarPaperDark,
            progress: _timelineProgress,
          ),
        ),
      ),
                          Column(
                            children: [
                              Text("Il Nostro Giorno", style: GoogleFonts.greatVibes(fontSize: 48, color: deepBlue)),
                              const SizedBox(height: 80),
              
                               _buildTimelineRow(
            "17:30",
            "Cerimonia",
            false,
            Icons.church,          // icona cerimonia
          ),
          const SizedBox(height: 80),

          _buildTimelineRow(
            "19:30",
            "Aperitivo",
            true,
            Icons.local_bar,       // icona aperitivo
          ),
          const SizedBox(height: 80),

          _buildTimelineRow(
            "21:00",
            "Cena",
            false,
            Icons.restaurant,      // icona cena
          ),
          const SizedBox(height: 80),

          _buildTimelineRow(
            "23:30",
            "Torta & Party",
            true,
            Icons.cake,            // icona torta/party
          ),
                            ],
                          ),
                        ],
                      ),
                    ),
              
                    // SEZIONE 4: LOCATIONS (Modern Card Design)
                    Container(
                      color: const Color(0xFFEAF4F8),
                      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                      child: Column(
                        children: [
                           Text("I Luoghi", style: GoogleFonts.greatVibes(fontSize: 50, color: deepBlue)),
                           const SizedBox(height: 60),
              
                           // CHIESA
                           _FadeOnScroll(
                             scrollOffset: _scrollOffset,
                             triggerPoint: 1200,
                             child: _buildModernLocationCard(
                               title: "La Cerimonia",
                               place: "Chiesa di San Pietro in Montorio",
                               address: " Piazza di S. Pietro in Montorio, 2, 00153 Roma",
                               imgAsset: "assets/images/chiesa3.jpg",
                               isReversed: false,
                               size: size,
                               urlMap: "https://www.google.com/maps/place/Chiesa+di+San+Pietro+in+Montorio/@41.8886261,12.4666187,764m/data=!3m2!1e3!4b1!4m6!3m5!1s0x132f603f333c90ef:0xd0fed33d1900ee7b!8m2!3d41.8886261!4d12.4666187!16zL20vMDhkMW0x?entry=ttu&g_ep=EgoyMDI2MDEyMS4wIKXMDSoASAFQAw%3D%3D"
                             ),
                           ),
              
                           const SizedBox(height: 80),
              
                           // LOCATION
                           _FadeOnScroll(
                             scrollOffset: _scrollOffset,
                             triggerPoint: 1600,
                             child: _buildModernLocationCard(
                               title: "Il Ricevimento",
                               place: "La Porta del Principe",
                               address: "Via della Muratella Mezzana, Roma",
                               imgAsset: "assets/images/location2.png",
                               isReversed: true, // Immagine a destra (su desktop)
                               size: size,
                                urlMap: "https://www.google.com/maps/place/La+Porta+del+Principe/@41.8886261,12.4666187,764m/data=!3m2!1e3!4b1!4m6!3m5!1s0x1325f6b399a17053:0x45831a6f7420ed9e!8m2!3d41.8886261!4d12.4666187!16zL20vMDhkMW0x?entry=ttu&g_ep=EgoyMDI2MDEyMS4wIKXMDSoASAFQAw%3D%3D", // Sostituisci con URL reale
                             ),
                           ),
                        ],
                      ),
                    ),
              
                    // SEZIONE 5: DRESS CODE & INFO
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                      color: Colors.white,
                      child: Column(
                        children: [
                          _FadeOnScroll(
                            scrollOffset: _scrollOffset,
                            triggerPoint: 2000,
                            child: Column(
                              children: [
                                Icon(Icons.checkroom, size: 40, color: sugarPaperDark),
                                const SizedBox(height: 20),
                                Text("Dress Code", style: GoogleFonts.greatVibes(fontSize: 42, color: deepBlue)),
                                const SizedBox(height: 20),
                                Text(
                                  "Graditi colori pastello: Azzurro, Carta da Zucchero, Blu Notte.\nEvitare il bianco.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey[700], height: 1.5),
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _colorCircle(const Color(0xFFEAF4F8)),
                                    _colorCircle(const Color(0xFFB0C4DE)),
                                    _colorCircle(const Color(0xFF6C8EA4)),
                                    _colorCircle(deepBlue),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    // SEZIONE 6: RSVP FORM
                    Container(
                      color: const Color(0xFFEAF4F8),
                      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                      child: _FadeOnScroll(
                        scrollOffset: _scrollOffset,
                        triggerPoint: 2400,
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 600),
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: sugarPaperDark.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text("Conferma Presenza", textAlign: TextAlign.center, style: GoogleFonts.greatVibes(fontSize: 40, color: deepBlue)),
                                const SizedBox(height: 10),
                                Text("Entro il 20 Aprile 2026", textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey)),
                                const SizedBox(height: 40),
              
                                _buildInput(_nameController, "Nome e Cognome"),
                                const SizedBox(height: 20),
                                _buildInput(_guestsController, "Numero Ospiti"),
                                const SizedBox(height: 30),
              
                                Text("Ci sarai?", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: deepBlue)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text("Sì"),
                                        value: 'sì',
                                        groupValue: _attendance,
                                        activeColor: sugarPaperDark,
                                        onChanged: (v) => setState(() => _attendance = v!),
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text("No"),
                                        value: 'no',
                                        groupValue: _attendance,
                                        activeColor: sugarPaperDark,
                                        onChanged: (v) => setState(() => _attendance = v!),
                                      ),
                                    ),
                                  ],
                                ),
              
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: deepBlue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    elevation: 5,
                                  ),
                                  child: const Text("INVIA CONFERMA", style: TextStyle(letterSpacing: 1.5)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              
                    // FOOTER
                    Container(
                      padding: const EdgeInsets.all(40),
                      color: deepBlue,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text("Nataliya & Danny", style: GoogleFonts.greatVibes(fontSize: 30, color: Colors.white)),
                          const SizedBox(height: 10),
                          Text("Grazie per essere parte della nostra storia.", style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                  
                  ],
                ),
              );
            }
          ),
                              if (_showIntroOverlay)

            FadeTransition(
                      opacity: Tween<double>(begin: 1.0, end: 0.0)
                          .animate(_fadeAnimation),
                      child: Container(
                        color: const Color.fromARGB(255, 111, 157, 182), // sfondo pieno (puoi cambiarlo)
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: _onIntroButtonPressed,
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(40),
                                  backgroundColor: softWhite,
                                  foregroundColor: deepBlue,
                                  elevation: 8,
                                ),
                                child: Icon(
                                  Icons.favorite, // qui puoi mettere anche una tua immagine
                                  size: 40,
                                  color: deepBlue,
                                ),
                              ),                Text(
                      "Work in progress...",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.greatVibes(
                        fontSize: 32,
                        color: softWhite,
                      ),
                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                 
        ],
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildTimelineRow(
  String time,
  String label,
  bool isLeft,
  IconData icon,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: isLeft
            ? Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,                  children: [
                    Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: sugarPaperDark, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5),
          ],
        ),
        child: Icon(
          icon,
          color: sugarPaperDark,
          size: 28,
        ),
      ),
                    Text(
                      label,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.greatVibes(
                        fontSize: 32,
                        color: deepBlue,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: sugarPaperDark,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),

      // Nodo centrale con icona dello step
      

      Expanded(
        child: !isLeft
            ? Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: sugarPaperDark, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5),
          ],
        ),
        child: Icon(
          icon,
          color: sugarPaperDark,
          size: 28,
        ),
      ),
                    Text(
                      label,
                      style: GoogleFonts.greatVibes(
                        fontSize: 32,
                        color: deepBlue,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: sugarPaperDark,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    ],
  );
}

 Widget _buildModernLocationCard({
  required String title,
  required String place,
  required String address,
  required String imgAsset,   // <--- cambio nome
  required bool isReversed,
  required Size size,
  String urlMap = "",
}) {
  final bool isMobile = size.width < 800;

  Widget imageSection = Container(
    height: 300,
    width: isMobile ? double.infinity : 400,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 20,
          offset: Offset(0, 10),
        )
      ],
      image: DecorationImage(
        image: AssetImage(imgAsset), // <--- asset
        fit: BoxFit.cover,
      ),
    ),
  );


Widget textSection = Column(
    crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    children: [
      Text(title,
          style: GoogleFonts.greatVibes(fontSize: 36, color: sugarPaperDark)),
      const SizedBox(height: 10),
      Text(
        place,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: deepBlue,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        address,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 20),
      OutlinedButton.icon(
        onPressed: urlMap.isEmpty
            ? null
            : () async {
                final uri = Uri.parse(urlMap);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication, // apre app mappe se possibile
                  );
                } else {
                  // opzionale: fallback / snackbar
                }
              },
        icon: const Icon(Icons.map),
        label: const Text("VEDI MAPPA"),
        style: OutlinedButton.styleFrom(
          foregroundColor: deepBlue,
          side: BorderSide(color: deepBlue),
        ),
      ),
    ],
  );
    if (isMobile) {
      return Column(children: [imageSection, const SizedBox(height: 30), textSection]);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isReversed 
          ? [textSection, const SizedBox(width: 50), imageSection]
          : [imageSection, const SizedBox(width: 50), textSection],
      );
    }
  }

  Widget _buildInput(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: deepBlue.withOpacity(0.6)),
        filled: true,
        fillColor: const Color(0xFFF0F7FA), // Input leggermente colorato
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: sugarPaperDark)),
      ),
    );
  }

  Widget _colorCircle(Color c) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 50, height: 50,
      decoration: BoxDecoration(
        color: c,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
    );
  }
}

// --- WIDGETS DI SUPPORTO ---

// Countdown Timer semplice (Placeholder)
class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
   late DateTime _targetDate;
  late Timer _timer;

  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    // Data dell’evento: 31 maggio 2026 alle 17:30 (metti l’ora che vuoi)
    _targetDate = DateTime(2026, 5, 31, 17, 30);

    _calculateDiff(); // calcolo iniziale

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateDiff();
    });
  }

  void _calculateDiff() {
    final now = DateTime.now();
    Duration diff = _targetDate.difference(now); // target - now[web:67]

    if (diff.isNegative) {
      // Evento passato: azzero o gestisci come preferisci
      setState(() {
        _days = 0;
        _hours = 0;
        _minutes = 0;
        _seconds = 0;
      });
      return;
    }

    setState(() {
      _days = diff.inDays;
      _hours = diff.inHours.remainder(24);
      _minutes = diff.inMinutes.remainder(60);
      _seconds = diff.inSeconds.remainder(60);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timeBlock(_days.toString().padLeft(2, '0'), "Giorni"),
        _separator(),
        _timeBlock(_hours.toString().padLeft(2, '0'), "Ore"),
        _separator(),
        _timeBlock(_minutes.toString().padLeft(2, '0'), "Minuti"),
        _separator(),
        _timeBlock(_seconds.toString().padLeft(2, '0'), "Secondi"),
      ],
    );
  }

  Widget _timeBlock(String num, String label) {
    return Column(
      children: [
        Text(
          num,
          style: GoogleFonts.montserrat(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A4B),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _separator() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          ":",
          style: TextStyle(fontSize: 20, color: Colors.grey[400]),
        ),
      );
  }

  Widget _timeBlock(String num, String label) {
    return Column(
      children: [
        Text(num, style: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A4B))),
        Text(label, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _separator() => Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text(":", style: TextStyle(fontSize: 20, color: Colors.grey[400])));


// Animazione Fade On Scroll
class _FadeOnScroll extends StatelessWidget {
  final double scrollOffset;
  final double triggerPoint;
  final Widget child;

  const _FadeOnScroll({required this.scrollOffset, required this.triggerPoint, required this.child});

  @override
  Widget build(BuildContext context) {
    // Logica: quando scrollOffset > triggerPoint - 600, mostra l'elemento
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

class TimelineCurvePainter extends CustomPainter {
  final Color lineColor;
  final double progress; // 0..1

  TimelineCurvePainter({
    required this.lineColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final double cx = size.width / 2;

    path.moveTo(cx, 100);
    path.cubicTo(cx + 100, 150, cx - 100, 300, cx, 450);
    path.cubicTo(cx + 100, 600, cx - 100, 750, cx, 900);
    // path.cubicTo(cx + 100, 900, cx - 100, 900, cx, 900);

    // Disegna la linea
    canvas.drawPath(path, paint);

    // Se vogliamo far camminare l’icona
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;

    final double distance = metric.length * progress.clamp(0.0, 1.0);
    final tangent = metric.getTangentForOffset(distance);
    if (tangent == null) return;

    final Offset pos = tangent.position;

    // Disegna il “contenitore” con icona
    const double radius = 22.0;
    final circlePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(pos, radius, circlePaint);

    // Se vuoi un bordo bianco intorno
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(pos, radius, borderPaint);

    // Icona (es. cuore) disegnata via TextPainter per semplicità
    const icon = Icons.favorite;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 25,
          fontFamily: icon.fontFamily,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final iconOffset = pos -
        Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, iconOffset);
  }

  @override
  bool shouldRepaint(covariant TimelineCurvePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.lineColor != lineColor;
  }
}
