import 'dart:math';

class BmiCalculator {
  // Calculates BMI given weight in kilograms and height in meters.
  static double calculateBmi(double weightKg, double heightMeters) {
    if (heightMeters <= 0 || weightKg <= 0) {
      return 0;
    }
    return weightKg / pow(heightMeters, 2);
  }

  // Converts height from feet and inches to meters.
  static double heightToMeters(int feet, int inches) {
    if (feet < 0 || inches < 0) {
      return 0;
    }
    double totalInches = (feet * 12.0) + inches;
    return totalInches * 0.0254;
  }

  // Determines the BMI category based on the BMI value.
  static String getBmiCategory(double bmi) {
    if (bmi <= 0) {
      return "Invalid input"; // Or handle as an error
    }
    if (bmi < 18.5) {
      return "Underweight";
    }
    if (bmi < 25) {
      return "Normal weight";
    }
    if (bmi < 30) {
      return "Overweight";
    }
    return "Obese";
  }

  // Provides a descriptive message along with the BMI category.
  static String getBmiResultMessage(double bmi) {
    String category = getBmiCategory(bmi);
    if (category == "Invalid input") {
        return "Please enter valid weight and height.";
    }
    return "Your BMI is ${bmi.toStringAsFixed(1)}. You are $category.";
  }
}

