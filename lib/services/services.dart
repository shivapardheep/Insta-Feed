class Services {
  String formatAgo(String input) {
    final parts = input.split(" ");
    if (parts.length < 2) return input;

    final number = int.tryParse(parts[0]) ?? 0;
    final unit = parts[1].toLowerCase();

    if (unit.startsWith("month")) return "${number}mo";
    if (unit.startsWith("week")) return "${number}w";
    if (unit.startsWith("day")) return "${number}d";
    if (unit.startsWith("hour")) return "${number}h";
    if (unit.startsWith("minute")) return "${number}m";
    if (unit.startsWith("second")) return "${number}s";

    return input;
  }
}
