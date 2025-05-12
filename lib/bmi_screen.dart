import 'package:flutter/material.dart';
import 'package:ratiovate/app_colors.dart';
import 'package:ratiovate/bmi_calculator.dart';
import 'package:ratiovate/bmi_result_screen.dart';

// Custom Neumorphic-style Card, aligned with V2 AppColors
class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? backgroundColor; // Allow override, but default to AppColors.cardBackground
  final bool selected;

  const NeumorphicCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0, // V2 used 16.0
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
    this.backgroundColor,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    // V2 NeumorphicCard did not have a 'selected' visual style directly, 
    // selection was handled by changing text/icon colors in the child.
    // For consistency, if selected is true, we can add a subtle border or slightly different shadow if desired,
    // but the primary background remains AppColors.cardBackground.
    final cardBg = backgroundColor ?? AppColors.cardBackground;
    
    BoxBorder? borderStyle;
    if (selected) {
      // V2 gender selector change card border color.
      borderStyle = Border.all(color: AppColors.primaryAccent, width: 1.5);
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderStyle, // Apply border if defined
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowDark.withValues(alpha: 0.5), // V2 style
              offset: const Offset(5, 5),
              blurRadius: 3,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: AppColors.shadowLight.withValues(alpha: 0.7), // V2 style
              offset: const Offset(-5, -5),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

// Custom Widget for +/- Stepper, aligned with V2 AppColors
class ValueStepper extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;
  final String unit;

  const ValueStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.unit = "",
  });

  Widget _buildStepperButton(BuildContext context, IconData icon, VoidCallback onPressed, {bool isAccent = false}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20), // V2 style
      child: Container(
        padding: const EdgeInsets.all(8), // V2 style
        decoration: BoxDecoration(
          color: AppColors.cardBackground, // V2 style
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowDark.withValues(alpha: 0.1),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: AppColors.shadowLight.withValues(alpha: 0.7),
              offset: const Offset(-2, -2),
              blurRadius: 4,
            ),
          ]
        ),
        child: Icon(
          icon,
          color: isAccent ? AppColors.primaryAccent : AppColors.iconColor, // V2 style
          size: 28, // V2 style
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Font sizes from V3, colors from V2
    final labelFontSize = screenSize.width * 0.042;
    final valueFontSize = screenSize.width * 0.075;
    final unitFontSize = screenSize.width * 0.038;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary, // V2 style
            fontWeight: FontWeight.w600, // Keep V3 boldness for label
            fontSize: labelFontSize,
          )
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "$value",
              style: TextStyle(
                color: AppColors.textPrimary, // V2 style
                fontWeight: FontWeight.bold,
                fontSize: valueFontSize,
              )
            ),
            if (unit.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  unit,
                  style: TextStyle(
                    color: AppColors.textSecondary, // V2 style for unit
                    fontWeight: FontWeight.w500,
                    fontSize: unitFontSize,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepperButton(context, Icons.remove, () => onDecrement(value - 1)),
            const SizedBox(width: 20), // V2 used 20
            _buildStepperButton(context, Icons.add, () => onIncrement(value + 1), isAccent: true),
          ],
        ),
      ],
    );
  }
}

// Custom Vertical Thermometer-style Height Slider, aligned with V2 AppColors philosophy
class ThermometerHeightSlider extends StatefulWidget {
  final double height;
  final ValueChanged<double> onChanged;
  final double minHeight;
  final double maxHeight;

  const ThermometerHeightSlider({
    super.key,
    required this.height,
    required this.onChanged,
    this.minHeight = 100,
    this.maxHeight = 230,
  });

  @override
  State<ThermometerHeightSlider> createState() => _ThermometerHeightSliderState();
}

class _ThermometerHeightSliderState extends State<ThermometerHeightSlider> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final labelFontSize = screenSize.width * 0.042;
    final valueFontSize = screenSize.width * 0.055;
    final unitFontSize = screenSize.width * 0.038;

    return LayoutBuilder(builder: (context, constraints) {
      double availableHeight = constraints.maxHeight;
      double topPaddingForText = screenSize.height * 0.06;
      double bottomPadding = screenSize.height * 0.02;
      double trackHeight = availableHeight - topPaddingForText - bottomPadding;
      if (trackHeight < 100) trackHeight = 100;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Height",
            style: TextStyle(
              color: AppColors.textSecondary, // V2 philosophy for labels
              fontWeight: FontWeight.w600,
              fontSize: labelFontSize,
            )
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
               Text(
                widget.height.toStringAsFixed(0),
                style: TextStyle(
                  color: AppColors.primaryAccent, // V2 philosophy for primary values
                  fontWeight: FontWeight.bold,
                  fontSize: valueFontSize,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "cm",
                  style: TextStyle(
                    color: AppColors.textSecondary, // V2 philosophy for units
                    fontWeight: FontWeight.w500,
                    fontSize: unitFontSize,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                double newHeight = widget.height - (details.delta.dy * ((widget.maxHeight - widget.minHeight) / trackHeight));
                widget.onChanged(newHeight.clamp(widget.minHeight, widget.maxHeight));
              },
              child: CustomPaint(
                size: Size(60, trackHeight),
                painter: _ThermometerPainter(
                  heightValue: widget.height,
                  minHeight: widget.minHeight,
                  maxHeight: widget.maxHeight,
                  trackHeight: trackHeight,
                  accentColor: AppColors.primaryAccent, // V2 philosophy
                  tickColor: AppColors.textSecondary.withValues(alpha: 0.7), // V2 philosophy
                  backgroundColor: AppColors.primaryBackground.withValues(alpha: 0.5), // V2 philosophy (light track)
                  indicatorLineColor: AppColors.primaryAccent.withValues(alpha: 0.7), // V2 philosophy
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _ThermometerPainter extends CustomPainter {
  final double heightValue;
  final double minHeight;
  final double maxHeight;
  final double trackHeight;
  final Color accentColor;
  final Color tickColor;
  final Color backgroundColor;
  final Color indicatorLineColor;

  _ThermometerPainter({
    required this.heightValue,
    required this.minHeight,
    required this.maxHeight,
    required this.trackHeight,
    required this.accentColor,
    required this.tickColor,
    required this.backgroundColor,
    required this.indicatorLineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trackPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final Paint fillPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    final Paint tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 1.0;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
    );

    double trackWidth = 12.0;
    double trackCenterX = size.width / 2;
    RRect trackRRect = RRect.fromLTRBR(
      trackCenterX - trackWidth / 2,
      0,
      trackCenterX + trackWidth / 2,
      trackHeight,
      const Radius.circular(6),
    );
    canvas.drawRRect(trackRRect, trackPaint);

    double valueRatio = (heightValue - minHeight) / (maxHeight - minHeight);
    valueRatio = valueRatio.clamp(0.0, 1.0);
    double fillHeight = valueRatio * trackHeight;
    RRect fillRRect = RRect.fromLTRBR(
      trackCenterX - trackWidth / 2,
      trackHeight - fillHeight,
      trackCenterX + trackWidth / 2,
      trackHeight,
      const Radius.circular(6),
    );
    canvas.drawRRect(fillRRect, fillPaint);

    int majorTickEvery = 10;
    double tickLengthMajor = 15.0;
    double tickLengthMinor = 8.0;

    for (double h = minHeight; h <= maxHeight; h += 5) {
      double yPos = trackHeight - (((h - minHeight) / (maxHeight - minHeight)) * trackHeight);
      bool isMajorTick = (h.toInt() % majorTickEvery == 0);
      double currentTickLength = isMajorTick ? tickLengthMajor : tickLengthMinor;

      canvas.drawLine(
        Offset(trackCenterX + trackWidth / 2 + 2, yPos),
        Offset(trackCenterX + trackWidth / 2 + 2 + currentTickLength, yPos),
        tickPaint,
      );

      if (isMajorTick) {
        textPainter.text = TextSpan(
          text: "${h.toInt()}",
          style: TextStyle(color: tickColor, fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(trackCenterX + trackWidth / 2 + 5 + currentTickLength, yPos - textPainter.height / 2));
      }
    }
    double selectedYPos = trackHeight - (((heightValue - minHeight) / (maxHeight - minHeight)) * trackHeight);
    selectedYPos = selectedYPos.clamp(0.0, trackHeight);

    Paint selectedLinePaint = Paint()
      ..color = indicatorLineColor 
      ..strokeWidth = 2.0;
    canvas.drawLine(
        Offset(trackCenterX - trackWidth/2 - 5 - tickLengthMajor, selectedYPos),
        Offset(trackCenterX + trackWidth/2 + 5 + tickLengthMajor, selectedYPos),
        selectedLinePaint);
  }

  @override
  bool shouldRepaint(covariant _ThermometerPainter oldDelegate) {
    return oldDelegate.heightValue != heightValue || 
           oldDelegate.trackHeight != trackHeight ||
           oldDelegate.accentColor != accentColor ||
           oldDelegate.tickColor != tickColor ||
           oldDelegate.backgroundColor != backgroundColor ||
           oldDelegate.indicatorLineColor != indicatorLineColor;
  }
}

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

enum Gender { male, female }

class _BmiScreenState extends State<BmiScreen> {
  Gender? _selectedGender = Gender.male;
  double _currentHeightCm = 170;
  int _currentWeightKg = 70;
  int _currentAge = 25;

  Widget _buildGenderSelector(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // V3 sizes, V2 colors
    final genderButtonPaddingVertical = screenSize.height * 0.018;
    final genderIconSize = screenSize.width * 0.05;
    final genderTextSize = screenSize.width * 0.038;

    return Row(
      children: [
        Expanded(
          child: NeumorphicCard(
            onTap: () => setState(() => _selectedGender = Gender.male),
            selected: _selectedGender == Gender.male, // selected prop for NeumorphicCard (visuals handled inside if any)
            padding: EdgeInsets.symmetric(vertical: genderButtonPaddingVertical, horizontal: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.male, color: _selectedGender == Gender.male ? AppColors.primaryAccent : AppColors.iconColor, size: genderIconSize),
              const SizedBox(width: 8),
              Text(
                'Male',
                style: TextStyle(
                  color: _selectedGender == Gender.male ? AppColors.primaryAccent : AppColors.textSecondary,
                  fontWeight: _selectedGender == Gender.male ? FontWeight.bold : FontWeight.normal,
                  fontSize: genderTextSize,
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: NeumorphicCard(
            onTap: () => setState(() => _selectedGender = Gender.female),
            selected: _selectedGender == Gender.female,
            padding: EdgeInsets.symmetric(vertical: genderButtonPaddingVertical, horizontal: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.female, color: _selectedGender == Gender.female ? AppColors.primaryAccent : AppColors.iconColor, size: genderIconSize),
              const SizedBox(width: 8),
              Text(
                'Female',
                style: TextStyle(
                  color: _selectedGender == Gender.female ? AppColors.primaryAccent : AppColors.textSecondary,
                  fontWeight: _selectedGender == Gender.female ? FontWeight.bold : FontWeight.normal,
                  fontSize: genderTextSize,
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  void _calculateAndNavigate() {
    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a gender.'), backgroundColor: AppColors.error), // V2 style
      );
      return;
    }
    double heightMeters = _currentHeightCm / 100.0;
    double bmi = BmiCalculator.calculateBmi(_currentWeightKg.toDouble(), heightMeters);
    String category = BmiCalculator.getBmiCategory(bmi);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BmiResultScreen(
          bmi: bmi,
          category: category,
          age: _currentAge,
          gender: _selectedGender!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // V3 sizes
    final mainHorizontalPadding = screenSize.width * 0.05;
    final mainVerticalPadding = screenSize.height * 0.04;
    final spacingBetweenElements = screenSize.height * 0.04;
    final buttonVerticalPadding = screenSize.height * 0.02; // V2 used 18 (fixed), V3 uses responsive
    final buttonHeight = screenSize.height * 0.065;
    final buttonBorderRadius = screenSize.width * 0.07;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground, // V2 style for scaffold background
      appBar: AppBar(
        title: const Text('BMI Calculator', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)), // V2 style
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryBackground, // V2 often used cardBackground or transparent for AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 26, color: AppColors.iconColor), // V2 style
            onPressed: () { /* Placeholder for settings */ },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mainHorizontalPadding).copyWith(top: mainVerticalPadding, bottom: mainVerticalPadding),
          child: Column(
            children: <Widget>[
              _buildGenderSelector(context),
              SizedBox(height: spacingBetweenElements),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: NeumorphicCard(
                              padding: const EdgeInsets.all(12),
                              child: ValueStepper(
                                label: 'Weight',
                                unit: 'kg',
                                value: _currentWeightKg,
                                onIncrement: (val) => setState(() => _currentWeightKg = val.clamp(20, 250)),
                                onDecrement: (val) => setState(() => _currentWeightKg = val.clamp(20, 250)),
                              ),
                            ),
                          ),
                          SizedBox(height: spacingBetweenElements * 0.8),
                          Expanded(
                            child: NeumorphicCard(
                              padding: const EdgeInsets.all(12),
                              child: ValueStepper(
                                label: 'Age',
                                unit: 'yrs',
                                value: _currentAge,
                                onIncrement: (val) => setState(() => _currentAge = val.clamp(2, 120)),
                                onDecrement: (val) => setState(() => _currentAge = val.clamp(2, 120)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spacingBetweenElements * 0.8),
                    Expanded(
                      flex: 2,
                      child: NeumorphicCard(
                        padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.01),
                        child: ThermometerHeightSlider(
                          height: _currentHeightCm,
                          onChanged: (newHeight) {
                            setState(() {
                              _currentHeightCm = newHeight;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spacingBetweenElements),
              ElevatedButton(
                onPressed: _calculateAndNavigate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAccent, // V2 style for button background
                  foregroundColor: AppColors.textOnAccent, // V2 style for text on accent button
                  padding: EdgeInsets.symmetric(vertical: buttonVerticalPadding),
                  minimumSize: Size(double.infinity, buttonHeight),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonBorderRadius)),
                  elevation: 3,
                ),
                child: Text(
                  '''Let's Begin''',
                  style: TextStyle( // Explicitly use TextStyle for direct color control if needed
                    fontSize: screenSize.width * 0.042,
                    color: AppColors.textOnAccent, // Ensure this is AppColors.textOnAccent
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

