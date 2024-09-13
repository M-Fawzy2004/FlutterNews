import 'package:flutter/material.dart';
import 'package:newsapp/screen/home_screen.dart';
import 'package:newsapp/component/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // logo image welcome news app
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/welcome-news.jpg',
                ),
              ),
            ),

            // welcome text
            Text(
              'News From Around The',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'World For You!',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
              ),
            ),

            // space height
            SizedBox(
              height: size.height * .015,
            ),

            // welcome text
            Text(
              'Best time to read, take your time to reads',
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.primary,
              ),
            ), // welcome text
            Text(
              'a little more of this world',
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            // space height
            SizedBox(
              height: size.height * .04,
            ),

            // icon button => home screen
            CustomButton(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              text: 'Get Started',
            ),
          ],
        ),
      ),
    );
  }
}
