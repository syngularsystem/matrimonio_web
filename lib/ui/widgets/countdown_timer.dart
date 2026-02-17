import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonio/data/l10n/app_localizations.dart';
import '../../core/constants/app_colors.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late DateTime _targetDate;
  late Timer _timer;
  int _days = 0, _hours = 0, _minutes = 0, _seconds = 0;

  @override
  void initState() {
    super.initState();
    _targetDate = DateTime(2026, 5, 31, 17, 30);
    _calculateDiff();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _calculateDiff(),
    );
  }

  void _calculateDiff() {
    final now = DateTime.now();
    Duration diff = _targetDate.difference(now);
    if (diff.isNegative) {
      if (mounted) setState(() => _days = _hours = _minutes = _seconds = 0);
      return;
    }
    if (mounted) {
      setState(() {
        _days = diff.inDays;
        _hours = diff.inHours.remainder(24);
        _minutes = diff.inMinutes.remainder(60);
        _seconds = diff.inSeconds.remainder(60);
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _timeBlock(
          _days.toString().padLeft(2, '0'),
          AppLocalizations.tr(context, 'days'),
        ),
        _separator(),
        _timeBlock(
          _hours.toString().padLeft(2, '0'),
          AppLocalizations.tr(context, 'hours'),
        ),
        _separator(),
        _timeBlock(
          _minutes.toString().padLeft(2, '0'),
          AppLocalizations.tr(context, 'minutes'),
        ),
        _separator(),
        _timeBlock(
          _seconds.toString().padLeft(2, '0'),
          AppLocalizations.tr(context, 'seconds'),
        ),
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
            color: AppColors.deepBlue,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _separator() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Text(":", style: TextStyle(fontSize: 20, color: Colors.grey[400])),
  );
}
