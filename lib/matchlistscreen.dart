import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_p/matchdetailscreen.dart';

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match List',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('footballMatchList').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var footballMatchList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: footballMatchList.length,
            itemBuilder: (context, index) {
              var match = footballMatchList[index];
              return ListTile(
                title: Text(match['matchName'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchDetailScreen(match),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
