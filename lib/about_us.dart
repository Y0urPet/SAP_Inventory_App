import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Author'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/author.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Timothy Andrian\nandriantimothy300@gmail.com',
              textAlign: TextAlign.center,
            )
          ],
        )
      ),
    );
  }
}