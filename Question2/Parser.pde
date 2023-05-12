void parseFile() {
  // Open the file with createWriter() object
  BufferedReader reader = createReader("input.txt");
  String outputMessage = "";
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, ";");
      // Parse the array according to ";" then ","(inside parseArray()).
      String result = parseArray(pieces);
      // Create the output message 
      outputMessage = outputMessage + result;
    }
    reader.close();
    // Write the output to the output file.
    PrintWriter output = createWriter("output.txt");
    output.println(outputMessage); 
    output.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
} 

String parseArray(String[] pieces){
  
  ArrayList<Locator> locators = new ArrayList<>();
  
   for (int i = 0; i < pieces.length; i++){
      String[] pieceOfPieces = split(pieces[i], ",");
      String x = pieceOfPieces[0];
      String y = pieceOfPieces[1];
      String rotz = pieceOfPieces[2];
      String azimuth = pieceOfPieces[3];
      Locator locator = new Locator(x, y, rotz, azimuth);
      locators.add(locator);
   }
   eval(locators);
   return message;
}
