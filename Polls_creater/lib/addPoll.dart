import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'widgets/widgets.dart';

class Decision extends StatefulWidget {
  const Decision({super.key});

  @override
  State<Decision> createState() => _DecisionState();
}

class _DecisionState extends State<Decision> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PollsProvider>(
        builder:
            (context, model, child) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      PollsContainer(),
                      SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();

                            model.savePoll();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Poll Saved')),
                            );
                          }
                        },
                        child: const Text('Upload Decisions'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
