import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Logo extends StatelessWidget {
  final String title;
  const Logo(this.title, {super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(
          child: SvgPicture.asset(
            'images/Logo.svg',
            width: 140,
            height: 140,
            colorFilter: const ColorFilter.mode(Color(0xff1200b3), BlendMode.srcIn),
          ),
        )
      ],
    );
  }
}