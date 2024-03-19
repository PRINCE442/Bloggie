import 'package:bloggie/Screens/Authentication.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: const EdgeInsets.all(22.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/images/journal3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 120.0,
            left: 50.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stay Informed ',
                  style: TextStyle(
                    color: Color.fromARGB(242, 255, 255, 255),
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'From Day One',
                  style: TextStyle(
                    color: Color.fromARGB(242, 255, 255, 255),
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height:
                        8.0), // Adjust the space between main text and subtext
                const Text(
                  'Discover the latest news with Our',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                const Text(
                  'Seamless Onboarding Experiences',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(350.0, 80.0),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Let's Get Started",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
