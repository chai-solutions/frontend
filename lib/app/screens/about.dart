import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonRecord {
  final String name;
  final String role;
  final Image image;
  final Widget extraInformation;

  PersonRecord(
      {required this.name,
      required this.role,
      required this.image,
      required this.extraInformation});
}

class VarunExtraInfo extends StatelessWidget {
  const VarunExtraInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('Aspiring, but never achieving.'),
      const SizedBox(height: 10),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text:
                  "I love building software, and have been a professional developer since 2020, when I graudated high school. I'm looking for work, in case anyone is hiring, so here is my ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            TextSpan(
              text: 'resume',
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(
                      'https://raw.githubusercontent.com/water-sucks/resume/main/resume.pdf');
                },
            ),
            TextSpan(
                text: " in case you happen to be hiring! :}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                )),
          ],
        ),
      ),
      const SizedBox(height: 10),
      RichText(
        text: TextSpan(
            text:
                "I also love music; I play the drums, and can compose as well. And in a surprising turn of events, I also love watching football (Raider Nation 4 Life!)",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            )),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}

final List<PersonRecord> teamMembers = [
  PersonRecord(
    name: "Matt Stoffel",
    role: "Team Lead Engineer",
    // Fill specifically for Matt's image only, because it looks the
    // most funny that way.
    image: Image.asset('assets/images/matt.png', fit: BoxFit.fill),
    extraInformation: const Text('goodbye, cruel world!'),
  ),
  PersonRecord(
    name: "Varun Narravula",
    role: "Frontend Lead Engineer/DevOps Engineer",
    image: Image.asset('assets/images/water-sucks.png', fit: BoxFit.cover),
    extraInformation: const VarunExtraInfo(),
  ),
  PersonRecord(
    name: "Vignesh Guruswami",
    role: "Backend Lead Engineer",
    image: Image.asset('assets/images/whale.png', fit: BoxFit.cover),
    extraInformation: const Text('goodbye, cruel world!'),
  ),
  PersonRecord(
    name: "Thamizarasu Sankara",
    role: "Full-Stack Engineer/Scrum Master",
    image: Image.asset('assets/images/DoctorLegend.jpg', fit: BoxFit.cover),
    extraInformation: const Text('goodbye, cruel world!'),
  ),
  PersonRecord(
    name: "Arjun Bhagat",
    role: "Frontend Engineer",
    image: Image.asset('assets/images/trollface.png', fit: BoxFit.cover),
    extraInformation: const Text('goodbye, cruel world!'),
  ),
  PersonRecord(
    name: "Robert Ace Gonzales",
    role: "Backend Engineer",
    image: Image.asset('assets/images/robert.png', fit: BoxFit.cover),
    extraInformation: const Text('goodbye, cruel world!'),
  ),
  PersonRecord(
    name: "Justin Doi",
    role: "Full-Stack Engineer",
    image: Image.asset('assets/images/justin.jpg', fit: BoxFit.cover),
    extraInformation: const Text('goodbye, cruel world!'),
  )
];

const groupDescription =
    "We are Chai Solutions, a group that came into existence for a software engineering class at our university: specifically, CSC-648 at San Francisco State University. Our group came together during the Fall 2024 semester, in Dr. Isabel Hyo Jung Song's Section 04; internally we are Team #5. As a part of this class, Chai Solutions showcases the expertise and methodologies applied to real-world development challenges, and demonstrates our ability to architect, design, and implement complex software systems.";

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'Brewing innovative software.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset('assets/images/app-icon.svg', height: 300),
            const SizedBox(height: 20),
            const Text(groupDescription),
            const SizedBox(height: 20),
            Text(
              'Team Members',
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Column(
              children: teamMembers
                  .map(
                    (member) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: _TeamMemberCard(
                          key: Key(member.name), memberInfo: member),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final PersonRecord memberInfo;

  const _TeamMemberCard({super.key, required this.memberInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openInfoModal(context),
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: memberInfo.image,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        memberInfo.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        memberInfo.role,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openInfoModal(BuildContext context) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      context: context,
      constraints: BoxConstraints.tight(
        Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  memberInfo.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  memberInfo.role,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: memberInfo.image,
                ),
                const SizedBox(height: 10),
                memberInfo.extraInformation,
              ],
            ),
          ),
        );
      },
    );
  }
}
