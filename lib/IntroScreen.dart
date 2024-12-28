import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(

          image: Expanded(
            flex: 2,
            child: Container(
              width: 500,
              height: 900,
              child: Image.asset(
                'lib/assets/Images/introScreen/create stunning designs.jpg',
                fit: BoxFit.fitWidth, // Make sure the image scales to fill space
              ),
            ),
          ),
          title: 'Create Stunning Templates',
          body: 'With Eventify, design templates tailored to your needs.',
        ),
        PageViewModel(
          title: 'Plan for Every Occasion',
          body: 'From weddings to corporate events, we’ve got you covered!',
          image: Container(
            width: double.infinity, // Full width of screen
            height: 400, // Increased height for better visual
            child: Image.asset(
              'lib/assets/Images/introScreen/plan for every occasion.jpg',
              fit: BoxFit.cover, // Ensures image is stretched properly
            ),
          ),
        ),
        PageViewModel(
          title: 'Welcome to Eventify!',
          body: 'Let’s get started on your event journey.',
          image: Container(
            width: double.infinity, // Full width of screen
            height: 400, // Increased height for better visual
            child: Image.asset(
              'lib/assets/Images/introScreen/welcome to the app.jpg',
              fit: BoxFit.cover, // Ensures image scales to fill space
            ),
          ),
        ),
      ],
      showNextButton: true, // Show the next button
      next: const Icon(Icons.arrow_forward, color: Colors.blue), // Next button appearance
      showDoneButton: true,
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
      onDone: () {
        Navigator.pushNamed(context, 'Login Page'); // Navigate on completion
      },
    );
  }
}
