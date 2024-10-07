import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/utils/toast.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.category});

  final String category;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Stream? quizStream;
  PageController pageController = PageController();
  bool isAnswerHighlighted = false;
  bool isOptionSelected = false;

  @override
  void initState() {
    super.initState();
    getQuizData();
  }

  void getQuizData() async {
    quizStream = await DatabaseMethod.getQuizByCategory(widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: _buildAppBar(),
      body: _buildQuizBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildQuizBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return PageView.builder(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data.docs[index];
              return _buildQuizPage(context, doc);
            },
          );
        },
      ),
    );
  }

  Widget _buildQuizPage(BuildContext context, dynamic doc) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            doc['question'],
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          _buildImageIfPresent(doc),
          const SizedBox(height: 20),
          Text(
            'Choose the answer',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          _buildOptionsList(context, doc),
          const SizedBox(height: 10),
          _buildNextButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildImageIfPresent(dynamic doc) {
    if (doc.data().containsKey('image') && doc['image'].isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(doc['image']),
      );
    }
    return const SizedBox();
  }

  Widget _buildOptionsList(BuildContext context, dynamic doc) {
    return Column(
      children: [
        _buildOptionContainer(context, doc['option1'], doc['ans']),
        _buildOptionContainer(context, doc['option2'], doc['ans']),
        _buildOptionContainer(context, doc['option3'], doc['ans']),
        _buildOptionContainer(context, doc['option4'], doc['ans']),
      ],
    );
  }

  Widget _buildOptionContainer(
      BuildContext context, String option, String ans) {
    return GestureDetector(
      onTap: isOptionSelected
          ? null
          : () {
              setState(() {
                isAnswerHighlighted = true;
                isOptionSelected = true;
                if (option == ans) {
                  ToastMessage.successToast('Correct!');
                } else {
                  ToastMessage.errorToast('Incorrect!');
                }
              });
            },
      child: Container(
        padding: const EdgeInsets.all(13),
        margin: const EdgeInsets.only(top: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isAnswerHighlighted
              ? option == ans
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1)
              : Colors.blue.withOpacity(0.2),
          border: Border.all(
            width: 2,
            color: isAnswerHighlighted
                ? option == ans
                    ? Colors.green
                    : Colors.red
                : Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Text(
          option,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(
        onPressed: isOptionSelected
            ? () {
                setState(() {
                  isAnswerHighlighted = false;
                  isOptionSelected = false;
                });
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            : null,
        child: const Text('Next'),
      ),
    );
  }
}
