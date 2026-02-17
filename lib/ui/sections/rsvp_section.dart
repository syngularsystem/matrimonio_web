// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/fade_on_scroll.dart';
import '../../data/l10n/app_localizations.dart';
import '../../providers/rsvp_provider.dart';

class RsvpSection extends StatefulWidget {
  final double scrollOffset;
  const RsvpSection({super.key, required this.scrollOffset});

  @override
  State<RsvpSection> createState() => _RsvpSectionState();
}

class _RsvpSectionState extends State<RsvpSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool confirmedPresence = true;
  String _attendance = 'sì'; // Valore default per i radio button

  List<String> companions = [];
  final List<TextEditingController> companionControllers = [];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    for (var controller in companionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addCompanion() {
    if (companions.length < 10) {
      setState(() {
        companions.add('');
        companionControllers.add(TextEditingController());
      });
    }
  }

  void _removeCompanion(int index) {
    setState(() {
      companions.removeAt(index);
      companionControllers[index].dispose();
      companionControllers.removeAt(index);
    });
  }

  void _submitForm() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.tr(context, 'CompilaValidator')),
        ),
      );
      return;
    }

    // Sincronizza i testi dei controller nella lista stringhe
    for (int i = 0; i < companionControllers.length; i++) {
      companions[i] = companionControllers[i].text;
    }

    // Chiama il provider
    final provider = context.read<RSVPProvider>();
    await provider.submitRSVP(
      name: _nameController.text,
      email: _emailController.text,
      presence: confirmedPresence,
      companions: companions,
      attendance: _attendance,
      languageCode: Localizations.localeOf(context).languageCode,
    );

    if (!mounted) return;

    // Gestione risultato
    if (provider.status == RsvpStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.tr(context, 'thanks'))),
      );
      _clearForm();
      provider.reset();
    } else if (provider.status == RsvpStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore: ${provider.errorMessage}')),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      confirmedPresence = false;
      companions.clear();
      for (var c in companionControllers) c.dispose();
      companionControllers.clear();
      _attendance = 'sì';
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = context.watch<RSVPProvider>().status;
    final isLoading = status == RsvpStatus.loading;

    return Container(
      color: AppColors.scaffoldBackground,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: FadeOnScroll(
        scrollOffset: widget.scrollOffset,
        triggerPoint: 2400,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.sugarPaperDark.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.tr(context, 'submit'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.greatVibes(
                    fontSize: 40,
                    color: AppColors.deepBlue,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.tr(context, 'expDateRsvp'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),

                // Nome
                _buildInput(
                  _nameController,
                  AppLocalizations.tr(context, 'name'),
                ),
                const SizedBox(height: 20),

                // Email
                _buildInput(
                  _emailController,
                  AppLocalizations.tr(context, 'email'),
                ),

                // Sezione Accompagnatori (visibile solo se presente)
                const SizedBox(height: 20),

                // Radio Buttons Partecipazione
                Text(
                  AppLocalizations.tr(context, 'attendance'),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepBlue,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(AppLocalizations.tr(context, 'yes')),
                        value:
                            'sì', // Usa chiavi fisse o localizzate coerentemente
                        groupValue: _attendance,
                        activeColor: AppColors.sugarPaperDark,
                        onChanged: (v) => setState(() {
                          _attendance = v!;
                          confirmedPresence = true;
                        }),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(AppLocalizations.tr(context, 'no')),
                        value: 'no',
                        groupValue: _attendance,
                        activeColor: AppColors.sugarPaperDark,
                        onChanged: (v) => setState(() {
                          _attendance = v!;
                          confirmedPresence = false;
                        }),
                      ),
                    ),
                  ],
                ),
                if (confirmedPresence == true) ...[
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.tr(context, 'companions'),
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  ...companionControllers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final controller = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.tr(
                                  context,
                                  'yourName',
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red[300],
                            ),
                            onPressed: () => _removeCompanion(index),
                          ),
                        ],
                      ),
                    );
                  }),
                  if (companions.length < 10)
                    TextButton.icon(
                      onPressed: _addCompanion,
                      icon: const Icon(Icons.add),
                      label: Text(AppLocalizations.tr(context, 'addCompanion')),
                    ),
                ],
                const SizedBox(height: 40),

                // Bottone Invio
                ElevatedButton(
                  onPressed: isLoading ? null : _submitForm,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          AppLocalizations.tr(context, 'submit'),
                          style: const TextStyle(letterSpacing: 1.5),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        // Lo stile è ereditato da AppTheme, ma puoi sovrascriverlo qui se necessario
      ),
    );
  }
}
