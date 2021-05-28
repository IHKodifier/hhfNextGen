import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hhf_next_gen/app/console_utility.dart';
import 'package:hhf_next_gen/app/constants/styles.dart';
import 'package:hhf_next_gen/app/locator.dart';
import 'package:hhf_next_gen/app/routing/router.dart';
import 'package:hhf_next_gen/app/theme.dart';
import 'package:hhf_next_gen/services/navigation_service.dart';
import 'package:hhf_next_gen/app/routing/routenames.dart' as routes;
import 'package:hhf_next_gen/ui/views/home/home_welcome_note.dart';
import 'package:hhf_next_gen/ui/views/home/job_inbox.dart';
import 'package:hhf_next_gen/ui/views/home/project_overview.dart';
import 'package:hhf_next_gen/ui/widgets/search_bar/searchbar.dart';

class HomeContentDesktop extends StatelessWidget {
  const HomeContentDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Home',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SearchBar(),
              ],
            ),
            Container(
              height: 500,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('financingCases')
                    .snapshots(),
                // initialData: initialData ,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    child: ElevatedButton.icon(
                                        style: globalButtonStyle,
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('financingCases')
                                              .add({
                                            'createdBy': 'Firestore',
                                            'patientId': 'Kamzor Khan'
                                          });
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          size: 45,
                                        ),
                                        label: Text('New Case')),
                                  ),
                                ),
                                Card(
                                  elevation: 5,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.account_circle_rounded,
                                      size: 45,
                                    ),
                                    title: Text(
                                      snapshot.data.docs[index]['patientId'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      snapshot.data.docs[index]['createdBy'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Icon(
                                  Icons.account_circle_rounded,
                                  size: 45,
                                ),
                                title: Text(
                                  snapshot.data.docs[index]['patientId'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                                subtitle: Text(
                                  snapshot.data.docs[index]['createdBy'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            );
                          }
                        });
                    // return Text('xcvxcvxffd');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildNavBar(BuildContext context) {
    return Navigator(
      key: servicelocator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: routes.HomeRoute,
    );
  }
}
