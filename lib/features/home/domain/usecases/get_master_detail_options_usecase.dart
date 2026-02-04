import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/networking/api_error_model.dart';
import 'package:apo/features/home/domain/models/master_detail_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_type.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

class GetMasterDetailOptionsUseCase {
  GetMasterDetailOptionsUseCase(this._repository);

  final CartRepository _repository;

  Future<ApiResponseModel<List<MasterDetailEntity>>> call(
    MasterDetailType type,
  ) {
    switch (type) {
      case MasterDetailType.decorationType:
        return _repository.fetchDecorationTypeOptions();
      case MasterDetailType.embOptions:
        return _repository.fetchEmbOptions();
      case MasterDetailType.embType:
        return _repository.fetchEmbTypes();
      case MasterDetailType.heatTransferType:
        return _repository.fetchHeatTransferTypeOptions();
      case MasterDetailType.screenPrintColor:
        return _repository.fetchScreenPrintColorOptions();
      case MasterDetailType.screenPrintGarment:
        return _repository.fetchScreenPrintGarmentOptions();
      case MasterDetailType.screenPrintLocation:
        return _repository.fetchScreenPrintLocationOptions();
      case MasterDetailType.leatherColor:
        return _repository.fetchLeatherColorOptions();
      case MasterDetailType.patchType:
        return _repository.fetchPatchTypeOptions();
      case MasterDetailType.labelType:
        return _repository.fetchLabelTypeOptions();
      case MasterDetailType.embroideryDecoration:
      case MasterDetailType.heatTransferDecoration:
      case MasterDetailType.screenPrintDecoration:
      case MasterDetailType.leatherDecoration:
      case MasterDetailType.patchesDecoration:
      case MasterDetailType.labelsDecoration:
        return Future.value(
          ApiResponseModel.failure(
            ApiErrorModel(
              title: 'Unsupported master detail type',
              message: 'Decoration-only types are not valid for master options.',
              status: 400,
            ),
          ),
        );
    }
  }
}
