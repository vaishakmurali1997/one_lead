import 'dart:convert';

LeadDataModel leadDataModelFromJson(String str) => LeadDataModel.fromJson(json.decode(str));

String leadDataModelToJson(LeadDataModel data) => json.encode(data.toJson());

class LeadDataModel {
    LeadDataModel({
      required  this.status,
      required  this.response,
    });

    String status;
    Response response;

    factory LeadDataModel.fromJson(Map<String, dynamic> json) => LeadDataModel(
        status: json["status"],
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "response": response.toJson(),
    };
}

class Response {
    Response({
      required  this.leadId,
      required  this.projectName,
      required  this.name,
      required  this.mobile,
      required  this.email,
      required  this.query,
    });

    String leadId;
    String projectName;
    String name;
    String mobile;
    String email;
    String query;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        leadId: json["Lead ID"],
        projectName: json["Project Name"],
        name: json["Name"],
        mobile: json["Mobile"],
        email: json["Email"],
        query: json["Query"],
    );

    Map<String, dynamic> toJson() => {
        "Lead ID": leadId,
        "Project Name": projectName,
        "Name": name,
        "Mobile": mobile,
        "Email": email,
        "Query": query,
    };
}
