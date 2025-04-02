import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservaForm extends StatefulWidget {
  final Function(String, String, String) onReserva;
  const ReservaForm({super.key, required this.onReserva});

  @override
  _ReservaFormState createState() => _ReservaFormState();
}

class _ReservaFormState extends State<ReservaForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _personasController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(finalDateTime);
        setState(() {
          _fechaController.text = formattedDateTime;
        });
      }
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onReserva(
        _nombreController.text,
        _personasController.text,
        _fechaController.text,
      );
      _nombreController.clear();
      _personasController.clear();
      _fechaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _personasController,
              decoration: const InputDecoration(
                labelText: 'Número de personas',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Ingrese número de personas' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha y hora',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDateTime,
                ),
              ),
              readOnly: true,
              validator: (value) => value!.isEmpty ? 'Seleccione la fecha y hora' : null,
            ),
            const SizedBox(height: 16.0),
            FilledButton(
              onPressed: _submit,
              child: const Text('Reservar'),
            ),
          ],
        ),
      ),
    );
  }
}