class Drawings {
  Drawings({
    required this.id,
    required this.groupOffsetss,
  });

  final String id;
  final List<GroupOffsetss> groupOffsetss;

  factory Drawings.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final groupOffsetssData = data['groupOFPoints'] as List<dynamic>;
    final groupOffsets = groupOffsetssData
        .map((groupOffsetssData) => GroupOffsetss.fromJson(groupOffsetssData))
        .toList();

    return Drawings(
      id: id,
      groupOffsetss: groupOffsets,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'painting': groupOffsetss.map((review) => review.toJson()).toList(),
    };
  }
}

class GroupOffsetss {
  GroupOffsetss({
    required this.offsetX,
    required this.offsetY,
    required this.size,
    required this.color,
  });

  final double offsetX;
  final double offsetY;
  final double size;
  final int color;

  factory GroupOffsetss.fromJson(Map<String, dynamic> data) {
    final ofssetX = data['offsetX'] as double;
    final ofssetY = data['offsetY'] as double;
    final size = data['size'] as double;
    final color = data['color'] as int;

    return GroupOffsetss(
        offsetX: ofssetX, offsetY: ofssetY, size: size, color: color);
  }

  Map<String, dynamic> toJson() {
    return {
      'offsetX': offsetX,
      'offsetY': offsetY,
      'size': size,
      'color': color
    };
  }
}
