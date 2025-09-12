import 'dart:convert';

FeedsModel marketplaceResponseFromJson(String str) =>
    FeedsModel.fromJson(json.decode(str));

String marketplaceResponseToJson(FeedsModel data) => json.encode(data.toJson());

class FeedsModel {
  final bool ok;
  final List<MarketplaceRequest> marketplaceRequests;
  final Pagination pagination;

  FeedsModel({
    required this.ok,
    required this.marketplaceRequests,
    required this.pagination,
  });

  factory FeedsModel.fromJson(Map<String, dynamic> json) {
    return FeedsModel(
      ok: json["ok"] ?? false,
      marketplaceRequests: json["marketplace_requests"] == null
          ? []
          : List<MarketplaceRequest>.from(
              json["marketplace_requests"].map(
                (x) => MarketplaceRequest.fromJson(x),
              ),
            ),
      pagination: Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "marketplace_requests": List<dynamic>.from(
      marketplaceRequests.map((x) => x.toJson()),
    ),
    "pagination": pagination.toJson(),
  };
}

class MarketplaceRequest {
  final String idHash;
  final UserDetails userDetails;
  final bool isHighValue;
  final String createdAt;
  final String createdAtDate;
  final String description;
  final RequestDetails? requestDetails;
  final String status;
  final String serviceType;
  final String targetAudience;
  final bool isOpen;
  final bool isPanIndia;
  final bool anyLanguage;
  final bool isDealClosed;
  final String slug;

  MarketplaceRequest({
    required this.idHash,
    required this.userDetails,
    required this.isHighValue,
    required this.createdAt,
    required this.createdAtDate,
    required this.description,
    required this.requestDetails,
    required this.status,
    required this.serviceType,
    required this.targetAudience,
    required this.isOpen,
    required this.isPanIndia,
    required this.anyLanguage,
    required this.isDealClosed,
    required this.slug,
  });

  factory MarketplaceRequest.fromJson(Map<String, dynamic> json) {
    return MarketplaceRequest(
      idHash: json["id_hash"] ?? "",
      userDetails: UserDetails.fromJson(json["user_details"]),
      isHighValue: json["is_high_value"] ?? false,
      createdAt: json["created_at"] ?? "",
      createdAtDate: json["created_at_date"] ?? "",
      description: json["description"] ?? "",
      requestDetails: json["request_details"] != null
          ? RequestDetails.fromJson(json["request_details"])
          : null,
      status: json["status"] ?? "",
      serviceType: json["service_type"] ?? "",
      targetAudience: json["target_audience"] ?? "",
      isOpen: json["is_open"] ?? false,
      isPanIndia: json["is_pan_india"] ?? false,
      anyLanguage: json["any_language"] ?? false,
      isDealClosed: json["is_deal_closed"] ?? false,
      slug: json["slug"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id_hash": idHash,
    "user_details": userDetails.toJson(),
    "is_high_value": isHighValue,
    "created_at": createdAt,
    "created_at_date": createdAtDate,
    "description": description,
    "request_details": requestDetails?.toJson(),
    "status": status,
    "service_type": serviceType,
    "target_audience": targetAudience,
    "is_open": isOpen,
    "is_pan_india": isPanIndia,
    "any_language": anyLanguage,
    "is_deal_closed": isDealClosed,
    "slug": slug,
  };
}

class UserDetails {
  final String name;
  final String profileImage;
  final String? company;
  final String? designation;

  UserDetails({
    required this.name,
    required this.profileImage,
    this.company,
    this.designation,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json["name"] ?? "",
      profileImage: json["profile_image"] ?? "",
      company: json["company"],
      designation: json["designation"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "profile_image": profileImage,
    "company": company,
    "designation": designation,
  };
}

class RequestDetails {
  final FollowersRange? followersRange;
  final List<String>? categories;
  final int? creatorCountMin;
  final int? creatorCountMax;
  final String? budget;
  final String? brand;
  final List<String>? languages;
  final List<String>? platform;
  final List<String>? cities;

  RequestDetails({
    this.followersRange,
    this.categories,
    this.creatorCountMin,
    this.creatorCountMax,
    this.budget,
    this.brand,
    this.languages,
    this.platform,
    this.cities,
  });

  factory RequestDetails.fromJson(Map<String, dynamic> json) {
    return RequestDetails(
      followersRange: json["followers_range"] != null
          ? FollowersRange.fromJson(json["followers_range"])
          : null,
      categories: json["categories"] != null
          ? List<String>.from(json["categories"])
          : null,
      creatorCountMin: json["creator_count_min"],
      creatorCountMax: json["creator_count_max"],
      budget: json["budget"],
      brand: json["brand"],
      languages: json["languages"] != null
          ? List<String>.from(json["languages"])
          : null,
      platform: json["platform"] != null
          ? List<String>.from(json["platform"])
          : null,
      cities: json["cities"] != null ? List<String>.from(json["cities"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "followers_range": followersRange?.toJson(),
    "categories": categories,
    "creator_count_min": creatorCountMin,
    "creator_count_max": creatorCountMax,
    "budget": budget,
    "brand": brand,
    "languages": languages,
    "platform": platform,
    "cities": cities,
  };
}

class FollowersRange {
  final String? igFollowersMin;
  final String? igFollowersMax;
  final String? ytSubscribersMin;
  final String? ytSubscribersMax;

  FollowersRange({
    this.igFollowersMin,
    this.igFollowersMax,
    this.ytSubscribersMin,
    this.ytSubscribersMax,
  });

  factory FollowersRange.fromJson(Map<String, dynamic> json) {
    return FollowersRange(
      igFollowersMin: json["ig_followers_min"],
      igFollowersMax: json["ig_followers_max"],
      ytSubscribersMin: json["yt_subscribers_min"],
      ytSubscribersMax: json["yt_subscribers_max"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ig_followers_min": igFollowersMin,
    "ig_followers_max": igFollowersMax,
    "yt_subscribers_min": ytSubscribersMin,
    "yt_subscribers_max": ytSubscribersMax,
  };
}

class Pagination {
  final bool hasMore;
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;
  final String? nextPageUrl;
  final String? previousPageUrl;
  final String url;

  Pagination({
    required this.hasMore,
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    this.nextPageUrl,
    this.previousPageUrl,
    required this.url,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      hasMore: json["has_more"] ?? false,
      total: json["total"] ?? 0,
      count: json["count"] ?? 0,
      perPage: json["per_page"] ?? 0,
      currentPage: json["current_page"] ?? 1,
      totalPages: json["total_pages"] ?? 1,
      nextPageUrl: json["next_page_url"],
      previousPageUrl: json["previous_page_url"],
      url: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "has_more": hasMore,
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
    "next_page_url": nextPageUrl,
    "previous_page_url": previousPageUrl,
    "url": url,
  };
}
