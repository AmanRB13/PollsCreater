import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:decision_helper/providers/providers.dart';

class PollsContainer extends StatefulWidget {
  const PollsContainer({super.key});

  @override
  State<PollsContainer> createState() => _PollsContainerState();
}

class _PollsContainerState extends State<PollsContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PollsProvider>(
      builder:
          (context, model, child) => SingleChildScrollView(
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter the title',
                              hintStyle: TextStyle(fontSize: 14),
                            ),
                            maxLength: 50,
                            maxLines: 2,
                            cursorColor: Colors.green,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter the title';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              model.addtitle(value!);
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < model.pollsOptions.length; i++)
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    model.removeoptions();
                                  },
                                  icon: const Icon(Icons.cancel),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: 'Enter the option',
                                      fillColor: Colors.black,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter the options';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      model.pollsOptions[i] = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        model.add_poll_options();
                      },
                      child: Text('Add options'),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
