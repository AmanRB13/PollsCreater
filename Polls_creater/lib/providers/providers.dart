import 'package:flutter/material.dart';

class Poll {
  String title;
  List<String> options;

  Poll({required this.title, required this.options});
}

class PollsProvider extends ChangeNotifier {
  // current poll
  List<String> pollsOptions = ['', ''];
  String pollsTitle = '';

  // all polls
  List<Poll> allPolls = [];

  // ---------------- FUNCTIONS ----------------

  add_poll_options() {
    pollsOptions.add('');
    notifyListeners();
  }

  removeoptions() {
    pollsOptions.removeLast();
    notifyListeners();
  }

  addtitle(String value) {
    pollsTitle = value;
  }

  saveOption(String value, int index) {
    pollsOptions[index] = value;
  }

  ///  SAVE POLL LOCALLY
  savePoll() {
    allPolls.add(Poll(title: pollsTitle, options: List.from(pollsOptions)));

    // reset
    pollsTitle = '';
    pollsOptions = ['', ''];

    notifyListeners();
  }
}
