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
  final TextEditingController _ansController = TextEditingController();
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
          'Create New Quiz',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
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
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {

                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('Save Quiz'),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
            ],
          ),
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
            'Quiz Question',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _questionController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Type Your Question Here'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Answer Option 1',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _optionOneController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Answer Option 1'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Answer Option 2',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _optionTwoController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Answer Option 2'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Answer Option 3',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _optionThreeController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Answer Option 3'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Answer Option 4',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _optionFourController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Enter Answer Option 4'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Correct Answer',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: _ansController,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(hintText: 'Specify the Correct Answer'),
          ),
        ],
      ),
    );
  }
}
