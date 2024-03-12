import '../../../models/app_info/mfast_app_info_model.dart';
import '../../../models/base_model.dart';
import '../../base/base_response.dart';
import '../api_service.dart';
import 'config_endpoint.dart';

abstract class ConfigApi {
  Future<BaseModel<MFastAppInfoModel>> getConfigs();
}

class ConfigApiImpl implements ConfigApi {
  @override
  Future<BaseModel<MFastAppInfoModel>> getConfigs() async {
    BaseResponse apiResponse = await APIService.instance.requestData(ConfigEndpoint().getConfigs());
    if (apiResponse.status == true) {
      return BaseModel<MFastAppInfoModel>(
        status: true,
        data: MFastAppInfoModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<MFastAppInfoModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }
}
