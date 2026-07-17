class Env {
  static late String apiUrl;
  static late String flavorName;

  static void init({required String apiUrl, required String flavorName}) {
    Env.apiUrl = apiUrl;
    Env.flavorName = flavorName;
  }
}