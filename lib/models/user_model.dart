import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String address;
  String backNum;
  String birthday;
  String detailAddress;
  String email;
  bool isCheckedAgreement;
  bool isCheckedAgreement2;
  bool isCheckedAgreementAD;
  String name;
  String password;
  String phoneNumber;
  String telecom;
  String userID;
  String profilePicLink;
  int credit;

  UserModel({
    required this.address,
    required this.backNum,
    required this.birthday,
    required this.detailAddress,
    required this.email,
    required this.isCheckedAgreement,
    required this.isCheckedAgreement2,
    required this.isCheckedAgreementAD,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.telecom,
    required this.userID,
    required this.profilePicLink,
    required this.credit,
  });

  // Firebase 문서로부터 모델 객체를 생성
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      address: data['address'],
      backNum: data['backNum'],
      birthday: data['birthday'],
      detailAddress: data['detailAddress'],
      email: data['email'],
      isCheckedAgreement: data['isCheckedAgreement'],
      isCheckedAgreement2: data['isCheckedAgreement2'],
      isCheckedAgreementAD: data['isCheckedAgreementAD'],
      name: data['name'],
      password: data['passWord'],
      phoneNumber: data['phoneNumber'],
      telecom: data['telecom'],
      userID: data['userID'],
      profilePicLink: data['profilePicLink'],
      credit: data['credit'],
    );
  }

  // 모델 객체를 Firebase 문서로 변환
  Map<String, dynamic> toFirestore() {
    return {
      'address': address,
      'backNum': backNum,
      'birthday': birthday,
      'detailAddress': detailAddress,
      'email': email,
      'isCheckedAgreement': isCheckedAgreement,
      'isCheckedAgreement2': isCheckedAgreement2,
      'isCheckedAgreementAD': isCheckedAgreementAD,
      'name': name,
      'passWord': password,
      'phoneNumber': phoneNumber,
      'telecom': telecom,
      'userID': userID,
      'profilePicLink': profilePicLink,
      'credit': credit,
    };
  }
}