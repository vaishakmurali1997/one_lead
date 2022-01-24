import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_lead/common/custom_progress.dart';
import 'package:one_lead/constants/color_code.dart';
import 'package:one_lead/models/leads_model.dart';
import 'package:one_lead/utils/my_http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadInfoPage extends StatefulWidget {
  final String lead;
  const LeadInfoPage({Key? key, required this.lead}) : super(key: key);

  @override
  _LeadInfoPageState createState() => _LeadInfoPageState(lead);
}

class _LeadInfoPageState extends State<LeadInfoPage> {
  var leadData;
  final String lead;
  _LeadInfoPageState(this.lead);

  @override
  void initState() {
    super.initState();
    getLeadsData(lead);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorCodes.primary,
        title: Text("$lead - Lead Info"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              leadData != null && leadData["response"] != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: leadData["response"].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Container(
                                color: index%2==0 ? ColorCodes.secondary : ColorCodes.secondaryWhite,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                                leadData["response"][index]
                                                    ["Lead ID"],
                                                style: const TextStyle(
                                                    color: ColorCodes.primary,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                                leadData["response"][index]
                                                    ["Customer Name"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {},
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                          context, "/leadForm",
                                                          arguments: leadData[
                                                                  "response"][
                                                              index]["Lead ID"])
                                                      .then((value) =>
                                                          setState(() {}));
                                                },
                                                child: const Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text("VIEW",
                                                      style: TextStyle(
                                                          color: ColorCodes
                                                              .primary,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          leadData["response"][index]
                                              ["Employee ID"],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700)),
                                      const Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.apartment,
                                                      color:
                                                          ColorCodes.primary),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      leadData["response"]
                                                          [index]["Type"],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      )),
                                                ],
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                    leadData["response"][index]
                                                        ["Date"],
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    )),
                                              )),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.place,
                                            color: ColorCodes.primary,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              leadData["response"][index]
                                                  ["Project Name"],
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      
                                      const Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: InkWell(
                                                onTap: () {
                                                  launch(
                                                      "https://wa.me/91${leadData["response"][index]["Mobile"]}");
                                                },
                                                child: Container(
                                                    color: ColorCodes.green,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children:  const [
                                                          Icon(
                                                            Icons.whatshot,
                                                            size: 20,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "WhatsApp",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10),
                                                          )
                                                        ],
                                                      ),
                                                    ))),
                                          ),
                                          const SizedBox(width: 2),
                                          Expanded(
                                            flex: 3,
                                            child: InkWell(
                                                onTap: () {
                                                  launch(
                                                      "sms:${leadData["response"][index]["Mobile"]}");
                                                },
                                                child: Container(
                                                    color: ColorCodes.yellow,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons.sms,
                                                            size: 20,
                                                            
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "SMS",
                                                            style: TextStyle(
                                                              
                                                                fontSize: 10),
                                                          )
                                                        ],
                                                      ),
                                                    ))),
                                          ),
                                          const SizedBox(width: 2),
                                          Expanded(
                                            flex: 4,
                                            child: InkWell(
                                                onTap: () async {
                                                  await launch(
                                                      "mailto:${leadData["response"][index]["Email"]}");
                                                },
                                                child: Container(
                                                    color: Colors.blueGrey,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons.mail,
                                                            size: 20,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "E - Mail",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10),
                                                          )
                                                        ],
                                                      ),
                                                    ))),
                                          ),
                                          const SizedBox(width: 2),
                                          Expanded(
                                            flex: 3,
                                            child: InkWell(
                                                onTap: () async {
                                                  print("AAGYA");
                                                  await launch(
                                                      "tel://${leadData["response"][index]["Mobile"]}");
                                                },
                                                child: Container(
                                                    color: ColorCodes.primary,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                            Icons.call,
                                                            size: 20,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Call",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10),
                                                          )
                                                        ],
                                                      ),
                                                    ))),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 5)
                            ],
                          ),
                        );
                      })
                  : customProgress(context)
            ],
          ),
        ),
      ),
    );
  }

  getLeadsData(lead) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var leadInfoData = <String, dynamic>{};
      leadInfoData["emp_id"] = sharedPreferences.getString("emp_id");
      leadInfoData["crm_id"] = sharedPreferences.getString("crm_id");
      leadInfoData["com_id"] = sharedPreferences.getString("com_id");
      leadInfoData["list"] = lead;
      if (sharedPreferences.getString("org") != null) {
        leadInfoData["org"] = sharedPreferences.getString("org");
      }
      var response = await MyHttp.post('/lead_dash.php', leadInfoData);
      if (response.statusCode == 200) {
        print("Recahed : ${response.body}");

        setState(() {
          leadData = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
