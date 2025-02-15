

import 'package:haven_clean_app/features/home/data/models/banner_model.dart';
import 'package:haven_clean_app/features/home/domain/entities/banner_entity.dart';

class BannerMapper {
  static BannerEntity mapBannerEntity(BannerModel? model) {
    return BannerEntity(
      data: model?.data
          ?.map(
            (e) => mapBannerData(e),
          )
          .toList(),
      pagination: mapPaginationData(model?.paginationModel),
    );
  }

  // banner data
  static BannerData mapBannerData(BannerModelData model) {
    return BannerData(
      category: model.category,
      date: model.date,
      id: model.id,
      image: model.image,
      shortDescription: model.shortDescription,
      title: model.title,
    );
  }

  static Pagination mapPaginationData(PaginationModel? model) {
    return Pagination(
        currentPage: model?.currentPage,
        nextPage: model?.nextPage,
        prevPage: model?.prevPage,
        totalPages: model?.totalPages,
        totalRecords: model?.totalRecords);
  }
}
