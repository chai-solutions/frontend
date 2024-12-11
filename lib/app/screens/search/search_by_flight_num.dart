import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chai/providers/http_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

class SearchByFlightNum extends ConsumerStatefulWidget {
  const SearchByFlightNum({super.key});

  @override
  SearchByFlightNumState createState() => SearchByFlightNumState();
}

class SearchByFlightNumState extends ConsumerState<SearchByFlightNum> {
  String outputFlightNum = '';
  String outputArrTime = '';
  String outputDepTime = '';
  String outputDepAP = '';
  String outputArrAP = '';

  final myController = TextEditingController();
  final planNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>?> searchNum(String flightNum) async {
      try {
        //authorize query
        final client = ref.read(httpClientProvider);
        //submit query
        final response = await client.get('/flights/$flightNum');
        final statusCode = response.statusCode;
        //flight found
        if (statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          setState(() {
            outputFlightNum = data['flight_number'].toString();
            outputArrTime = data['actual_arr_time'].toString();
            outputDepTime = data['actual_dep_time'].toString();
            outputDepAP = data['dep_name'].toString();
            outputArrAP = data['arrival_name'].toString();
          });
          return data;
        } else {
          //flight not found
          setState(() {
            outputFlightNum = 'NA';
            outputArrTime = 'NA';
            outputDepTime = 'NA';
            outputDepAP = 'NA';
            outputArrAP = 'NA';
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Error'),
                content: Text('Invalid flight code.'),
              ),
            );
          });
        }
      } catch (error) {
        // Invalid flight code
      }
      return null;
    }

    Future<Map<String, dynamic>?> addToFlightPlan(
        String flightNum, int planNum) async {
      try {
        //authorize query
        final client = ref.read(httpClientProvider);
        //submit query
        final response = await client
            .post('/flight_plans/$planNum', body: {"flightNumber": flightNum});
        final statusCode = response.statusCode;
        //flight found
        if (statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          setState(() {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Success!'),
                content: Text('Flight added to plan.'),
              ),
            );
            if (context.mounted) {
              context.go('/Home');
            }
          });
          return data;
        } else {
          setState(() {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Error'),
                content: Text(
                    'Could not add flight to flight plan. \nInvalid flight code.'),
              ),
            );
          });
        }
      } catch (error) {
        // Invalid flight code
      }
      return null;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 100.0,
            ),
            //button to go back home
            child: ElevatedButton.icon(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/searchHome');
                }
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Set the background color to white
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  children: [
                    //USER INPUT FIELD HERE
                    SizedBox(
                      width: 300,
                      child: TextField(
                        //allows for the transfer of info from text field to other places
                        controller: myController,
                        decoration: const InputDecoration(
                          labelText: 'Flight Code',
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          String userInput = myController.text;
                          await searchNum(userInput);
                        },
                        icon: const Icon(Icons.search),
                        label: const Text('Validate Flight'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),

                    //display current flight info
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Flight Code: $outputFlightNum',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Departure Time: $outputDepTime',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Arrival Time: $outputArrTime',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Startpoint: $outputDepAP',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Destination: $outputArrAP',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    //number of flight plan that flight will be added to
                    const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        //allows for the transfer of info from text field to other places
                        controller: planNumController,
                        //only numbers allowed in text field
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Flight Plan ID',
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          String userInput = myController.text;
                          if (planNumController.text.isEmpty) {
                            // Show error message (replace with your preferred method)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a flight plan ID'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return; // Exit the function if there's no input
                          } else {
                            int userPlanNum = int.parse(planNumController.text);
                            await addToFlightPlan(userInput, userPlanNum);
                          }
                        },
                        label: const Text('Add Flight'),
                        icon: const Icon(Icons.arrow_forward),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const Padding(padding: EdgeInsets.only(bottom: 150.0)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
