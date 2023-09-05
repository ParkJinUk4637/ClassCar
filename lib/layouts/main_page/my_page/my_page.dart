import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_classcar/layouts/main_page/my_page/list_tile_button.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_detail_pages/reauth_password_reset.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  String? profileUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _profile(),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.black,
              ),
              _part1(),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.black,
              ),
              _part2(),
              // TextButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const SettingPage()),
              //     );
              //   },
              //   child: const Text(
              //     "설정",
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
            ],
          ),
        ));
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pics/${DateTime.now().toIso8601String()}');
      final UploadTask uploadTask = storageRef.putFile(File(pickedFile.path));

      final TaskSnapshot downloadUrl =
          (await uploadTask.whenComplete(() => null));
      final String url = await downloadUrl.ref.getDownloadURL();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userINFO')
          .where('email', isEqualTo: user?.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // 문서 있으면 프사 업데이트
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        FirebaseFirestore.instance
            .collection('users')
            .doc(documentSnapshot.id)
            .update({'profile_pic': url});

        setState(() {
          profileUrl = url;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 32.0),
          child: InkWell(
            onTap: () => pickImage(),
            child: CircleAvatar(
                radius: 50,
                backgroundImage: (profileUrl != null)
                    ? NetworkImage(profileUrl!)
                    : const AssetImage('images/default_profile.png')
                        as ImageProvider // 기본 프로필 이미지
                ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text('${user?.displayName}'),
            Text('${user?.email}'),
            const Text("Credit : (TestCredit)"),
          ],
        ),
        const SizedBox(
          width: 55,
        ),
        Column(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()),
                  );
                },
                icon: const Icon(Icons.settings)),
          ],
        )
      ],
    );
  }

  Widget _part1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listTileButton("이용 내역", const ReauthPasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("쿠폰", const ReauthPasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("이벤트/혜택", const ReauthPasswordReset(), context),
      ],
    );
  }

  Widget _part2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listTileButton("문의 내역", const ReauthPasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton(
            "고객센터 (QnA, FAQ)", const ReauthPasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("공지사항", const ReauthPasswordReset(), context),
      ],
    );
  }
}
