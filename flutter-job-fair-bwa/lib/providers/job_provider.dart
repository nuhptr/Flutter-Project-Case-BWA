import 'dart:convert';

import 'package:bwa_flutter_jobs/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JobProvider with ChangeNotifier {
  Future<List<JobModel>?> getJobs() async {
    try {
      var response = await http.get(
        Uri.parse('https://bwa-jobs.herokuapp.com/jobs'),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        List<JobModel> jobs = [];
        List parseJson = jsonDecode(response.body);

        parseJson.forEach((job) {
          jobs.add(JobModel.fromJson(job));
        });

        return jobs;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<JobModel>?> getJobsByCategory(String category) async {
    try {
      var response = await http.get(
        Uri.parse('https://bwa-jobs.herokuapp.com/jobs?category=$category'),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        List<JobModel> jobs = [];
        List parseJson = jsonDecode(response.body);

        parseJson.forEach((job) {
          jobs.add(JobModel.fromJson(job));
        });

        return jobs;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}