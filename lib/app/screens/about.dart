import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: List.generate(5, (_) => const TeamMemberCard()),
          ),
        ),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: Image.asset(
                    'assets/public/trollface.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Card Title',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
