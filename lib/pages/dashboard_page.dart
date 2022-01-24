import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:one_lead/common/custom_progress.dart';
import 'package:one_lead/constants/color_code.dart';
import 'package:one_lead/utils/my_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var data = <String, dynamic>{};
  String newLead = "0";
  String hotLead = "0";
  String warmLead = "0";
  String coldLead = "0";
  String dumpLead = "0";
  String totalLead = "0";
  String visitLead = "0";
  String followLead = "0";
  String meetingLead = "0";
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getDashbordData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorCodes.primary,
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: loading
                ? customProgress(context)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/leadInfo',
                                        arguments: "New")
                                    .then((value) => setState(() {}));
                              },
                              child: Container(
                                  color: ColorCodes.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.insights,
                                            color: ColorCodes.primary),
                                        const SizedBox(height: 5),
                                        const Text("New Leads",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800)),
                                        const SizedBox(height: 5),
                                        Text(
                                          newLead,
                                          style: const TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/leadInfo',
                                        arguments: "Hot")
                                    .then((value) => setState(() {}));
                              },
                              child: Container(
                                  color: ColorCodes.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.local_fire_department,
                                            color: ColorCodes.primary),
                                        const SizedBox(height: 5),
                                        const Text("Hot Leads",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800)),
                                        const SizedBox(height: 5),
                                        Text(
                                          hotLead,
                                          style: const TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/leadInfo',
                                        arguments: "Warm")
                                    .then((value) => setState(() {}));
                              },
                              child: Container(
                                  color: ColorCodes.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.light_mode,
                                            color: ColorCodes.primary),
                                        const SizedBox(height: 5),
                                        const Text("Warm Leads",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800)),
                                        const SizedBox(height: 5),
                                        Text(
                                          warmLead,
                                          style: const TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/leadInfo',
                                        arguments: "Cold")
                                    .then((value) => setState(() {}));
                              },
                              child: Container(
                                  color: ColorCodes.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.ac_unit,
                                            color: ColorCodes.primary),
                                        const SizedBox(height: 5),
                                        const Text("Cold Leads",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800)),
                                        const SizedBox(height: 5),
                                        Text(
                                          coldLead,
                                          style: const TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/leadInfo',
                                        arguments: "dump")
                                    .then((value) => setState(() {}));
                              },
                              child: Container(
                                  color: ColorCodes.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.delete,
                                            color: ColorCodes.primary),
                                        const SizedBox(height: 5),
                                        const Text("Dump Leads",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800)),
                                        const SizedBox(height: 5),
                                        Text(
                                          dumpLead,
                                          style: const TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/leadInfo',
                                    arguments: "Total");
                              },
                              child: Container(
                                  color: ColorCodes.secondary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.local_fire_department,
                                            color: ColorCodes.primary),
                                        const SizedBox(height: 5),
                                        const Text("Total Leads",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800)),
                                        const SizedBox(height: 5),
                                        Text(
                                          totalLead,
                                          style: const TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text("MORE LEADS",
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorCodes.primary,
                              fontWeight: FontWeight.w900)),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/leadInfo',
                                  arguments: "Follow Up")
                              .then((value) => setState(() {}));
                        },
                        child: Container(
                          height: 50,
                          color: ColorCodes.secondary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("Follow Up",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const Spacer(),
                                Text(followLead,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/leadInfo',
                                  arguments: "Vist")
                              .then((value) => setState(() {}));
                          ;
                        },
                        child: Container(
                          height: 50,
                          color: ColorCodes.secondary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("Visit",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const Spacer(),
                                Text(visitLead,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/leadInfo',
                                  arguments: "Meeting")
                              .then((value) => setState(() {}));
                        },
                        child: Container(
                          height: 50,
                          color: ColorCodes.secondary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("Meeting",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const Spacer(),
                                Text(meetingLead,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // get dashbord data from backend.

  getDashbordData() async {
    setState(() {
      loading = true;
    });
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var dashbordData = <String, dynamic>{};
      dashbordData["emp_id"] = sharedPreferences.getString("emp_id");
      dashbordData["crm_id"] = sharedPreferences.getString("crm_id");
      dashbordData["com_id"] = sharedPreferences.getString("com_id");
      dashbordData["list"] = "list";
      if (sharedPreferences.getString("org") != null) {
        dashbordData["org"] = sharedPreferences.getString("org");
      }
      var response = await MyHttp.post('/lead_dash.php', dashbordData);
      if (response.statusCode == 200) {
        print("Response Body : ${response.body}");
        setState(() {
          data = json.decode(response.body);
        });

        for (var i = 0; i < data["response"].length; i++) {
          if (data["response"][i]["New"] != null) {
            setState(() {
              newLead = data["response"][i]["New"];
              loading = false; 
            });
          }
          if (data["response"][i]["Hot"] != null) {
            setState(() {
              hotLead = data["response"][i]["Hot"];
            });
          }
          if (data["response"][i]["Warm"] != null) {
            setState(() {
              warmLead = data["response"][i]["Warm"];
            });
          }
          if (data["response"][i]["Cold"] != null) {
            setState(() {
              coldLead = data["response"][i]["Cold"];
            });
          }
          if (data["response"][i]["dump"] != null) {
            setState(() {
              dumpLead = data["response"][i]["dump"];
            });
          }
          if (data["response"][i]["Total"] != null) {
            setState(() {
              totalLead = data["response"][i]["Total"];
            });
          }
          if (data["response"][i]["Follow Up"] != null) {
            setState(() {
              followLead = data["response"][i]["Follow Up"];
            });
          }
          if (data["response"][i]["Meeting"] != null) {
            setState(() {
              meetingLead = data["response"][i]["Meeting"];
            });
          }
          if (data["response"][i]["Visit"] != null) {
            setState(() {
              visitLead = data["response"][i]["Visit"];
            });
          }
        }
      } else {
        print("Response Code : ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  /// Returns the pie series
}
