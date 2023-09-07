import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/car_info_model.dart';
import '../../../../models/rent.dart';

Future<QuerySnapshot<CarInfoModel>> loadCar(String? carUuid) async {
  QuerySnapshot<CarInfoModel> querySnapshot = await FirebaseFirestore.instance
      .collection("Car")
      .where("uuid",isEqualTo: carUuid)
      .withConverter(
      fromFirestore: CarInfoModel.fromFirestore,
      toFirestore: (CarInfoModel car, _) => car.toFirestore())
      .get();
  return querySnapshot;
}

Future<QuerySnapshot<Map<String, dynamic>>> loadRent(String? userEmail, DocumentSnapshot? lastDocument) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
  .collection("Rent")
      // .orderBy("createdAt")
      .startAfterDocument(lastDocument!)
      .limit(10)
      .where("ownerMail", isEqualTo: "$userEmail")
      .get();
  return querySnapshot;
}

