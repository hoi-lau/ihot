class BiliItem {
  BiliItem({
    required this.pic,
    required this.title,
    required this.ownerName,
    required this.view,
    required this.danmaku,
    required this.shortLinkV2,
  });

  final String pic;
  final String title;
  final String shortLinkV2;
  final String ownerName;
  final int view;
  final int danmaku;
}
