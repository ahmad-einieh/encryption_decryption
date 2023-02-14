import 'package:flutter/material.dart';

import '../helper/style.dart';
import 'widgets/homepage_widgets/home_page_content.dart';
import 'widgets/homepage_widgets/upper_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: mainDecoration,
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
            ),
            const HomePageContent(),
          ],
        ),
      ),
    );
  }
}
