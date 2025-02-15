import 'package:dartz/dartz.dart';
import 'package:haven_clean_app/features/home/domain/entities/banner_entity.dart';
import 'package:haven_clean_app/features/home/domain/repositories/home_repo.dart';

class GetBannersUsecase {
  final HomeRepo homeRepo;

  GetBannersUsecase({required this.homeRepo});

  Future<Either<dynamic, BannerEntity>> call() async {
    return await homeRepo.getBanners();
  }
}
