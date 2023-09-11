import 'package:bootpay/api/api_provider.dart';
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/config/bootpay_config.dart';
import 'package:bootpay/model/browser_open_type.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/stat_item.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/material.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: OutlinedButton(
          child: Text('결제 route로 이동'),
          onPressed: () {
            // 눌렀을 때 두 번째 route로 이동합니다.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});


  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {

// class _MyAppState extends State<MyApp> {
  Payload payload = Payload();
  String _data = ""; // 서버승인을 위해 사용되기 위한 변수

  String webApplicationId = '59a4d323396fa607cbe75de4';
  String androidApplicationId = '59a4d326396fa607cbe75de5';
  String iosApplicationId = '59a4d328396fa607b9e75de6';

  String get applicationId {
    return Bootpay().applicationId(
        webApplicationId,
        androidApplicationId,
        iosApplicationId
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bootpayAnalyticsUserTrace(); //통계용 함수 호출
    bootpayAnalyticsPageTrace(); //통계용 함수 호출
    bootpayReqeustDataInit(); //결제용 데이터 init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Container(
          child: Center(
              child: TextButton(
                onPressed: () => goBootpayTest(context),
                child: Text('부트페이 결제테스트'),
              )
          ),
        );
      }),
    );
  }


  //통계용 함수
  bootpayAnalyticsUserTrace() async {
    // String? ver;
    // if(kIsWeb) ver = '1.0'; //web 일 경우 버전 지정, 웹이 아닌 android, ios일 경우 package_info 통해 자동으로 생성


    await Bootpay().userTrace(
      id: 'user_1234',
      email: 'user1234@gmail.com',
      gender: -1,
      birth: '19941014',
      area: '서울',
      applicationId: applicationId,
      // ver: ver
    );
  }

  //통계용 함수
  bootpayAnalyticsPageTrace() async {
    // String? ver;
    // if(kIsWeb) ver = '1.0'; //web 일 경우 버전 지정, 웹이 아닌 android, ios일 경우 package_info 통해 자동으로 생성

    StatItem item1 = StatItem();
    item1.itemName = "미키 마우스"; // 주문정보에 담길 상품명
    item1.unique = "ITEM_CODE_MOUSE"; // 해당 상품의 고유 키
    item1.price = 500; // 상품의 가격
    item1.cat1 = '컴퓨터';
    item1.cat2 = '주변기기';

    StatItem item2 = StatItem();
    item2.itemName = "키보드"; // 주문정보에 담길 상품명
    item2.unique = "ITEM_CODE_KEYBOARD"; // 해당 상품의 고유 키
    item2.price = 500; // 상품의 가격
    item2.cat1 = '컴퓨터';
    item2.cat2 = '주변기기';

    List<StatItem> items = [item1, item2];

    await Bootpay().pageTrace(
      url: 'main_1234',
      pageType: 'sub_page_1234',
      applicationId: applicationId,
      userId: 'user_1234',
      items: items,
      // ver: ver
    );
  }

  //결제용 데이터 init
  bootpayReqeustDataInit() {
    Item item1 = Item();
    item1.name = "미키 '마우스"; // 주문정보에 담길 상품명
    item1.qty = 1; // 해당 상품의 주문 수량
    item1.id = "ITEM_CODE_MOUSE"; // 해당 상품의 고유 키
    item1.price = 500; // 상품의 가격

    Item item2 = Item();
    item2.name = "키보드"; // 주문정보에 담길 상품명
    item2.qty = 1; // 해당 상품의 주문 수량
    item2.id = "ITEM_CODE_KEYBOARD"; // 해당 상품의 고유 키
    item2.price = 500.50; // 상품의 가격
    List<Item> itemList = [item1, item2];

    payload.webApplicationId = webApplicationId; // web application id
    payload.androidApplicationId = androidApplicationId; // android application id
    payload.iosApplicationId = iosApplicationId; // ios application id


    // payload.pg = '다날';
    // payload.method = '카드';
    // payload.method = '네이버페이';
    // payload.methods = ['카드', '휴대폰', '가상계좌', '계좌이체', '카카오페이'];
    payload.orderName = "테스트 상품"; //결제할 상품명
    payload.price = 1000.50; //정기결제시 0 혹은 주석


    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString(); //주문번호, 개발사에서 고유값으로 지정해야함


    payload.metadata = {
      "callbackParam1" : "value12",
      "callbackParam2" : "value34",
      "callbackParam3" : "value56",
      "callbackParam4" : "value78",
    }; // 전달할 파라미터, 결제 후 되돌려 주는 값
    payload.items = itemList; // 상품정보 배열


    User user = User(); // 구매자 정보
    user.id = "12341234";
    user.username = "사용자 이름";
    user.email = "user1234@gmail.com";
    user.area = "서울";
    user.phone = "010-0000-0000";
    user.addr = 'null';

    Extra extra = Extra(); // 결제 옵션
    extra.appScheme = 'bootpayFlutter';


    if(BootpayConfig.ENV == -1) {
      payload.extra?.redirectUrl = 'https://dev-api.bootpay.co.kr/v2';
    } else if(BootpayConfig.ENV == -2) {
      payload.extra?.redirectUrl = 'https://stage-api.bootpay.co.kr/v2';
    }  else {
      payload.extra?.redirectUrl = 'https://api.bootpay.co.kr/v2';
    }

    // extra.cardQuota = '3';
    // extra.openType = 'popup';

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

    payload.user = user;
    payload.items = itemList;
    payload.extra = extra;
    // payload.extra?.openType = "iframe";
  }

  //버튼클릭시 부트페이 결제요청 실행
  void goBootpayTest(BuildContext context) {
    // if(kIsWeb) {
    //   //flutter web은 cors 이슈를 설정으로 먼저 해결해주어야 한다.
    //   payload.extra?.openType = 'iframe';
    // }
    payload.extra?.browserOpenType = [
      BrowserOpenType.fromJson({"browser": "mobile_chrome", "open_type": 'popup'}),
    ];

    // print('popup');
    // payload.extra?.openType = 'popup';

    payload.pg = 'danal';
    payload.method = "card";

    payload.extra?.displayCashReceipt = false;
    // payload.extra?.escrow = true;
    // payload.extra?.locale = 'en'; //app locale
    // Bootpay().setLocale('en'); //web locale

    // payload.extra?.depositExpiration = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().add(const Duration(days: 7)));

    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel 1 : $data');
      },
      onError: (String data) {
        print('------- onError: $data');
      },
      onClose: () {
        print('------- onClose');
        Future.delayed(Duration(seconds: 0)).then((value) {

          if (mounted) {
            print('Bootpay().dismiss');
            Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
          }
        });

        // Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        //TODO - 원하시는 라우터로 페이지 이동
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data)  {

        // checkQtyFromServer(data, context).then((value) => print(1243));
        // await check

        print('------- onConfirm: $data');

        Bootpay().dismiss(context);
        // checkQtyFromServer(data);
        return false;
      },
      // onConfirmAsync: (String data) async {
      //   print('------- onConfirmAsync11: $data');
      //   /**
      //       1. 바로 승인하고자 할 때
      //       return true;
      //    **/
      //   /***
      //       2. 비동기 승인 하고자 할 때
      //       checkQtyFromServer(data);
      //       return false;
      //    ***/
      //   /***
      //       3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
      //       return false; 후에 서버에서 결제승인 수행
      //    */
      //
      //   await checkQtyFromServer(data);
      //   print('------- onConfirmAsync22: $data');
      //   // return true;
      //   // return true;
      //   return true;
      // },
      onDone: (String data) {
        print('------- onDone: $data');
      },
    );
  }

  Future<void> checkQtyFromServer(String data) async {
    //TODO 서버로부터 재고파악을 한다
    print('checkQtyFromServer start: $data');
    return Future.delayed(Duration(seconds: 1), () {
      print('checkQtyFromServer end: $data');

      Bootpay().transactionConfirm();
      return true;
    });
  }
}