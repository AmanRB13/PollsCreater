import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isSelected = false;
  int? selectedIndex;
  int user = 1;
  bool optionsselected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Consumer<PollsProvider>(
        builder: (context, model, child) {
          if (model.allPolls.isEmpty) {
            return const Center(child: Text('No polls available'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(14),
            itemCount: model.allPolls.length,
            itemBuilder: (context, index) {
              final poll = model.allPolls[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // QUESTION
                      Text(
                        poll.title,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      // OPTIONS
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: poll.options.length,
                        itemBuilder: (context, optionIndex) {
                          return GestureDetector(
                            onTap: () {
                              if (!isSelected) {
                                setState(() {
                                  selectedIndex = optionIndex;
                                  isSelected = true;
                                });
                              }

                              if (isSelected &&
                                  selectedIndex == optionIndex &&
                                  !optionsselected) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Selected by : $user user'),
                                  ),
                                );

                                setState(() {
                                  user++;
                                  optionsselected = true;
                                });
                              }
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? (selectedIndex == optionIndex
                                            ? Colors.green
                                            : Colors.blueGrey)
                                        : Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),

                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  poll.options[optionIndex],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
