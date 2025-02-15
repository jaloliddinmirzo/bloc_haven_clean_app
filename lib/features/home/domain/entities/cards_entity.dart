class CardEntity {
    final List<CardData>? data;
    final CardPagination? pagination;

    CardEntity({
        this.data,
        this.pagination,
    });

}

class CardData {
    final String? id;
    final String? name;
    final String? description;
    final String? shortDescription;
    final String? icon;
    final List<String>? image;
    final int? quintity;
    final double? price;
    final int? discount;
    final double? rating;
    final int? ratingCount;
    final Colors? colors;
    final Size? size;
    final String? category;

    CardData({
        this.id,
        this.name,
        this.description,
        this.shortDescription,
        this.icon,
        this.image,
        this.quintity,
        this.price,
        this.discount,
        this.rating,
        this.ratingCount,
        this.colors,
        this.size,
        this.category,
    });

}

class Colors {
    final String? name;
    final String? colorHexFlutter;

    Colors({
        this.name,
        this.colorHexFlutter,
    });

}

class Size {
    final int? width;
    final int? depth;
    final int? heigth;
    final int? seatWidth;
    final int? seatDepth;
    final int? seatHeigth;

    Size({
        this.width,
        this.depth,
        this.heigth,
        this.seatWidth,
        this.seatDepth,
        this.seatHeigth,
    });

}

class CardPagination {
    final int? totalRecords;
    final int? currentPage;
    final int? totalPages;
    final dynamic nextPage;
    final dynamic prevPage;

    CardPagination({
        this.totalRecords,
        this.currentPage,
        this.totalPages,
        this.nextPage,
        this.prevPage,
    });

}
