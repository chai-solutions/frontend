import 'package:flutter/material.dart';
import 'package:chai/providers/http_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

class AddByAirport extends ConsumerStatefulWidget {
  final int? inputPlanId;
  const AddByAirport({super.key, required this.inputPlanId});
  //gets flight plan number for this page
  get inputFlightId => inputPlanId;

  @override
  AddByAirportState createState() => AddByAirportState();
}

class AddByAirportState extends ConsumerState<AddByAirport> {
  int planId = 0;

  String outputFlightNum = 'NA';
  String outputArrTime = 'NA';
  String outputDepTime = 'NA';
  String outputDepAP = 'NA';
  String outputArrAP = 'NA';

  final depController = TextEditingController();
  final arrController = TextEditingController();
  final dateController = TextEditingController();
  final airlineController = TextEditingController();
  final planNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    planId = widget.inputPlanId!; //sets this screen's current flight plan
    Future<Map<String, dynamic>?> searchFlightAirport(
        String depAir, String arrAir, String inputDate) async {
      try {
        //authorize query
        final client = ref.read(httpClientProvider);
        //submit query
        final response = await client.get(
            '/flights?departure_airport=$depAir&arrival_airport=$arrAir&sched_dep_time=$inputDate');
        final statusCode = response.statusCode;
        //flight found
        if (statusCode == 200) {
          final listData = jsonDecode(response.body) as List<dynamic>;

          //REPLACE LATER!!! just gets information on first flight meeting parameters, must display flights as a list when we get more
          final data = listData[0];
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

          //final data = jsonDecode(response.body) as Map<String, dynamic>;
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
                content: Text('Invalid flight data.'),
              ),
            );
          });
        }
      } catch (error) {
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
              content: Text('Invalid flight info.'),
            ),
          );
        });
      }
      return null;
    }

    //date picker
    Future<void> selectDate() async {
      DateTime? userInputDate0 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2150),
      );
      if (userInputDate0 != null) {
        setState(() {
          dateController.text = userInputDate0.toString().split(" ")[0];
        });
      }
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
            //send user back to flight plan when finished adding flight to plan
            if (context.mounted) {
              context.go('/addDeleteFlight/$planId');
            }
          });
          return data;
        } else {
          //flight not found
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
        // Invalid flight detected
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
                  context.go('/editPlanHome/$planId');
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
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Add Flight to Plan $planId',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //USER INPUT FIELD HERE
                    SizedBox(
                      width: 300,
                      child: TextField(
                        //allows for the transfer of info from text field to other places
                        controller: depController,
                        decoration: const InputDecoration(
                          labelText: 'Departure Airport Code',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        //allows for the transfer of info from text field to other places
                        controller: arrController,
                        decoration: const InputDecoration(
                          labelText: 'Arrival Airport Code',
                        ),
                      ),
                    ),
                    //Search Submit button
                    const Padding(padding: EdgeInsets.all(5.0)),

                    SizedBox(
                      width: 300,
                      child: TextField(
                          //allows for the transfer of info from text field to other places
                          controller: dateController,
                          decoration: const InputDecoration(
                            labelText: 'Departure Date',
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () {
                            selectDate();
                          }),
                    ),

                    //Search Submit button
                    const Padding(padding: EdgeInsets.all(5.0)),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          String userInputDep = depController.text;
                          String userInputArr = arrController.text;
                          String userInputDate = dateController.text;
                          await searchFlightAirport(
                            userInputDep,
                            userInputArr,
                            userInputDate,
                          );
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
                    const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          String userInput = outputFlightNum;
                          int userPlanNum = planId;
                          await addToFlightPlan(userInput, userPlanNum);
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
          const Padding(padding: EdgeInsets.only(bottom: 100.0)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    depController.dispose();
    arrController.dispose();
    dateController.dispose();
    airlineController.dispose();
    planNumController.dispose();
  }
}
