import 'package:chai/app/widgets/buttons.dart';
import 'package:chai/app/widgets/toasts.dart';
import 'package:chai/controllers/auth.dart';
import 'package:chai/models/flight_plan/flight_plan.dart';
import 'package:chai/repository/flight_plan.dart';
import 'package:chai/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:chai/providers/http_client.dart';
import 'package:chai/utils/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:math';

String outputFlightNum = 'NA';
String outputArrTime = 'NA';
String outputDepTime = 'NA';
String outputDepAP = 'NA';
String outputArrAP = 'NA';

final depController = TextEditingController();
final arrController = TextEditingController();
final planNumController = TextEditingController();

class SearchByAirport extends ConsumerStatefulWidget {
  const SearchByAirport({super.key});
  @override
  _SearchByAirportState createState() => _SearchByAirportState();
}

class _SearchByAirportState extends ConsumerState<SearchByAirport> {
  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>?> searchFlightAirport(
        String depAir, String arrAir) async {
      final baseURL = Env().baseURL;
      try {
        print('search depature aiport: $depAir');
        print('search arrival aiport: $arrAir');
        //authorize query
        final client = ref.read(httpClientProvider);
        //submit query
        final response = await client
            .get('/flights?departure_airport=SFO&arrival_airport=MIA');
        final statusCode = response.statusCode;
        //flight found
        if (statusCode == 200) {
          print('flight found');
          final listData = jsonDecode(response.body) as List<dynamic>;

          //REPLACE LATER!!! just gets information on first flight meeting parameters, must display flights as a list when we get more
          print('$listData');
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
          print('Failed to fetch pokemon data. Status code: $statusCode');
          setState(() {
            outputFlightNum = 'NA';
            outputArrTime = 'NA';
            outputDepTime = 'NA';
            outputDepAP = 'NA';
            outputArrAP = 'NA';
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Invalid flight code.'),
              ),
            );
          });
        }
      } catch (error) {
        print("Invalid Flight. Error: $error");
      }
    }

    Future<Map<String, dynamic>?> addToFlightPlan(
        String flightNum, int planNum) async {
      final baseURL = Env().baseURL;
      try {
        print('searchFlightNum: $flightNum');
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
              builder: (context) => AlertDialog(
                title: Text('Success!'),
                content: Text('Flight added to plan.'),
              ),
            );
          });
          return data;
        } else {
          //flight not found
          print('Failed to add flight. Status code: $statusCode');
          setState(() {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(
                    'Could not add flight to flight plan. \nInvalid flight code.'),
              ),
            );
          });
        }
      } catch (error) {
        print("Invalid Flight Code");
      }
    }

    final user = ref.watch(currentUserProvider);
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
                final authController =
                    ref.read(authControllerProvider.notifier);
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
                padding: EdgeInsets.only(top: 5.0),
                child: Column(
                  children: [
                    //USER INPUT FIELD HERE
                    SizedBox(
                      width: 300,
                      child: TextField(
                        //allows for the transfer of info from text field to other places
                        controller: depController,
                        decoration: InputDecoration(
                          labelText: 'Departure Airport Code',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        //allows for the transfer of info from text field to other places
                        controller: arrController,
                        decoration: InputDecoration(
                          labelText: 'Arrival Airport Code',
                        ),
                      ),
                    ),
                    //Search Submit button
                    Padding(padding: const EdgeInsets.all(5.0)),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final authController =
                              ref.read(authControllerProvider.notifier);
                          //context.go('/home');
                          String userInputDep = depController.text;
                          String userInputArr = arrController.text;
                          print(
                              'USER INPUT:\nDepature Airport: $userInputDep\nArrival Airport: $userInputArr');
                          final flightData = await searchFlightAirport(
                              userInputDep, userInputArr);
                        },
                        icon: const Icon(Icons.search),
                        label: const Text('Search For Flight'),
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
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Arrival Time: $outputArrTime',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Departure Time: $outputDepTime',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Startpoint: $outputDepAP',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Destination: $outputArrAP',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    //number of flight plan that flight will be added to
                    Padding(padding: EdgeInsets.only(bottom: 20.0)),
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
                        decoration: InputDecoration(
                          labelText: 'Add Flight To This Plan',
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final authController =
                              ref.read(authControllerProvider.notifier);
                          //context.go('/home');
                          String userInput = outputFlightNum;
                          //convert flight plan number input into int
                          int userPlanNum = int.parse(planNumController.text);
                          print('Adding Flight: $userInput');
                          final flightData =
                              await addToFlightPlan(userInput, userPlanNum);
                        },
                        label: const Text('Flight Plan Number'),
                        icon: const Icon(Icons.arrow_forward),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
