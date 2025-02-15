import 'package:dartz/dartz.dart';
import 'package:haven_clean_app/core/common/exeptions/custom_exception.dart';
import 'package:haven_clean_app/features/home/data/data_source/home_remote_data_source.dart';
import 'package:haven_clean_app/features/home/data/mappers/banner_mapper.dart';
import 'package:haven_clean_app/features/home/data/mappers/card_mapper.dart';
import 'package:haven_clean_app/features/home/domain/entities/banner_entity.dart';
import 'package:haven_clean_app/features/home/domain/entities/cards_entity.dart';
import 'package:haven_clean_app/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<dynamic, BannerEntity>> getBanners() async {
    try {
      final result = await homeRemoteDataSource.getBanners();
      return Right(BannerMapper.mapBannerEntity(result));
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    }
  }

  @override
  Future<Either<dynamic, CardEntity>> getCards() async {
    try {
      final result = await homeRemoteDataSource.getCards();
      return Right(CardMapper.mapCardEntity(result!));
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    }
  }
}
