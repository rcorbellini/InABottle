extension DateFunctions on DateTime {
  String toTimeAgo() {
    if (this == null) {
      return "";
    }
    var duration = DateTime.now().toLocal().difference(this.toLocal());

    var days = duration.inDays;
    if (days > 0) {
      return "${days}d";
    }

    var hours = duration.inHours.remainder(24);
    if (hours > 0) {
      return "${hours}h";
    }

    var minutes = duration.inMinutes.remainder(60);
    if (minutes > 0) {
      return "${minutes}m";
    }

    var seconds = duration.inSeconds.remainder(60);
    if (seconds > 0) {
      return "${seconds}s";
    }

    return "";
  }
}
