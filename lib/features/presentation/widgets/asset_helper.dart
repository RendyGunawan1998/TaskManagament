class AssetsHelper {
  static String imgLogo = img("logo.jpg");

  // static String icEye = ic("eye.png");
  // static String icPen = ic("pen.png");

  static String img(String name) {
    return "assets/images/$name";
  }

  static String ic(String name) {
    return "assets/icons/$name";
  }
}
