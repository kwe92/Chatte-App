// TODO: ensure that collectionPath parameters have a type of CollectionPath instead of String

enum CollectionPath {
  users("users"),

  chat("/chat/3Rzps9JekqBlFfihf2Jq/messages"),

  images("user_images");

  final String path;

  const CollectionPath(this.path);
}
