import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _departureController = TextEditingController();
  final _arrivalController = TextEditingController();
  final _airlineController = TextEditingController();
  final _flightNumberController = TextEditingController();
  DateTime? _selectedDate;

  List<Map<String, TextEditingController>> _additionalFlights = [];

  @override
  void dispose() {
    _departureController.dispose();
    _arrivalController.dispose();
    _airlineController.dispose();
    _flightNumberController.dispose();
    for (var flight in _additionalFlights) {
      flight['departure']?.dispose();
      flight['arrival']?.dispose();
      flight['airline']?.dispose();
      flight['flightNumber']?.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addFlightSection() {
    setState(() {
      _additionalFlights.add({
        'departure': TextEditingController(),
        'arrival': TextEditingController(),
        'airline': TextEditingController(),
        'flightNumber': TextEditingController(),
      });
    });
  }

  void _removeFlightSection(int index) {
    setState(() {
      _additionalFlights[index]['departure']?.dispose();
      _additionalFlights[index]['arrival']?.dispose();
      _additionalFlights[index]['airline']?.dispose();
      _additionalFlights[index]['flightNumber']?.dispose();
      _additionalFlights.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Your Trip',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _departureController,
                decoration: const InputDecoration(
                  labelText: 'Departure Airport',
                  prefixIcon: Icon(Icons.flight_takeoff),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _arrivalController,
                decoration: const InputDecoration(
                  labelText: 'Arrival Airport',
                  prefixIcon: Icon(Icons.flight_land),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _airlineController,
                decoration: const InputDecoration(
                  labelText: 'Airline',
                  prefixIcon: Icon(Icons.airplanemode_active),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _flightNumberController,
                decoration: const InputDecoration(
                  labelText: 'Flight Number',
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text(
                    'Scheduled Date: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    _selectedDate == null
                        ? 'No date chosen!'
                        : DateFormat.yMd().format(_selectedDate!),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const Divider(thickness: 1.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Do you have another flight?',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      if (_additionalFlights.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () => _removeFlightSection(
                              _additionalFlights.length - 1),
                        ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: _addFlightSection,
                      ),
                    ],
                  ),
                ],
              ),
              for (int i = 0; i < _additionalFlights.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Text(
                      'Flight ${i + 2}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent, // Light purple color
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _additionalFlights[i]['departure'],
                      decoration: const InputDecoration(
                        labelText: 'Departure Airport',
                        prefixIcon: Icon(Icons.flight_takeoff),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _additionalFlights[i]['arrival'],
                      decoration: const InputDecoration(
                        labelText: 'Arrival Airport',
                        prefixIcon: Icon(Icons.flight_land),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _additionalFlights[i]['airline'],
                      decoration: const InputDecoration(
                        labelText: 'Airline',
                        prefixIcon: Icon(Icons.airplanemode_active),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _additionalFlights[i]['flightNumber'],
                      decoration: const InputDecoration(
                        labelText: 'Flight Number',
                        prefixIcon: Icon(Icons.confirmation_number),
                      ),
                    ),
                    const Divider(thickness: 1.0),
                  ],
                ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // Save logic
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
