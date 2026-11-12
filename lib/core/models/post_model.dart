class PostModel {
  final String author;
  final String handle;
  final String avatar;
  final String image;
  final int likes;
  final int comments;
  final int shares;
  final String caption;
  final bool isVerified;
  final double aspectRatio;

  const PostModel({
    required this.author,
    required this.handle,
    required this.avatar,
    required this.image,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.caption,
    required this.aspectRatio,
    this.isVerified = false,
  });
}
