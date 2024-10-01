import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.category});

  final String category;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          widget.category,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: CircleAvatar(
              child: Icon(CupertinoIcons.back),
            ),
          ),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              'Which writing system does this character belong to?',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                  'https://www.santenjapan.com/wp-content/uploads/2022/11/kanji-for-strength-1.jpg'),
            ),
            const SizedBox(height: 20),
            Text(
              'Choose the answer',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            _buildOptionContainer(context, 'Hangul'),
            _buildOptionContainer(context, 'Devanagari'),
            _buildOptionContainer(context, 'Hiragana'),
            _buildOptionContainer(context, 'Kanji'),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionContainer(BuildContext context, String option) {
    return Container(
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.only(top: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.withOpacity(0.2),
      ),
      child: Text(
        option,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
