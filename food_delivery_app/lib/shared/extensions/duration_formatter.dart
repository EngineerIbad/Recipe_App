extension TimerValue on Duration {
  String formatInHHMMSS({bool showUnit = false}) {
    int inHrs = inHours % 24;
    int inMins = inMinutes % 60;
    int inSecs = inSeconds % 60;

    // String formatting
    String hours = inHrs < 10 ? "0$inHrs" : "$inHrs";
    String mins = inMins < 10 ? "0$inMins" : "$inMins";
    String secs = inSecs < 10 ? "0$inSecs" : "$inSecs";

    if (showUnit) {
      return "$hours hrs, $mins mins, $secs secs";
    }
    return "$hours:$mins:$secs";
  }

  String formatInHH({bool showUnit = false}) {
    int inHrs = inHours % 24;

    // String formatting
    String hours = inHrs < 10 ? "0$inHrs" : "$inHrs";

    if (showUnit) {
      return "$hours hrs";
    }
    return hours;
  }

  String formatInHHMM({
    bool showUnit = false,
    String hrFormat = "hrs",
    String minFormat = "mins",
    bool splitLines = false,
  }) {
    int inHrs = inHours % 24;
    int inMins = inMinutes % 60;

    // String formatting
    String hours = inHrs < 10 ? "0$inHrs" : "$inHrs";
    String mins = inMins < 10 ? "0$inMins" : "$inMins";

    if (showUnit) {
      if(splitLines) {
        return "$hours $hrFormat\n$mins $minFormat";
      }
      return "$hours $hrFormat, $mins $minFormat";
    }
    return "$hours:$mins";
  }

  String formatInMMSS({bool showUnit = false}) {
    int inMins = inMinutes % 60;
    int inSecs = inSeconds % 60;

    // String formatting
    String mins = inMins < 10 ? "0$inMins" : "$inMins";
    String secs = inSecs < 10 ? "0$inSecs" : "$inSecs";

    if (showUnit) {
      return "$mins mins, $secs secs";
    }
    return "$mins:$secs";
  }

  String formatInHHSS({bool showUnit = false}) {
    int inHrs = inHours % 24;
    int inSecs = inSeconds % 60;

    // String formatting
    String hours = inHrs < 10 ? "0$inHrs" : "$inHrs";
    String secs = inSecs < 10 ? "0$inSecs" : "$inSecs";

    if (showUnit) {
      return "$hours hrs, $secs secs";
    }
    return "$hours:$secs";
  }

  String formatInMM({bool showUnit = false}) {
    int inMins = inMinutes % 60;

    // String formatting
    String mins = inMins < 10 ? "0$inMins" : "$inMins";

    if (showUnit) {
      return "$mins mins";
    }
    return mins;
  }

  String formatInSS({bool showUnit = false}) {
    int inSecs = inSeconds % 60;

    // String formatting
    String secs = inSecs < 10 ? "0$inSecs" : "$inSecs";

    if (showUnit) {
      return "$secs secs";
    }
    return secs;
  }

  String format({
    bool showUnit = false,
    bool showHours = true,
    bool showMins = true,
    bool showSecs = true,
  }) {
    int inHrs = inHours % 24;
    int inMins = inMinutes % 60;
    int inSecs = inSeconds % 60;

    // String formatting
    String hours = inHrs < 10 ? "0$inHrs" : "$inHrs";
    String mins = inMins < 10 ? "0$inMins" : "$inMins";
    String secs = inSecs < 10 ? "0$inSecs" : "$inSecs";

    if (showUnit) {
      if (showHours && showMins) {
        return "$hours hrs, $mins mins";
      } else if (showHours && showSecs) {
        return "$hours hrs, $secs secs";
      } else if (showMins && showSecs) {
        return "$mins mins, $secs secs";
      } else if (showHours) {
        return "$hours hrs";
      } else if (showMins) {
        return "$mins mins";
      } else if (showSecs) {
        return "$secs secs";
      }
      return "$hours hrs, $mins mins, $secs secs";
    } else {
      if (showHours && showMins) {
        return "$hours:$mins";
      } else if (showHours && showSecs) {
        return "$hours:$secs";
      } else if (showMins && showSecs) {
        return "$mins:$secs";
      } else if (showHours) {
        return hours;
      } else if (showMins) {
        return mins;
      } else if (showSecs) {
        return secs;
      }
      return "$hours:$mins:$secs";
    }
  }
}
