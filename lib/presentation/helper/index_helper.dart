int? checkIndex(String? input, List? options, List? priorities,
    {required int i}) {
  int index = 0;
  if (input != null) {
    List<String> split = input.split("");
    String upperCased = split[0].toUpperCase();
    split.removeAt(0);
    split.insert(0, upperCased);
    String res = split.join();
    for (String pri in (i == 0 ? options! : priorities!)) {
      if (res != pri) {
        index++;
      } else if (res == pri) {
        break;
      }
    }
  }
  return index;
}
