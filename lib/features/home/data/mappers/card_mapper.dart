import 'package:haven_clean_app/features/home/data/models/card_model.dart';
import 'package:haven_clean_app/features/home/domain/entities/cards_entity.dart';

// Entity faylining yo'li

class CardMapper {
  // CardModel ni CardEntity ga o'giramiz
  static CardEntity mapCardEntity(CardModel model) {
    return CardEntity(
      data: model.data != null ? mapCardDataList(model.data!) : null,
      pagination: model.pagination != null ? mapCardPagination(model.pagination!) : null,
    );
  }

  // List<CardDataModel> ni List<CardData> ga o'giramiz
  static List<CardData> mapCardDataList(List<CardDataModel> dataList) {
    return dataList.map((data) => mapCardData(data)).toList();
  }

  // CardDataModel ni CardData ga o'giramiz
  static CardData mapCardData(CardDataModel data) {
    return CardData(
      id: data.id,
      name: data.name,
      description: data.description,
      shortDescription: data.shortDescription,
      icon: data.icon,
      image: data.image,
      quintity: data.quintity,
      price: data.price,
      discount: data.discount,
      rating: data.rating,
      ratingCount: data.ratingCount,
      colors: data.colors != null ? mapColors(data.colors!) : null,
      size: data.size != null ? mapSize(data.size!) : null,
      category: data.category,
    );
  }

  // ColorsModel ni Colors ga o'giramiz
  static Colors mapColors(ColorsModel colors) {
    return Colors(
      name: colors.name,
      colorHexFlutter: colors.colorHexFlutter,
    );
  }

  // SizeModel ni Size ga o'giramiz
  static Size mapSize(SizeModel size) {
    return Size(
      width: size.width,
      depth: size.depth,
      heigth: size.heigth,
      seatWidth: size.seatWidth,
      seatDepth: size.seatDepth,
      seatHeigth: size.seatHeigth,
    );
  }

  // CardPaginationModel ni CardPagination ga o'giramiz
  static CardPagination mapCardPagination(CardPaginationModel pagination) {
    return CardPagination(
      totalRecords: pagination.totalRecords,
      currentPage: pagination.currentPage,
      totalPages: pagination.totalPages,
      nextPage: pagination.nextPage,
      prevPage: pagination.prevPage,
    );
  }
}