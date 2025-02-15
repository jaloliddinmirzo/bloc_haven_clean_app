import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haven_clean_app/core/common/app/services/injcetion_container.dart';
import 'package:haven_clean_app/features/home/domain/entities/banner_entity.dart';
import 'package:haven_clean_app/features/home/domain/entities/cards_entity.dart';
import 'package:haven_clean_app/features/home/domain/usecases/get_banners_usecase.dart';
import 'package:haven_clean_app/features/home/domain/usecases/get_cards_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final getBannersUseCase = getIt<GetBannersUsecase>();
  final getCardsUseCase = getIt<GetCardsUsecases>();

  HomeBloc() : super(HomeInitial()) {
    on<HomeGetBannersAndCards>(_onGetBannersAndCards);
  }

  Future<void> _onGetBannersAndCards(
      HomeGetBannersAndCards event, Emitter<HomeState> emit) async {
    emit(HomeGeneralLoading());

    final bannersResult = await getBannersUseCase.call();
    final cardsResult = await getCardsUseCase.call();

    BannerEntity bannerEntity = BannerEntity();
    bannersResult.fold(
      (l) {
        emit(HomeError(errorMessage: l));
      },
      (r) => bannerEntity = r,
    );

    CardEntity cardEntity = CardEntity();
    cardsResult.fold(
      (l) => emit(HomeError(errorMessage: l)),
      (r) => cardEntity = r,
    );

    emit(HomeSuccess(bannerEntity: bannerEntity, cardEntity: cardEntity));
  }
}
