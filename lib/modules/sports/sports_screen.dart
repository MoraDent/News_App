import 'package:flutter/cupertino.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'Sports Screen',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          )
      ),
    );
  }
}
