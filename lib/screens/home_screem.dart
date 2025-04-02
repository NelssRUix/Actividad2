import 'package:flutter/material.dart';
import '../widgets/background_image.dart';
import 'reserva_form.dart';
import 'reservas_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Map<String, String>> reservas = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _agregarReserva(String nombre, String personas, String fecha) {
    setState(() {
      reservas.add({'nombre': nombre, 'personas': personas, 'fecha': fecha});
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reserva realizada con éxito'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ReservaForm(onReserva: _agregarReserva),
      ReservasList(reservas: reservas),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Reserva de Mesas')),
      body: Stack(
        children: [
          const BackgroundImage(),
          Container(
            color: Colors.black.withOpacity(0.5),
            child: pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.event), label: 'Reservar'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Mis Reservas'),
        ],
      ),
    );
  }
}