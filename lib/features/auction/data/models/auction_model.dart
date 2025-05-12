import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/auction.dart';

part 'auction_model.g.dart';

@JsonSerializable()
class AuctionModel extends Auction {
  @override
  @JsonKey(name: '_fk_sellerUser')
  final String? sellerUser;
  @override
  @JsonKey(name: '_fk_uuid_auction')
  final String? uuidAuction;

  AuctionModel({
    super.id,
    super.feedback,
    super.valuatedAt,
    super.requestedAt,
    super.createdAt,
    super.updatedAt,
    super.make,
    super.model,
    super.externalId,
    this.sellerUser,
    super.price,
    super.positiveCustomerFeedback,
    this.uuidAuction,
    super.inspectorRequestedAt,
    super.origin,
    super.estimationRequestId,
  }) : super(sellerUser: sellerUser, uuidAuction: uuidAuction);

  factory AuctionModel.fromJson(Map<String, dynamic> json) => _$AuctionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuctionModelToJson(this);
}
