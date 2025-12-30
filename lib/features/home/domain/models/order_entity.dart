class OrderEntity {
  final int jobId;
  final String jobNumber;
  final String jobOwner;
  final String? poNumber;
  final String status;
  final DateTime? requestedShipDate;
  final DateTime? createdAt;
  final num totalAmount;
  final int itemsCount;
  final int transfersCount;

  const OrderEntity({
    required this.jobId,
    required this.jobNumber,
    required this.jobOwner,
    required this.poNumber,
    required this.status,
    required this.requestedShipDate,
    required this.createdAt,
    required this.totalAmount,
    required this.itemsCount,
    required this.transfersCount,
  });
}
