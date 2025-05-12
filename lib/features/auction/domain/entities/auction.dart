class Auction {
  final double? id;
  final String? feedback;
  final DateTime? valuatedAt;
  final DateTime? requestedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? make;
  final String? model;
  final String? externalId;
  final String? sellerUser;
  final double? price;
  final bool? positiveCustomerFeedback;
  final String? uuidAuction;
  final DateTime? inspectorRequestedAt;
  final String? origin;
  final String? estimationRequestId;

  Auction({
    this.id,
    this.feedback,
    this.valuatedAt,
    this.requestedAt,
    this.createdAt,
    this.updatedAt,
    this.make,
    this.model,
    this.externalId,
    this.sellerUser,
    this.price,
    this.positiveCustomerFeedback,
    this.uuidAuction,
    this.inspectorRequestedAt,
    this.origin,
    this.estimationRequestId,
  });
}
