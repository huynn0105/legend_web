class FirebaseDatabaseUtil {
  FirebaseDatabaseUtil._();

  static String convertUrlAvatar(String? url) {
    if (url == null || url.isEmpty == true) {
      return '';
    }
    final findIndexFolder = url.indexOf('images');
    final isFirebaseUrl = url.contains("firebase");
    if (findIndexFolder < 0 || !isFirebaseUrl) {
      return url;
    }
    final lastIndexFolder = url.indexOf('?');
    final findSubString = url.substring(findIndexFolder, lastIndexFolder);
    final newUrl = findSubString.split('/').join('%2F');
    final urlRight = url.replaceFirst(findSubString, newUrl);
    return urlRight;
  }
}
