import 'package:dio/dio.dart';
import 'package:haven_clean_app/core/common/app/services/injcetion_container.dart';
import 'package:haven_clean_app/core/common/exeptions/custom_exception.dart';
import 'package:haven_clean_app/core/utils/constants/network_constants.dart';
import 'package:haven_clean_app/core/utils/constants/prefs_keys.dart';
import 'package:haven_clean_app/features/home/data/data_source/custom_dio_client.dart';
import 'package:haven_clean_app/features/home/data/models/banner_model.dart';
import 'package:haven_clean_app/features/home/data/models/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRemoteDataSource {
  Future<BannerModel?> getBanners();
  Future<CardModel?> getCards();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final dioClient = getIt<DioClient>();

  @override
  Future<BannerModel?> getBanners() async {
    final String? token =
        getIt<SharedPreferences>().getString(PrefsKeys.tokenKey);

    try {
      final response = await dioClient.dio.get(NetworkConstants.bannerUrl,
          options: Options(extra: {"requiresToken": true}));
      if (response.statusCode == 200) {
        final payload = response.data;
        return BannerModel.fromJson(payload);
      }
    } catch (e) {
      throw ServerException(
        errorMessage: "Error happened while fetching banners",
        statusCode: 500,
      );
    }
    return null;
  }

  @override
  Future<CardModel?> getCards() async {
    final String? token =
        getIt<SharedPreferences>().getString(PrefsKeys.tokenKey);
    try {
      final response = await dioClient.dio.get(NetworkConstants.cardUrl,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        final payload = response.data;
        return CardModel.fromJson(payload);
      }
    } catch (e) {
      throw ServerException(
        errorMessage: "Error happened while fetching cards",
        statusCode: 500,
      );
    }
    return null;
  }
}
