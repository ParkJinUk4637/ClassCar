// import 'package:flutter/material.dart';
//
// import '../../../../models/car_info_model.dart';
// import '../../../../models/rent.dart';
//
// Widget rentalListTile(Rent rent) {
//   final start = rent.startedAt?.toDate();
//   final end = rent.startedAt?.toDate();
//   return Container(
//     height: 500,
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(0, 2))
//           ]),
//       child: FutureBuilder(
//         future: loadCar(carUuid),
//         builder: (context, snapshot) {
//           final data = snapshot.data?.docs.first.data();
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError || snapshot.data == null) {
//             return const SizedBox(height: 100,
//             );
//           } else {
//             return Row(
//               children: [
//                 // 첫 번째 Column
//                 Expanded(
//                     flex: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("${rent.requestStatus}"),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Image.network(
//                           "${data?.carImgURL?[0]}",
//                           width: 80,
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(data!.carNumber),
//                       ],
//                     )),
//                 // 두 번째 Column
//                 Expanded(
//                     flex: 7,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('이동 거리'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(data.carModel ?? 'Car Model'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text('대여 기간 ${start?.year ?? '0000'}년 '
//                             '${start?.month ?? '00'}월 '
//                             '${start?.day ?? '00'}일 '
//                             '${start?.hour ?? '00'}시 '
//                             '${start?.minute ?? '00'}분 '
//                             '~ ${end?.year ?? '0000'}년 '
//                             '${end?.month ?? '00'}월 '
//                             '${end?.day ?? '00'}일 '
//                             '${end?.hour ?? '00'}시 '
//                             '${end?.minute ?? '00'}분 '),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text('${rent.location}')
//                       ],
//                     ))
//               ],
//             );
//           }
//         },
//       ));
// }
