class MyUrl {

  static String nakedUrl = "https://www.1lead.in/mobile_api/";
  
  static String url(String endPoint) {
    if (endPoint.substring(0, 1) == "/") endPoint = endPoint.substring(1);
    return Uri.encodeFull("${MyUrl.nakedUrl}/$endPoint");
  }
}