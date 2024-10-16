import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.children,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBranchContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
          ),
          child: BottomNavigationBar(
            elevation: 20,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.coffee_rounded), label: 'About'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.login), label: 'Login'), // Added Login
            ],
            currentIndex: navigationShell.currentIndex,
            onTap: (int index) => _onTap(context, index),
            unselectedFontSize: 14.0,
            selectedFontSize: 14.0,
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    if (index == 2) {
      // If the login button is tapped, navigate to the login screen
      context.push('/login');
    } else {
      // Handle navigation between Home and About tabs
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }
  }
}

/// Custom branch Navigator container that provides animated transitions
/// when switching branches.
class AnimatedBranchContainer extends StatelessWidget {
  /// Creates a AnimatedBranchContainer
  const AnimatedBranchContainer(
      {super.key, required this.currentIndex, required this.children});

  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      (int index, Widget navigator) {
        return AnimatedOpacity(
          opacity: index == currentIndex ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: _branchNavigatorWrapper(index, navigator),
        );
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) {
    return IgnorePointer(
      ignoring: index != currentIndex,
      child: TickerMode(
        enabled: index == currentIndex,
        child: navigator,
      ),
    );
  }
}
