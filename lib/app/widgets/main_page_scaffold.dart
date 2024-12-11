import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPageScaffold extends StatelessWidget {
  final String? title;
  final Widget child;

  const MainPageScaffold({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 16.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: title != null
                                ? Text(
                                    title!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                        Positioned(
                          top: 16.0,
                          right: 16.0,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context.push('/notifications');
                                },
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context.push('/settings');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: child,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
