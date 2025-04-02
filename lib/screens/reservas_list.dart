import 'package:flutter/material.dart';

class ReservasList extends StatelessWidget {
  final List<Map<String, String>> reservas;
  const ReservasList({super.key, required this.reservas});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12.0),
            title: Text(
              reservas[index]['nombre']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              'Personas: ${reservas[index]['personas']} - Fecha: ${reservas[index]['fecha']}',
              style: const TextStyle(fontSize: 14),
            ),
            leading: const Icon(Icons.restaurant, color: Colors.blue),
          ),
        );
      },
    );
  }
}
