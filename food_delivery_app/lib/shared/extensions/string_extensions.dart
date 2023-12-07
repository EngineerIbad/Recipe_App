extension CapitalizeInitials on String {
  String capitalizeInitials() {
    List data = split(" ");
    String capitalized = "";
    for (String item in data) {
      if (item.isNotEmpty) {
        capitalized +=
            "${item[0].toUpperCase() + item.substring(1, item.length)} ";
      }
    }
    return capitalized;
  }

  String initials({required int limit}) {
    
    String initialVal = trim().split(" ").map((e) => e[0]).join();

    if (initialVal.length > limit) {
      initialVal = initialVal.substring(0, limit);
    }
    return initialVal;
  }
}
