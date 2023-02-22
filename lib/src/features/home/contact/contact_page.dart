import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.isDesktop ? 2 : 1,
        ),
        children: <Widget>[
          Center(
            child: IconButton(
              onPressed: () async {
                if (!await launchUrlString('https://github.com/hectorAguero')) {
                  throw Exception('Could not launch');
                }
              },
              icon: FaIcon(FontAwesomeIcons.github,
                  size: 320, color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Center(
            child: IconButton(
              onPressed: () async {
                if (!await launchUrlString(
                    'https://www.linkedin.com/in/hector-aguero-2b9a04179/')) {
                  throw Exception('Could not launch');
                }
              },
              icon: const FaIcon(
                FontAwesomeIcons.linkedin,
                size: 320,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
