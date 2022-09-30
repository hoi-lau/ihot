class Tag {
  Tag({required this.title, required this.tagId});

  String title;
  int tagId;
}

class UrlBody {
  UrlBody({required this.url});

  String url;
}

class VideoBody {
  VideoBody({required this.img});

  String img;
}

class PostHeader {
  PostHeader(
      {required this.title,
      required this.topic_name,
      required this.share,
      this.pics,
      this.video});

  String title;
  String topic_name;
  UrlBody share;
  List<UrlBody>? pics;
  VideoBody? video;
}

class PostResp {
  PostResp({required this.schemaUrl, required this.thread});

  String schemaUrl;
  PostHeader thread;
}
