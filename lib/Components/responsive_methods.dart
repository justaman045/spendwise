import 'package:flutter/material.dart';

double getResponsiveWidth(BuildContext context) {
  // Get the screen size using MediaQuery
  final screenWidth = MediaQuery.of(context).size.width;

  // Define breakpoints based on your table ranges (adjust as needed)
  const double smallWidthBreakpoint = 320.0;
  const double mediumWidthBreakpoint = 360.0;
  const double largeWidthBreakpoint = 420.0;

  // Assign width based on screen size and breakpoints
  if (screenWidth < smallWidthBreakpoint) {
    return double.infinity; // Full width for small screens
  } else if (screenWidth < mediumWidthBreakpoint) {
    return (screenWidth -
        16.0); // Apply some padding for medium screens (optional)
  } else if (screenWidth < largeWidthBreakpoint) {
    return (screenWidth * 0.8); // Use 80% width for medium-large screens
  } else {
    return 600.0; // Fixed width for large screens (tablets)
  }
}

double getResponsiveHeight(BuildContext context) {
  // Get the screen size using MediaQuery
  final screenHeight = MediaQuery.of(context).size.height;

  // Define breakpoints for different height ranges (adjust as needed)
  const double smallHeightBreakpoint = 568.0; // Common iPhone SE height
  const double mediumHeightBreakpoint = 667.0; // Common iPhone 8 Plus height
  const double largeHeightBreakpoint = 810.0; // Common iPad Mini height

  // Calculate a baseline ratio assuming common 16:9 aspect ratio
  const double baselineAspectRatio = 16.0 / 9.0;

  // Calculate baseline height based on width (assuming landscape mode)
  final double baselineHeight =
      getResponsiveWidth(context) / baselineAspectRatio;

  // Apply breakpoints to adjust height
  if (screenHeight <= smallHeightBreakpoint) {
    return baselineHeight * 0.9; // Adjust multiplier for small screens
  } else if (screenHeight <= mediumHeightBreakpoint) {
    return baselineHeight; // No adjustment for medium screens
  } else if (screenHeight <= largeHeightBreakpoint) {
    return baselineHeight * 1.1; // Adjust multiplier for large screens
  } else {
    return baselineHeight *
        1.2; // Adjust multiplier for extra large screens (tablets)
  }
}

double getResponsiveSize(BuildContext context,
    {double percent = 1.0, double minSize = 0.0}) {
  final size = MediaQuery.of(context).size;
  final availableSize = size.width < size.height ? size.width : size.height;

  // Calculate size based on screen size and percentage
  double calculatedSize = availableSize * percent;

  // Ensure minimum size is respected
  return calculatedSize > minSize ? calculatedSize : minSize;
}

double getResponsiveWidgetSize(
  BuildContext context,
  double desiredSize, {
  double smallFactor = 0.8,
  double mediumFactor = 0.6,
  double largeFactor = 0.5,
}) {
  final size = MediaQuery.of(context).size;

  // Categorize screen size based on width thresholds
  final isSmallScreen = size.width < 600; // Adjust thresholds as needed
  final isMediumScreen = size.width < 800 && !isSmallScreen;

  // Calculate size based on screen category
  double adjustedSize;
  if (isSmallScreen) {
    adjustedSize = desiredSize * smallFactor;
  } else if (isMediumScreen) {
    adjustedSize = desiredSize * mediumFactor;
  } else {
    adjustedSize = desiredSize * largeFactor;
  }

  // Ensure size is within available space
  return adjustedSize.clamp(0.0, size.width);
}

double getScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;
double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;
