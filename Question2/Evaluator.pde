String message = "";

String eval(ArrayList<Locator> locators){
  if (locators.size() == 1)   // Finding tag device with one device is impossible.
    message = "fail\n";  
  else{
    FloatList intersectionPtsX = new FloatList();
    FloatList intersectionPtsY = new FloatList();
    for (int i = 0; i < locators.size(); i++){ // Find every intersection point but not more than once.
        for (int j = i; j < locators.size(); j++){
          float angleI = locators.get(i).findAngle();
          float angleJ = locators.get(j).findAngle();
          float[] intersectionArray = findIntersectionPts(locators.get(i).x, locators.get(i).y, angleI , locators.get(j).x,locators.get(j).y, angleJ);
          if (intersectionArray == null){ // If every locators are in parallel, tag device cannot be located.
            message = "fail\n";
            return message;
          }
          float intersectionPointX = intersectionArray[0];
          float intersectionPointY = intersectionArray[1];
          if (intersectionPtsX.hasValue(intersectionPointX) == false && intersectionPtsY.hasValue(intersectionPointY) == false){
            intersectionPtsX.append(intersectionPointX);
            intersectionPtsY.append(intersectionPointY);
          }
        }
      }
    if (intersectionPtsX.size() != intersectionPtsY.size())   // Every X point must have a Y point; otherwise an error occurs.
      message = "fail\n";    
    else{
      float xTotal = 0;
      float yTotal = 0;
      for (int i = 0; i < intersectionPtsX.size(); i++){   // Find the centre of the shape that is created.
          xTotal += intersectionPtsX.get(i);               // Determine the error, and write everything to a string and add to the message.
          yTotal += intersectionPtsY.get(i);
      }
      float resultX = (xTotal / intersectionPtsX.size());
      float resultY = (yTotal / intersectionPtsY.size());
      int roundedX = round(resultX);
      int roundedY = round(resultY);
      float error = ((((resultX - roundedX) / resultX) + ((resultY - roundedY) / resultY)) / 2);
      String lineToWrite = str(resultX) + "," + str(resultY) + "," + str(error) + "\n";
      message = lineToWrite;
    }  
  }
  return message;
}

float[] findIntersectionPts (float x1, float y1, float angle1, float x2, float y2, float angle2){
    // Find the line equation a1x + b1y = c1 after finding two more points for this line.
    float[] newPoints = pointfinder(x1, y1, angle1);
    float x3 = newPoints[0];
    float y3 = newPoints[1];
    float a1 = y3 - y1;
    float b1 = x1 - x3;  
    float c1 = (a1 * x1) + (b1 * y1);
    // Find the line equation a2x + b2y = c2 after finding two more points for this line.
    newPoints = pointfinder(x2, y2, angle2);
    float x4 = newPoints[0];
    float y4 = newPoints[1];
    float a2 = y4 - y2;
    float b2 = x2 - x4;
    float c2 = (a2 * x2) + (b2 * y2);
    // Find the determinant and then intersection points if determinant is not zero, i.e. they are not parallel.
    float determinant = a1*b2 - a2*b1;
    if (determinant != 0){
      float x = (b2*c1 - b1*c2)/determinant;
      float y = (a1*c2 - a2*c1)/determinant;
      float[] points = {x, y};
      return points;
    }
    float [] error = null;
    return error;
}

float[] pointfinder (float x, float y, float angle){
    // Find the equation "y = mx + n" then convert to the form of "n = y - mx"
    float slope = tan(angle);
    float n = y - slope * x;
    float newX = x + random(0, 40);    // Find another point by incrementing "x" randomly.
    float newY = slope * newX + n;
    float[] newPoints = {newX, newY};
    return newPoints;
}
