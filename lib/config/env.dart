/// Holds environment-specific configuration values.
class Env {
  /// The base API URL for the current environment.
  static late String apiUrl;

  /// The human-readable name of the current environment.
  static late String flavorName;

  /// Initializes the environment values for the current flavor.
  static void init({required String apiUrl, required String flavorName}) {
    Env.apiUrl = apiUrl;
    Env.flavorName = flavorName;
  }
}
