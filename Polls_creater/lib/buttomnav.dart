import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'addPoll.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int selectedindex = 0;
  PageController pageController = PageController();

  void ontappeditem(int index) {
    setState(() {
      selectedindex = index;
    });
    pageController.jumpToPage(selectedindex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Decision making app'),
        actions: [
          TextButton(onPressed: () {}, child: Icon(Icons.home, size: 20)),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [Dashboard(), Decision()],
      ),

      bottomNavigationBar: SingleChildScrollView(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          ],
          currentIndex: selectedindex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.red,
          onTap: ontappeditem,
        ),
      ),
    );
  }
}
