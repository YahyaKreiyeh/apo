class MasterDetailEntity {
  final int id;
  final String detailName;
  final String detailCode;
  final int displayOrder;
  final bool isActive;

  const MasterDetailEntity({
    required this.id,
    required this.detailName,
    required this.detailCode,
    required this.displayOrder,
    required this.isActive,
  });
}
