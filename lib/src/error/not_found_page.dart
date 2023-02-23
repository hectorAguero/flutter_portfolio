import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The screen of the error page.
class NotFoundPage extends StatelessWidget {
  /// Creates an [NotFoundPage].
  const NotFoundPage(this.error, {Key? key}) : super(key: key);

  /// The error to display.
  final Exception error;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SelectableText(
                'Error 404, Page Not Found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.home),
                onPressed: () =>
                    GoRouter.of(context).go('/', extra: 'not_found_page'),
                label: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      );
}
