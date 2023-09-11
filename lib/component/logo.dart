import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Logo extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  const Logo(this.title, this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(
          child: SvgPicture.asset(
            'images/Logo.svg',
            width: width,
            height: height,
            colorFilter: ColorFilter.mode(Theme.of(context).focusColor, BlendMode.srcIn),
          ),
        )
      ],
    );
  }
}