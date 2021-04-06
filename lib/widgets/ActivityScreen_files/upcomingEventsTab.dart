import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/models/events.dart';
import 'package:cmApp/providers/event_provider.dart';
import 'package:cmApp/widgets/ActivityScreen_files/activityCard.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class UpcomingEventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String clubId = Provider.of<EventProvider>(context).clubId;
    return PaginateFirestore(
        itemBuilderType: PaginateBuilderType.listView, // listview and gridview
        itemBuilder: (index, context, doc) => ActivityCard(
              eventData: Events(
                eventId: doc.id,
                title: doc.data()['title'].toString(),
                about: doc.data()['about'].toString(),
                clubId: doc.data()['clubId'].toString(),
                imageUrl: doc.data()['imageUrl'].toString(),
                startTime: (doc.data()['startTime'] as Timestamp).toDate(),
                endTime: (doc.data()['endTime'] as Timestamp).toDate(),
                venue: doc.data()['venue'].toString(),
                googleFormLink: doc.data()['googleFormLink'].toString(),
                fbPostLink: doc.data()['fbPostLink'].toString(),
              ),
              isCompleted: false,
              isOngoing: false,
              isUpcoming: true,
            ),
        // orderBy is compulsary to enable pagination
        query: FirebaseFirestore.instance
            .collection('events')
            .where('clubId', isEqualTo: clubId)
            .where('startTime', isGreaterThan: DateTime.now())
            .orderBy('startTime', descending: false),
        isLive: true // to fetch real-time data
        );
  }
}
