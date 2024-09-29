import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionOneController = TextEditingController();
  final TextEditingController _optionTwoController = TextEditingController();
  final TextEditingController _optionThreeController = TextEditingController();
  final TextEditingController _optionFourController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void dispose() {
    _optionOneController.dispose();
    _optionTwoController.dispose();
    _optionThreeController.dispose();
    _optionFourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Quiz',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload an Image for the Quiz (Optional)',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.withOpacity(0.2),
                ),
                child: const Icon(
                  CupertinoIcons.photo,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _buildTextField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _questionController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Question'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Option 1',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _optionOneController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Option 1'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Option 2',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _optionTwoController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Option 2'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Option 3',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _optionThreeController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Option 3'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Option 4',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _optionFourController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Option 4'),
          ),
        ],
      ),
    );
  }
}
