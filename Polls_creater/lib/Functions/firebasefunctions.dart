import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveDecision(Map pollsWeights, String title) async {
  final User? currUser = FirebaseAuth.instance.currentUser;

  if (currUser == null) {
    print('Error: No user is currently signed in!');
    return;
  }

  await FirebaseFirestore.instance.collection('decisions').add({
    'pollWeights': pollsWeights,
    'uid': currUser.uid,
    'usersWhoVoted': {},
    'title': title,
  });
}
