class Stringbuffer {
  static String writeSumthing(String text1, String text2){
  StringBuffer buffer = StringBuffer();
  buffer.clear();
  buffer.write(text1);
  buffer.write(text2);
  String sumthing = buffer.toString();
  buffer.clear();
  return sumthing;
  }
}