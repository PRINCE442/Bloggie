// import 'package:bloggie/Navigations/BottomTabBar.dart';
// import 'package:flutter/material.dart';

// class RecomForYouPage extends StatelessWidget {
//   const RecomForYouPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(17, 55, 0, 0),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Container(
//             height: 50.0,
//             width: 50.0,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300, width: 5.0),
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               iconSize: 20.0,
//               icon: const Icon(Icons.arrow_back_ios_new_sharp),
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) => const BottomTabBar(),
//                 ));
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           const Text(
//             'Recommended for You',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(CategoryButtonTest());
}

class CategoryButtonTest extends StatefulWidget {
  @override
  _CategoryButtonTestState createState() => _CategoryButtonTestState();
}

class _CategoryButtonTestState extends State<CategoryButtonTest> {
  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Category Button Test'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return TextButton(
              onPressed: () {
                print('Button pressed for category: $category');
              },
              child: Text(category),
            );
          },
        ),
      ),
    );
  }
}
