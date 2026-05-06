import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../providers/admin_controller.dart';
import '../../../data/models/rsvp_model.dart';

class AdminRsvpView extends StatefulWidget {
  const AdminRsvpView({super.key});

  @override
  State<AdminRsvpView> createState() => _AdminRsvpViewState();
}

class _AdminRsvpViewState extends State<AdminRsvpView> {
  @override
  void initState() {
    super.initState();
    // Recupera i dati all'avvio della vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminController>().fetchRsvps();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSVP Gestione (Tabella)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<AdminController>().fetchRsvps();
            },
            tooltip: 'Aggiorna Dati',
          ),
        ],
      ),
      body: Consumer<AdminController>(
        builder: (context, controller, child) {
          if (controller.status == AdminStatus.loading && controller.rsvps.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.status == AdminStatus.error) {
            return Center(
              child: Text(
                'Errore durante il caricamento: ${controller.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (controller.rsvps.isEmpty) {
            return const Center(child: Text('Nessun RSVP trovato.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Theme.of(context).colorScheme.primaryContainer),
                    columns: const [
                      DataColumn(label: Text('Nome', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Presenza', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Ospiti', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Data', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Lingua', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: controller.rsvps.map((rsvp) {
                      return DataRow(cells: [
                        DataCell(Text(rsvp.name)),
                        DataCell(Text(rsvp.email)),
                        DataCell(
                          Row(
                            children: [
                              Icon(
                                rsvp.presence ? Icons.check_circle : Icons.cancel,
                                color: rsvp.presence ? Colors.green : Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(rsvp.attendance),
                            ],
                          ),
                        ),
                        DataCell(
                          Tooltip(
                            message: rsvp.companions.isNotEmpty ? rsvp.companions.join(', ') : 'Nessuno',
                            child: Text(
                              '${rsvp.companions.length}',
                              style: const TextStyle(decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        DataCell(Text(
                          rsvp.timestamp != null
                              ? DateFormat('dd/MM/yyyy HH:mm').format(rsvp.timestamp!)
                              : 'N/A',
                        )),
                        DataCell(Text(rsvp.languageCode.toUpperCase())),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
