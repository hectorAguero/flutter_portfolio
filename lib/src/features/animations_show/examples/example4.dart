import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'John', age: 30, emoji: '🙋🏻‍♂️'),
  Person(name: 'Jane', age: 25, emoji: '👸🏻'),
  Person(name: 'Jack', age: 15, emoji: '🧔🏿'),
];

class ExampleFour extends StatelessWidget {
  const ExampleFour({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        prototypeItem: const ListTile(
          leading: Text('👨🏻‍🦳', style: TextStyle(fontSize: 40)),
          title: Text('John'),
          subtitle: Text('30 years old'),
        ),
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            leading: Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(person: person),
                ),
              );
            },
            trailing: const Icon(Icons.arrow_forward_ios),
            title: Text(person.name),
            subtitle: Text('${person.age} years old'),
          );
        },
        itemCount: people.length,
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.person, Key? key}) : super(key: key);

  final Person person;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(begin: 0.1, end: 1.0).chain(
                        CurveTween(curve: Curves.fastLinearToSlowEaseIn),
                      ),
                    ),
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(begin: 1.0, end: 0.1).chain(
                        CurveTween(curve: Curves.fastLinearToSlowEaseIn),
                      ),
                    ),
                    child: toHeroContext.widget,
                  ),
                );
            }
          },
          tag: person.name,
          child: Material(
            color: Colors.transparent,
            child: Text(
              person.emoji,
              style: const TextStyle(fontSize: 80),
            ),
          ),
        ),
        toolbarHeight: 100,
        elevation: 4,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              person.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              '${person.age} years old',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
