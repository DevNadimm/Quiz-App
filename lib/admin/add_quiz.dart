import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/utils/toast.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final List<String> _quizCategory = [
    'Mathematics',
    'Sports',
    'Technology',
    'Science',
    'History',
    'Languages',
    'Random',
  ];
  String? _value;

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  // Controllers for quiz fields
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionOneController = TextEditingController();
  final TextEditingController _optionTwoController = TextEditingController();
  final TextEditingController _optionThreeController = TextEditingController();
  final TextEditingController _optionFourController = TextEditingController();
  final TextEditingController _ansController = TextEditingController();

  // Method to pick an image
  Future<void> _getImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> uploadQuiz() async {
    if (_areFieldsFilled()) {
      Map<String, dynamic> addQuiz = _createQuizMap();

      if (_selectedImage != null) {
        await _uploadImage(addQuiz);
      }

      _value ??= _quizCategory.last;

      await DatabaseMethod.addQuizCategory(addQuiz, _value!).then((_) {
        ToastMessage.successToast('Quiz uploaded successfully!');
        _clearFields();
        setState(() {});
      });
    } else {
      ToastMessage.errorToast('Please enter all required fields');
    }
  }

  bool _areFieldsFilled() {
    return _questionController.text.isNotEmpty &&
        _optionOneController.text.isNotEmpty &&
        _optionTwoController.text.isNotEmpty &&
        _optionThreeController.text.isNotEmpty &&
        _optionFourController.text.isNotEmpty &&
        _ansController.text.isNotEmpty;
  }

  Map<String, dynamic> _createQuizMap() {
    return {
      'option1': _optionOneController.text,
      'option2': _optionTwoController.text,
      'option3': _optionThreeController.text,
      'option4': _optionFourController.text,
      'question': _questionController.text,
      'ans': _ansController.text,
    };
  }

  Future<void> _uploadImage(Map<String, dynamic> addQuiz) async {
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/$timestamp');

      final task = await firebaseStorageRef.putFile(_selectedImage!);
      final imgUrl = await task.ref.getDownloadURL();
      addQuiz['image'] = imgUrl;
    } catch (e) {
      ToastMessage.errorToast('Error uploading image: $e');
    }
  }

  void _clearFields() {
    _questionController.clear();
    _optionOneController.clear();
    _optionTwoController.clear();
    _optionThreeController.clear();
    _optionFourController.clear();
    _ansController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionOneController.dispose();
    _optionTwoController.dispose();
    _optionThreeController.dispose();
    _optionFourController.dispose();
    _ansController.dispose();
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
              const SizedBox(
                height: 16,
              ),
              Text(
                'Upload an Image for the Quiz (Optional)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              _selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        _getImage();
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        child: const Icon(
                          CupertinoIcons.photo,
                          size: 30,
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue.withOpacity(0.2),
                        image: DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              _buildTextField(),
              _dropdownContainer(),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    uploadQuiz();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('Save Quiz'),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Column(
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
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: 'e.g., What can Flutter build?',
          ),
        ),
        const SizedBox(
          height: 20,
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
          decoration: const InputDecoration(
            hintText: 'e.g., Mobile Apps',
          ),
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
          decoration: const InputDecoration(
            hintText: 'e.g., Websites',
          ),
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
          decoration: const InputDecoration(
            hintText: 'e.g., Desktop Apps',
          ),
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
          decoration: const InputDecoration(
            hintText: 'e.g., All of the above',
          ),
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
          decoration: const InputDecoration(
            hintText: 'e.g., All of the above',
          ),
        ),
      ],
    );
  }

  Widget _dropdownContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Choose a Category for Your Quiz',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 7,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.withOpacity(0.2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _value,
              items: _quizCategory.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _value = newValue!;
                });
              },
              hint: Text(
                'Pick a Category to Start',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black54,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
