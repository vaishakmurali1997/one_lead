import 'package:flutter/material.dart';
import 'package:one_lead/pages/dashboard_page.dart';
import 'package:one_lead/pages/lead_form_page.dart';
import 'package:one_lead/pages/lead_info_page.dart';
import 'package:one_lead/pages/login_page.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
        case '/leadForm':
        return MaterialPageRoute(builder: (_) =>  LeadFormPage(leadId: args as String,));
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardPage());

      case '/leadInfo':
        {
          if (args is String) {
            return MaterialPageRoute(builder: (_) => LeadInfoPage(lead: args));
          } else {
            return MaterialPageRoute(
                builder: (_) => const Scaffold(
                      body: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "The page you looking for doesn't exist. If you are having trouble, kindly contact the support team for assistance.",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ));
          }
        }

      default:
        {
          return MaterialPageRoute(
              builder: (_) => const Scaffold(
                    body: Center(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "The page you looking for doesn't exist. If you are having trouble, kindly contact the support team for assistance.",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ));
        }
    }
  }
}
