class Helper {
  static Map<String, dynamic> splitOverView(
      {required String text, required int limit}) {
    if (text.length > limit) {
      int lastSpace = text.lastIndexOf(
          ' ', limit); // finded the last one space after the limit

      if (lastSpace == -1) {
        lastSpace = limit; // if there is'nt space, cut in the limit
      }

      String firstPart = text.substring(0, lastSpace).trim();
      String secondPart = text.substring(lastSpace).trim();

      return {
        'firstPart': firstPart,
        'secondPart': secondPart,
        'isDivide': true
      };
    } else {
      return {'firstPart': text, 'isDivide': false};
    }
  }
}
