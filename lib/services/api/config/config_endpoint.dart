import '../../base/base_endpoint.dart';
import '../../base/method_request.dart';

abstract class ConfigEndpointProtocol {
  EndpointType getConfigs();
}

class ConfigEndpoint implements ConfigEndpointProtocol {
  @override
  EndpointType getConfigs() {
    final endpoint = EndpointType(
      path: "/app_api_v1/main/app-info",
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }
}
