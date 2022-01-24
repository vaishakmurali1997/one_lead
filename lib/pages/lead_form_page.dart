import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:one_lead/common/custom_progress.dart';
import 'package:one_lead/constants/color_code.dart';
import 'package:one_lead/models/leads_model.dart';
import 'package:one_lead/utils/my_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadFormPage extends StatefulWidget {
  final String leadId;
  const LeadFormPage({Key? key, required this.leadId}) : super(key: key);

  @override
  _LeadFormPageState createState() => _LeadFormPageState(leadId);
}

class _LeadFormPageState extends State<LeadFormPage> {
  var leadData;
  final String leadId;
  String status = "Other Location";
  String remark = "";
  String meetingDate = "";
  String visitDate = "";
  String cityL = "";
  String follDate = "";
  String secNumber = "";

  _LeadFormPageState(this.leadId);
  @override
  void initState() {
    super.initState();
    getLeadData(leadId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorCodes.primary,
        title: Text("Lead ID - $leadId"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: leadData != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Lead Referral",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 5),
                    Text(leadData["response"]["Project Name"],
                        style: const TextStyle(fontSize: 14)),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.badge,
                            size: 30, color: ColorCodes.primary),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Name",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 5),
                            Text(leadData["response"]["Name"],
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.call,
                            size: 30, color: ColorCodes.primary),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Mobile",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 5),
                            Text(leadData["response"]["Mobile"],
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.mail,
                            size: 30, color: ColorCodes.primary),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("E-Mail",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 5),
                            Text(leadData["response"]["Email"],
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.help_outline,
                            size: 30, color: ColorCodes.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Lead Query",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(height: 5),
                              Text(leadData["response"]["Query"],
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text("Secondary Editable Details",
                        style: TextStyle(
                            color: ColorCodes.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    const Text("Secondary Mobile Number",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          secNumber = text;
                        });
                      },
                      cursorColor: ColorCodes.primary,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorCodes.primary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorCodes.primary),
                          ),
                          hintText: "+91"),
                    ),
                    const SizedBox(height: 10),
                    const Text("Lead Sign",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    DropdownButton<String>(
                      value: status,
                      isExpanded: true,
                      hint: const Text("Select Lead Status"),
                      items: <String>[
                        'New',
                        'Hot',
                        'Warm',
                        'Cold',
                        'dump',
                        'Other Location'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != "Other Location") {
                          print("reached"); 
                          setState(() {
                            status = value!;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text("Meeting Date",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    DateTimePicker(
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        initialValue:
                            leadData["response"]["meeting_date"] ?? "",
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Date',
                        selectableDayPredicate: (date) {
                          // Disable weekend days to select from the calendar
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }

                          return true;
                        },
                        onChanged: (val) => {
                              setState(() {
                                meetingDate = val;
                              })
                            },
                        validator: (val) {
                          return null;
                        },
                        onSaved: (val) => print(val)),
                    const SizedBox(height: 10),
                    const Text("Visit Date",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'd MMM, yyyy',
                      initialValue: leadData["response"]["visit_date"] ?? "",
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: const Icon(Icons.event),
                      dateLabelText: 'Date',
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }

                        return true;
                      },
                      onChanged: (val) => {
                        setState(() {
                          visitDate = val;
                        })
                      },
                      validator: (val) {
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                    const SizedBox(height: 10),
                    const Text("Follow Up Date",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'd MMM, yyyy',
                      initialValue: leadData["response"]["foll_date"] ?? "",
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: const Icon(Icons.event),
                      dateLabelText: 'Date',
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }
                        return true;
                      },
                      onChanged: (val) => {
                        setState(() {
                          follDate = val;
                        })
                      },
                      validator: (val) {
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                    const SizedBox(height: 10),
                    const Text("Notes",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          remark = text;
                        });
                      },
                      
                      maxLines: 5,
                      cursorColor: ColorCodes.primary,
                      decoration: const InputDecoration(
                          fillColor: ColorCodes.secondary,
                          filled: true,
                          border: OutlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorCodes.primary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorCodes.primary),
                          ),
                          hintText: "Type here ..."),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                        onTap: () => {submitData(leadId)},
                        child: Container(
                          color: ColorCodes.primary,
                          width: double.infinity,
                          height: 40.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("Submit",
                                  style: TextStyle(
                                      color: ColorCodes.whiteColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        )),
                  ],
                )
              : customProgress(context),
        )),
      ),
    );
  }

  getLeadData(leadId) async {
    print("Rweach");
    try {
      var data = <String, dynamic>{};
      var sharedPreferences = await SharedPreferences.getInstance();
      data["emp_id"] = sharedPreferences.getString("emp_id");
      data["lead_id"] = leadId;
      data["change_status"] = "form";
      var response = await MyHttp.post('/lead_form.php', data);
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          leadData = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error $e");
    }
  }

  getLeadStatusList(leadId) async {
    try {
      var data = <String, dynamic>{};
      var sharedPreferences = await SharedPreferences.getInstance();
      data["emp_id"] = sharedPreferences.getString("emp_id");
      data["lead_id"] = leadId;
      data["change_status"] = "list_status";
      var response = await MyHttp.post('/lead_form.php', data);
      if (response.statusCode == 200) {
        print(response.body);
        // setState(() {
        //   leadData = json.decode(response.body);
        // });
      }
    } catch (e) {
      print("Error $e");
    }
  }

  submitData(leadId) async {
    print("Rweach 2");
    try {
      var data = <String, dynamic>{};
      var sharedPreferences = await SharedPreferences.getInstance();
      data["emp_id"] = sharedPreferences.getString("emp_id");
      data["lead_id"] = leadId;
      data["status"] = status;
      data["remark"] = remark;
      data["meeting_date"] = meetingDate;
      data["visit_date"] = visitDate;
      data["foll_date"] = follDate;
      data["change_status"] = "ok";
      var response = await MyHttp.post('/lead_form.php', data);
      if (response.statusCode == 200) {
        Navigator.pop(context); 
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
