// 메인 페이지 위젯 작업 예정

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/*TextButton(
              onPressed: () {
                db.collection("Car").limit(indexCount).get().then(
                    (querySnapshot) {
                      print("Successfully completed");
                      for (var docSnapshot in querySnapshot.docs) {
                        print('${docSnapshot.id} => ${docSnapshot.data()}');
                      }
                      (e) => print("Error completing: $e");
                    }
                );
              },
              child: const Text("테스트 호출"),
            ),*/

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final int indexCount = 10;
  int startIndex = 1;
  final _suggestions = <String>[];
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildSuggestions(),
      )
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd) return Divider();
        final index = i~/2;
        if(index >= _suggestions.length){
          for(int j=1;j<=10;j++){
            _suggestions.add(count.toString());
            count++;
          }
          print("@@@build@@@");
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  Widget _buildRow(String number){
    return ListTile(
      title: OutlinedButton(
          onPressed: () {},
          child: Column(
            children: [
              Image.network("https://taegon.kim/wp-content/uploads/2018/05/image-5.png"),
              Text("차량이름 : $number"),
              Text("별점"),
              Text("가격"),
            ],
          )
      ),
    );
  }




}
