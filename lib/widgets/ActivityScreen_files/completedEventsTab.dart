import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/models/events.dart';
import 'package:cmApp/providers/event_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:cmApp/widgets/ActivityScreen_files/activityCard.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class CompletedEventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String clubId = Provider.of<EventProvider>(context).clubId;
    return PaginateFirestore(
      bottomLoader: LoadingSpinner(),
      itemsPerPage: 6,
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
            .where('endTime', isLessThanOrEqualTo: DateTime.now())
            .orderBy('endTime', descending: true),
        isLive: true // to fetch real-time data
        );
  }
}
