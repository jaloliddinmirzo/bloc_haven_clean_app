import 'package:dartz/dartz.dart';
import 'package:haven_clean_app/features/home/domain/entities/cards_entity.dart';
import 'package:haven_clean_app/features/home/domain/repositories/home_repo.dart';

class GetCardsUsecases {
  final HomeRepo homeRepo;

  GetCardsUsecases({required this.homeRepo});

  Future<Either<dynamic, CardEntity>> call() async {
    return await homeRepo.getCards();
  }
}
