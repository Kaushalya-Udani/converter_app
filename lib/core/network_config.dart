  class IPAddress {
  static const String dev = "api.freecurrencyapi.com/";
}

class ServiceProtocol {
  static const String dev = "https://";
}

class ContextRoot {
  static const String dev = "v1/";
}

class NetworkConfig {
  static String getNetworkConfig() {
    return _getServiceProtocol() + _getIpAddress() + _getContextRoot();
  }

  static String _getIpAddress() {
    return IPAddress.dev;
  }

  static String _getContextRoot() {
    return ContextRoot.dev;
  }

  static String _getServiceProtocol() {
    return ServiceProtocol.dev;
  }
}
