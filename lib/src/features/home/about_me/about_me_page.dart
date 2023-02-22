import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  double containerSize = 360;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        children: [
          if (!context.isDesktop)
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('Flutter Developer',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold)),
            ),
          Row(
            children: [
              if (context.isDesktop)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text('Flutter Developer',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.github),
                    const SizedBox(width: 8),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      transformAlignment: AlignmentDirectional.center,
                      transform: Matrix4.identity()..scale(containerSize / 500),
                      height: containerSize,
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [0.0, 0.3, 1.0],
                            colors: <Color>[
                              Colors.white,
                              Colors.blueAccent.shade400,
                              Colors.redAccent,
                            ],
                            tileMode: TileMode.clamp,
                          ).createShader(bounds);
                        },
                        child: IconButton(
                          iconSize: containerSize / 2,
                          onPressed: () {
                            setState(() {
                              containerSize = containerSize == 360 ? 500 : 360;
                            });
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.userAstronaut,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(FontAwesomeIcons.linkedin),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16),
                  child: Text(
                    '''Worked with Flutter for 3 years, creating apps for Android and iOS with a single codebase, mostly using with Provider and ChangeNotifier for state management, with communication with REST APIs, Firebase for authentication and storage,  Google Maps and location packages, and cache packages like Hive and Shared Preferences, Secure Storage.  

I also have experience with Flutter Web, Riverpod, Go Router, Freezed, Animations, and many other popular packages.

And I have some experience with NodeJS, Python, PHP, and Google Cloud Platform, as well as with databases like MySQL, PostgreSQL and noSQL.''',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 24),
                  ),
                ),
              ),
              if (context.isDesktop)
                Expanded(
                  child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runAlignment: WrapAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.nodeJs,
                          size: 64, color: Colors.green),
                      FaIcon(FontAwesomeIcons.python,
                          size: 64, color: Colors.yellow),
                      FaIcon(FontAwesomeIcons.php,
                          size: 64, color: Colors.blue),
                      FaIcon(FontAwesomeIcons.google,
                          size: 64, color: Colors.red),
                      FaIcon(FontAwesomeIcons.database,
                          size: 64, color: Colors.blueGrey)
                    ],
                  ),
                ),
            ],
          ),
          if (!context.isDesktop)
            Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runAlignment: WrapAlignment.center,
              children: const [
                FaIcon(FontAwesomeIcons.nodeJs, size: 64, color: Colors.green),
                FaIcon(FontAwesomeIcons.python, size: 64, color: Colors.yellow),
                FaIcon(FontAwesomeIcons.php, size: 64, color: Colors.blue),
                FaIcon(FontAwesomeIcons.google, size: 64, color: Colors.red),
                FaIcon(FontAwesomeIcons.database,
                    size: 64, color: Colors.blueGrey)
              ],
            ),
        ],
      ),
    ));
  }
}
