abstract interface class ShareService {
  Future<void> copyTextLink(String text);
  Future<void> shareImageTextLink(String imageUrl, String text);
}
