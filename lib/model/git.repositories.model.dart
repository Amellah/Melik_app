class GitRepository {
  GitRepository({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    required this.stargazersCount,
  });

  late final int id;
  late final int stargazersCount;
  late final String nodeId;
  late final String name;
  late final String fullName;
  late final bool private;

  GitRepository.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    fullName = json['full_name'];
    private = json['private'];
    stargazersCount = json['stargazers_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['node_id'] = nodeId;
    _data['name'] = name;
    _data['full_name'] = fullName;
    _data['private'] = private;
    _data['stargazers_count'] = stargazersCount;
    return _data;
  }
}
