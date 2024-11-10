import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Point {
  final String name;
  final String description;
  final List<Point>? subPoints;

  Point({
    required this.name,
    required this.description,
    this.subPoints,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      name: json['name'] as String,
      description: json['description'] as String,
      subPoints: json['subPoints'] != null
          ? (json['subPoints'] as List)
              .map((subPoint) => Point.fromJson(subPoint))
              .toList()
          : null,
    );
  }
}

class FeaturesToImpliment extends StatelessWidget {
  const FeaturesToImpliment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Features'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _loadJsonData("assets/feature_to_impliment.json"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading JSON: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final jsonData = snapshot.data;
            if (jsonData is List) {
              // Handle as a List (existing logic)
              final List<Point> points =
                  jsonData.map((point) => Point.fromJson(point)).toList();
              return ListView.builder(
                itemCount: points.length,
                itemBuilder: (context, index) => _buildPointItem(points[index]),
              );
            } else if (jsonData is Map<String, dynamic>) {
              // Handle as a single Object
              // Access points from the single object (adjust based on your structure)
              final List<dynamic> points = jsonData['points'] as List<dynamic>;
              final processedPoints =
                  points.map((point) => Point.fromJson(point)).toList();
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.r, vertical: 10.h),
                    child: Text(
                      "Features/Bugs Currently known to me, If you encounter any other bug please reach me out to me.",
                      style: TextStyle(fontSize: 18.r),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: const Divider(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: processedPoints.length,
                      itemBuilder: (context, index) =>
                          _buildPointItem(processedPoints[index]),
                    ),
                  ),
                ],
              );
                        } else {
              return const Center(child: Text('Unknown JSON data structure'));
            }
          } else {
            return const Center(child: Text('No JSON data found'));
          }
        },
      ),
    );
  }

  Future<dynamic> _loadJsonData(String filePath) async {
    try {
      final String jsonString = await rootBundle.loadString(filePath);
      final jsonData = jsonDecode(jsonString);
      return jsonData;
    } catch (e) {
      throw Exception('Error loading JSON: $e');
    }
  }

  Widget _buildPointItem(Point point) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                point.name,
                style: TextStyle(fontSize: 18.r, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Text(point.description),
              ),
              if (point.subPoints != null)
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: point.subPoints!.length,
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300.w,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 300.w,
                                child: Text(
                                  "- ${point.subPoints![index].name}",
                                  style: const TextStyle(
                                      fontSize: 16, fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            point.subPoints![index].description,
                            style: const TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
