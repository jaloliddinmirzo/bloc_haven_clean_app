import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haven_clean_app/core/common/app/services/injcetion_container.dart';
import 'package:haven_clean_app/core/utils/constants/network_constants.dart';
import 'package:haven_clean_app/features/auth/presentation/widgets/custom_card.dart';
import 'package:haven_clean_app/features/auth/presentation/widgets/custom_search.dart';
import 'package:haven_clean_app/features/home/domain/entities/banner_entity.dart';
import 'package:haven_clean_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:haven_clean_app/features/home/presentation/widgets/banner_widget.dart';
import 'package:shimmer/shimmer.dart'; // Shimmer paketini import qilish

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;
  final homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeGetBannersAndCards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        title: const CustomSearchField(
          hintText: "Search candles",
          leftIcon: Icons.search,
          rightIcon1: Icons.camera_alt,
          rightIcon2: Icons.notifications,
        ),
        elevation: 0,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeGeneralLoading) {
            return _buildShimmerEffect(); // Shimmer effektini ko'rsatish
          }
          if (state is HomeSuccess) {
            return Column(
              children: [
                CarouselSlider(
                  disableGesture: true,
                  items: List.generate(
                    state.bannerEntity.data?.length ?? 0,
                    (index) {
                      final BannerData bannerData =
                          state.bannerEntity.data![index];
                      return buildCarouselItem(bannerData: bannerData);
                    },
                  ),
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
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Special Offers',
                        style: TextStyle(
                          color: Color(0xFF404040),
                          fontSize: 24,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                      Text(
                        'See More',
                        style: TextStyle(
                          color: Color(0xFF156650),
                          fontSize: 14,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.cardEntity.data?.length,
                    itemBuilder: (context, index) {
                      final product = state.cardEntity.data?[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomCardWidget(
                          imagePath: product?.icon != null
                              ? "${NetworkConstants.baseUrl}${product?.icon}"
                              : "https://via.placeholder.com/150",
                          productName: product?.name ?? 'Unknown Product',
                          price:
                              '\$${product?.price?.toStringAsFixed(2) ?? '0.00'}',
                          rating: product?.rating?.toString() ?? '0.0',
                          reviewsCount: product?.discount?.toString() ?? '0',
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }
          return Center(child: Text("No data available")); // Ma'lumot yo'qligida
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xffFFFFFF),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Account',
          ),
        ],
      ),
    );
  }

  // Shimmer effektini yaratish
  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Banner uchun shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Special Offers uchun shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 150,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Product cards uchun shimmer
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3, // 3 ta card uchun shimmer
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}