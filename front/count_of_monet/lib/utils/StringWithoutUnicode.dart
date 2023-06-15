extension WithoutUnicode on String {
  String noUnicode() {
    String ret = "";
    for (int i = 0; i < length; i++) {
      if (this[i] == "&") {
        if (this[i + 1] == "#") {
          i += 2;
          String charcode = "";
          while (this[i] != ";") {
            charcode += this[i];
            i++;
          }
          ret += String.fromCharCode(int.parse(charcode));
          continue;
        }
      }
      ret += this[i];
    }
    return ret;
  }
}
