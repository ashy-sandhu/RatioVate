import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ratiovate/app_colors.dart';
import 'package:ratiovate/bmi_screen.dart'; // For Gender enum
import 'package:ratiovate/bmi_calculator.dart'; // For BmiCalculator.getBmiResultMessage
import 'package:ratiovate/bmi_details_screen.dart'; // Import the new details screen

// Custom Painter for the animated and refined segmented BMI result circle, aligned with V2 AppColors
class AnimatedSegmentedBmiCircle extends StatefulWidget {
  final double bmi;
  final String category;
  // V2 used a resultColor for progress, derived from category. We'll pass that directly.
  final Color progressColor;
  // V2 used AppColors.primaryBackground.withOpacity(0.5) for segment background
  final Color segmentBackgroundColor;

  const AnimatedSegmentedBmiCircle({
    super.key,
    required this.bmi,
    required this.category,
    required this.progressColor,
    required this.segmentBackgroundColor,
  });

  @override
  State<AnimatedSegmentedBmiCircle> createState() =>
      _AnimatedSegmentedBmiCircleState();
}

class _AnimatedSegmentedBmiCircleState extends State<AnimatedSegmentedBmiCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    // V3 animation logic, V2 color inputs
    _animation = Tween<double>(begin: 0.0, end: widget.bmi).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedBmiText =
        widget.bmi <= 0 ? "--" : widget.bmi.clamp(0.0, 30.0).toStringAsFixed(1);
    final screenSize = MediaQuery.of(context).size;

    return CustomPaint(
      painter: _SegmentedBmiCirclePainter(
        animatedBmiValue: _animation.value,
        actualBmi: widget.bmi,
        progressColor: widget.progressColor, // Use V2-derived progress color
        segmentBackgroundColor:
            widget.segmentBackgroundColor, // Use V2-derived background color
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayedBmiText,
              style: TextStyle(
                color: widget
                    .progressColor, // V2: resultColor (same as progressColor)
                fontWeight: FontWeight.bold,
                fontSize: screenSize.width * 0.12, // V3 size
              ),
            ),
            Text(
              "BMI",
              style: TextStyle(
                color: AppColors.textSecondary, // V2 style
                fontSize: screenSize.width * 0.04, // V3 size
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SegmentedBmiCirclePainter extends CustomPainter {
  final double animatedBmiValue;
  final double actualBmi;
  final Color progressColor;
  final Color segmentBackgroundColor;
  final int totalSegments = 100; // V3 segments
  final double segmentSpacingAngle = 0.015; // V3 spacing
  final double strokeWidth =
      14.0; // V2 used 14.0, V3 used 6.0. Let's try V2's thickness for visual match.

  _SegmentedBmiCirclePainter({
    required this.animatedBmiValue,
    required this.actualBmi,
    required this.progressColor,
    required this.segmentBackgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = segmentBackgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap
          .butt; // V3 used butt, V2 used round. Let's use butt for sharper segments.

    Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt; // V2 used round, V3 used butt.

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - strokeWidth / 2;
    double fullCircleAngle = (2 * math.pi);
    double totalSpacingForAllSegments = totalSegments * segmentSpacingAngle;
    double drawableAnglePerSegment = math.max(
        0, (fullCircleAngle - totalSpacingForAllSegments) / totalSegments);

    for (int i = 0; i < totalSegments; i++) {
      double startAngleOffset = -(math.pi / 2);
      double currentSegmentStartAngle = startAngleOffset +
          (i * (drawableAnglePerSegment + segmentSpacingAngle));
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentSegmentStartAngle,
        drawableAnglePerSegment,
        false,
        backgroundPaint,
      );
    }

    // V3 progress logic (cap at 30, 100 segments)
    double effectiveBmiForProgress = animatedBmiValue.clamp(0.0, 30.0);
    double progressRatio =
        (effectiveBmiForProgress <= 0) ? 0 : (effectiveBmiForProgress / 30.0);
    progressRatio = progressRatio.clamp(0.0, 1.0);
    int segmentsToShow = (progressRatio * totalSegments).floor();

    for (int i = 0; i < segmentsToShow; i++) {
      double startAngleOffset = -(math.pi / 2);
      double currentSegmentStartAngle = startAngleOffset +
          (i * (drawableAnglePerSegment + segmentSpacingAngle));
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentSegmentStartAngle,
        drawableAnglePerSegment,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SegmentedBmiCirclePainter oldDelegate) {
    return oldDelegate.animatedBmiValue != animatedBmiValue ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.segmentBackgroundColor != segmentBackgroundColor;
  }
}

class BmiResultScreen extends StatelessWidget {
  final double bmi;
  final String category;
  final int age;
  final Gender gender;

  const BmiResultScreen({
    super.key,
    required this.bmi,
    required this.category,
    required this.age,
    required this.gender,
  });

  // V2 color logic for category text and progress circle
  Color _getResultColor(BuildContext context, String currentCategory) {
    if (currentCategory == "Underweight") {
      return AppColors.success; // V2 color
    }
    if (currentCategory == "Normal weight") {
      return Colors.lightBlue.shade400; // V2 color
    }
    if (currentCategory == "Overweight") {
      return Colors.orange.shade600; // V2 color
    }
    if (currentCategory == "Obese") return AppColors.error; // V2 color
    return AppColors.textPrimary; // V2 default
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final resultColor = _getResultColor(context, category);

    // V2 used AppColors.primaryBackground.withOpacity(0.5) for circle segment background
    final circleSegmentBg = AppColors.primaryBackground.withValues(alpha: 0.5);

    // V3 responsive sizing
    double mainPadding = screenSize.width * 0.06;
    double circleDiameter = screenSize.width * 0.65;
    double cardPaddingForInset = screenSize.width * 0.03;
    double circleWidgetDiameter = circleDiameter - (cardPaddingForInset * 2);
    double spacing1 = screenSize.height * 0.03;
    double spacing2 = screenSize.height * 0.015;
    double buttonSpacing = screenSize.height * 0.015;
    double horizontalTextPadding = screenSize.width * 0.04;
    double buttonVerticalPadding = screenSize.height * 0.02; // V2 used fixed 18
    double buttonHeight = screenSize.height * 0.065;
    double buttonBorderRadius = screenSize.width * 0.07;

    return Scaffold(
      backgroundColor:
          AppColors.primaryBackground, // V2 style for scaffold background
      appBar: AppBar(
        title: const Text(
          'BMI Results',
          style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold), // V2 style
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary), // V2 style
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: AppColors
            .primaryBackground, // V2 often used cardBackground or transparent
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline,
                color: AppColors.iconColor), // V2 style
            onPressed: () {
              // V2 Dialog logic
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.cardBackground,
                  title: const Text("BMI Categories",
                      style: TextStyle(color: AppColors.textPrimary)),
                  content: const Text(
                      "Underweight: < 18.5\nNormal weight: 18.5–24.9\nOverweight: 25–29.9\nObese: BMI of 30 or greater",
                      style: TextStyle(color: AppColors.textSecondary)),
                  actions: [
                    TextButton(
                      child: const Text("OK",
                          style: TextStyle(color: AppColors.primaryAccent)),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(mainPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // V3 circular card container, V2 colors for circle
                    Container(
                      width: circleDiameter,
                      height: circleDiameter,
                      decoration: BoxDecoration(
                        color: AppColors
                            .cardBackground, // V2 card background for the container
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowDark.withValues(alpha: 1),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: AppColors.shadowLight.withValues(alpha: 1),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: const Offset(0, -8),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(cardPaddingForInset),
                      child: SizedBox(
                        width: circleWidgetDiameter,
                        height: circleWidgetDiameter,
                        child: AnimatedSegmentedBmiCircle(
                          bmi: bmi,
                          category: category,
                          progressColor: resultColor, // V2 derived color
                          segmentBackgroundColor:
                              circleSegmentBg, // V2 derived color
                        ),
                      ),
                    ),
                    SizedBox(height: spacing1),
                    Text(
                      category,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: resultColor, // V2 derived color
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: screenSize.width * 0.075, // V3 size
                      ),
                    ),
                    SizedBox(height: spacing2),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalTextPadding),
                      child: Text(
                        BmiCalculator.getBmiResultMessage(bmi),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary, // V2 style
                          height: 1.5,
                          fontSize: screenSize.width * 0.04, // V3 size
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: spacing1, bottom: screenSize.height * 0.01),
                child: Column(
                  children: [
                    // "Details" button from V3, styled with V2 philosophy
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BmiDetailsScreen(bmi: bmi),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors
                            .cardBackground, // V2: Buttons often used cardBackground or a light color
                        foregroundColor: AppColors
                            .primaryAccent, // V2: Accent color for text on light buttons
                        elevation: 10,
                        padding: EdgeInsets.symmetric(
                            vertical: buttonVerticalPadding),
                        minimumSize: Size(double.infinity, buttonHeight),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(buttonBorderRadius)),
                        side: BorderSide(
                            color: AppColors.shadowDark.withValues(alpha: 0.2),
                            width: 0.5), // Subtle border like V2 neumorphic
                      ),
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.042,
                          color:
                              AppColors.primaryAccent, // Ensure V2 accent color
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: buttonSpacing),
                    // "Recalculate BMI" button, V2 style
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAccent, // V2 style
                        foregroundColor: AppColors.textOnAccent, // V2 style
                        elevation: 10,
                        padding: EdgeInsets.symmetric(
                            vertical: buttonVerticalPadding),
                        minimumSize: Size(double.infinity, buttonHeight),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(buttonBorderRadius)),
                        side: BorderSide(
                            color: AppColors.shadowDark.withValues(alpha: 0.2),
                            width: 0.5), // Subtle border like V2 neumorphic
                      ),
                      child: Text(
                        'Recalculate BMI',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.042,
                          color: AppColors
                              .textOnAccent, // Ensure V2 text on accent color
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
