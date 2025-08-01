class SetupConstants {

  static final SetupConstants _instance= SetupConstants._internal();

  bool isWorkSetup= false;
  bool isProfileSetup= false;
  bool isDocumentSetup= false;
  static String googleApiKey="AIzaSyD19MebWM9G6n4J6yr01dF8OKEho_hvl2Y";

  factory SetupConstants() {
    return _instance;
  }

  SetupConstants._internal();
}