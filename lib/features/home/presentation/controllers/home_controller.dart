// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:haven_clean_app/core/common/app/services/injcetion_container.dart';
// import 'package:haven_clean_app/features/home/domain/entities/banner_entity.dart';
// import 'package:haven_clean_app/features/home/domain/entities/cards_entity.dart';
// import 'package:haven_clean_app/features/home/domain/usecases/get_banners_usecase.dart';
// import 'package:haven_clean_app/features/home/domain/usecases/get_cards_usecases.dart';

// class HomeProvider extends ChangeNotifier {
//   final bannerUseCase = getIt<GetBannersUsecase>();
//   final getCardsUsecases = getIt<GetCardsUsecases>();

//   bool isLoading = false;
//   BannerEntity? banners = BannerEntity();
//   CardEntity? cards = CardEntity();
//   String? message;

//   Future<void> getBanners() async {
//     log("Get banners called in provider");
//     isLoading = true;
//     notifyListeners();
//     final result = await bannerUseCase.call();
//     result.fold(
//       (l) => message = l,
//       (r) => banners = r,
//     );
//     log(banners!.data.toString());
//     isLoading = false;
//     notifyListeners();
//   }

//   Future<void> getCards() async {
//     log("Get cards called in provider");
//     isLoading = false;
//     notifyListeners();
//     final result = await getCardsUsecases.call();
//     result.fold(
//       (l) => message = l,
//       (r) => cards = r,
//     );
//   }
// }
