import 'package:flutter/material.dart';
import 'package:ratiovate/app_colors.dart';
import 'package:ratiovate/bmi_calculator.dart';

class BmiDetailsScreen extends StatelessWidget {
  final double bmi;

  const BmiDetailsScreen({super.key, required this.bmi});

  // Aligning with V2 color logic for categories
  Color _getCategoryColor(String category, BuildContext context) {
    if (category == "Underweight") return AppColors.success; // V2 color
    if (category == "Normal weight") {
      return Colors.lightBlue.shade400; // V2 color
    }
    if (category == "Overweight") return Colors.orange.shade600; // V2 color
    if (category == "Obese") return AppColors.error; // V2 color
    return AppColors.textPrimary; // V2 default
  }

  Widget _buildBmiCategoryCard(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // V3 sizes
    final cardPadding = screenSize.width * 0.04;
    final titleFontSize = screenSize.width * 0.045;
    final textFontSize = screenSize.width * 0.038;
    final spacing = screenSize.height * 0.01;

    const categories = {
      "Underweight": "< 18.5",
      "Normal weight": "18.5 - 24.9",
      "Overweight": "25 - 29.9",
      "Obese": ">= 30",
    };

    return Card(
      elevation:
          3.0, // V2 often had subtle elevation or relied on neumorphic shadows
      margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: AppColors.cardBackground, // V2 card background
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "BMI Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary, // V2 primary text color
                fontSize: titleFontSize,
              ),
            ),
            SizedBox(height: spacing * 1.5),
            ...categories.entries.map((entry) {
              final categoryName = entry.key;
              final categoryRange = entry.value;
              final categoryColor = _getCategoryColor(categoryName, context);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: spacing * 0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(
                        color: categoryColor, // V2 derived category color
                        fontWeight: FontWeight.w500,
                        fontSize: textFontSize,
                      ),
                    ),
                    Text(
                      categoryRange,
                      style: TextStyle(
                        color:
                            AppColors.textSecondary, // V2 secondary text color
                        fontSize: textFontSize,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildYourBmiCard(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // V3 sizes
    final cardPadding = screenSize.width * 0.05;
    final bmiValueFontSize = screenSize.width * 0.1;
    final bmiLabelFontSize = screenSize.width * 0.04;

    final String currentCategory = BmiCalculator.getBmiCategory(bmi);
    final Color currentCategoryColor =
        _getCategoryColor(currentCategory, context);

    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: AppColors.cardBackground, // V2 card background
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your BMI",
              style: TextStyle(
                color: AppColors.textPrimary, // V2 primary text color
                fontWeight: FontWeight.bold,
                fontSize: screenSize.width * 0.055,
              ),
            ),
            SizedBox(height: screenSize.height * 0.015),
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(
                color: currentCategoryColor, // V2 derived category color
                fontWeight: FontWeight.bold,
                fontSize: bmiValueFontSize,
              ),
            ),
            SizedBox(height: screenSize.height * 0.005),
            Text(
              currentCategory,
              style: TextStyle(
                color: currentCategoryColor, // V2 derived category color
                fontWeight: FontWeight.w500,
                fontSize: bmiLabelFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final mainPadding = screenSize.width * 0.06;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground, // V2 scaffold background
      appBar: AppBar(
        title: const Text(
          'BMI Info',
          style: TextStyle(
            color: AppColors.textPrimary, // V2 AppBar title color
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary), // V2 AppBar icon color
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0, // V2 often had flat AppBars or subtle shadow
        backgroundColor: AppColors.primaryBackground, // V2 AppBar background
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(mainPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildYourBmiCard(context),
              SizedBox(height: screenSize.height * 0.01),
              _buildBmiCategoryCard(context),
            ],
          ),
        ),
      ),
    );
  }
}
