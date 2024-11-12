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

  @override
  void dispose() {
    _departureController.dispose();
    _arrivalController.dispose();
    _airlineController.dispose();
    _flightNumberController.dispose();
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
      body: Padding(
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
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set button color to blue
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Save the trip plan
                    // You may also want to add validation for input fields here
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
