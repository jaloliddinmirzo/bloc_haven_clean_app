import 'package:dartz/dartz.dart';
import 'package:haven_clean_app/features/home/domain/entities/banner_entity.dart';
import 'package:haven_clean_app/features/home/domain/entities/cards_entity.dart';

abstract class HomeRepo {
  Future<Either<dynamic, BannerEntity>> getBanners();
  Future<Either<dynamic, CardEntity>> getCards();
}
