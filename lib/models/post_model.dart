class Post {
  final String id;
  final String thumb;
  final String mobile;
  final String raw;
  final int likes;

  Post({
    required this.id,
    required this.thumb,
    required this.mobile,
    required this.raw,
    required this.likes,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      thumb: json['media_thumb_url'],
      mobile: json['media_mobile_url'],
      raw: json['media_raw_url'],
      likes: json['like_count'],
    );
  }
}