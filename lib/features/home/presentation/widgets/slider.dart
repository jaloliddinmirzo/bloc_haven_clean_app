import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderCadr extends StatelessWidget {
  const SliderCadr({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      disableGesture: true,
      items: [
        _buildCarouselItem(
          "55 %",
          "Discount",
          "Wireless Noise",
          Colors.greenAccent,
          "assets/images/slider.png", // Rasm 1
        ),
        _buildCarouselItem(
          "30 %",
          "Discount",
          "Bluetooth Headphones",
          Colors.blueAccent,
          "assets/images/slider.png", // Rasm 1
        ),
        _buildCarouselItem(
          "70 %",
          "Special Offer",
          "Smart Earbuds",
          Colors.purpleAccent,
          "assets/images/slider.png", // Rasm 1
        ),
      ],
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 8,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(seconds: 2),
        viewportFraction: 0.8,
      ),
    );
  }

  Widget _buildCarouselItem(String discount, String title, String subtitle,
      Color bgColor, String imagePath) {
    return Container(
      // margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/images/slider.png")),
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment(0.00, 0.00),
            end: Alignment(0.4, 0.1),
            colors: [Color(0xEF156650), Color(0xAA156650), Color(0x00156650)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 178,
                      child: Text(
                        'Celebrate The Season With Us!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: 178,
                      child: Text(
                        'Get discounts up to 75% for furniture &  decoration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Shop Now',
                          style: TextStyle(
                            color: Color(0xFF156650),
                            fontSize: 12,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
