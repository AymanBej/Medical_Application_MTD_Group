// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';


// import '../../../size_config.dart';


// class HomeHeader extends StatelessWidget {
//   const HomeHeader({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CarouselSlider(
//             items: [
//               // Ajoutez ici les widgets d'images que vous souhaitez afficher dans le slider
//               Image.asset('assets/images/banner.png'),
//               Image.asset('assets/images/Image Banner 2.jpg'),
//               Image.asset('assets/images/Image Banner 2.jpg'),
//               Image.asset('assets/images/Image Banner 3.jpg'),
//             ],
//             options: CarouselOptions(
//               // Personnalisez ici les options du slider si nécessaire
//               height: 200,
//               autoPlay: true,
//               enlargeCenterPage: true,
//               aspectRatio: 16 / 9,
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enableInfiniteScroll: true,
//               autoPlayAnimationDuration: Duration(milliseconds: 800),
//               viewportFraction: 0.8,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
