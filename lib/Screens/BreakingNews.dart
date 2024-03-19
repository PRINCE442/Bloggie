import 'package:bloggie/Navigations/BottomTabBar.dart';
import 'package:flutter/material.dart';

class BreakingNewsPage extends StatelessWidget {
  const BreakingNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(17, 55, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 5.0),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 20.0,
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BottomTabBar(),
                ));
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Breaking News',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
          ),
        ]),
      ),
    );
  }
}
