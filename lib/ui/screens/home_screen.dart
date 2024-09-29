import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _headerSection(context),
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Nadim Chowdhury',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Spacer(),
            const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 25,
            )
          ],
        ),
      ),
    );
  }
}
