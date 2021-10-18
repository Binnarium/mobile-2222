extension RemoveSpecialCharactersFromString on String {
  String removeSpecialCharacters({String replaceWith = '_'}) {
    final Pattern p = RegExp("[&\/\\#, +()\$~%.'\":*?<>{}]");

    final String newString = replaceAll(p, replaceWith);
    return newString;
  }
}
