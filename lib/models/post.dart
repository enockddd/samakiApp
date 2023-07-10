class Post {
  final String id;
  final String? userId;
  final String? description;
  final String? createdAt;
  final String? postType;
  final String? contentUrl;
  final String? tags;
  final String? username;

  Post({
    required this.id,
    this.userId,
    this.description,
    this.createdAt,
    this.postType,
    this.contentUrl,
    this.tags,
    this.username,
  });

  factory Post.fromJson(Map<String, dynamic> json, String id) {
    return Post(
      id: id,
      userId: json['user_id'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      postType: json['post_type'] as String?,
      contentUrl: json['content_url'] as String?,
      tags: json['tags'] as String?,
      username: json['username'] as String?,
    );
  }
}
