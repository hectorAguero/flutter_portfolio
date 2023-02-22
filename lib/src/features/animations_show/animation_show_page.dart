import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/animations_show/examples/example1.dart';
import 'package:flutter_portfolio/src/features/animations_show/examples/example2.dart';
import 'package:flutter_portfolio/src/features/animations_show/examples/example3.dart';
import 'package:flutter_portfolio/src/features/animations_show/examples/example4.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';

class AnimationShowPage extends StatefulWidget {
  // Vandad Animation Course examples, just for show widgets
  final List<Widget> examples;

  const AnimationShowPage(
      {super.key,
      this.examples = const [
        ExampleOne(),
        ExampleTwo(),
        ExampleThree(),
        ExampleFour(),
      ]});

  @override
  State<AnimationShowPage> createState() => _AnimationShowPageState();
}

class _AnimationShowPageState extends State<AnimationShowPage> {
  int? selectedExampleIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: !context.isMobile
            ? AppBar(
                title: const Text('Animations'),
                centerTitle: true,
                leading: selectedExampleIndex != null
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            selectedExampleIndex = null;
                          });
                        },
                      )
                    : null,
              )
            : null,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: selectedExampleIndex != null
              ? widget.examples.elementAt(selectedExampleIndex!)
              : GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.isDesktop ? 2 : 1,
                  ),
                  children: [
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            // ignore: avoid_unnecessary_containers
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: widget.examples.first,
                            )),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                customBorder: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                onTap: () {
                                  setState(() {
                                    selectedExampleIndex = 0;
                                  });
                                },
                              ),
                            )),
                      ],
                    ),
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            // ignore: avoid_unnecessary_containers
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: widget.examples[1])),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                customBorder: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                onTap: () {
                                  setState(() {
                                    selectedExampleIndex = 1;
                                  });
                                },
                              ),
                            )),
                      ],
                    ),
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            // ignore: avoid_unnecessary_containers
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: widget.examples[2])),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                customBorder: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                onTap: () {
                                  setState(() {
                                    selectedExampleIndex = 2;
                                  });
                                },
                              ),
                            )),
                      ],
                    ),
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            // ignore: avoid_unnecessary_containers
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: widget.examples.last)),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            // ignore: avoid_unnecessary_containers
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                customBorder: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                onTap: () {
                                  setState(() {
                                    selectedExampleIndex = 3;
                                  });
                                },
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
        ));
  }
}
