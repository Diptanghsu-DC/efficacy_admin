import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/update_event.dart';
import 'package:efficacy_admin/utils/custom_network_image.dart';
import 'event_details.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventsViewer extends StatefulWidget {
  static const String routeName = "/eventFullScreen";
  final EventModel currentEvent;
  const EventsViewer({
    super.key,
    required this.currentEvent,
  });

  @override
  State<EventsViewer> createState() => _EventsViewerState();
}

class _EventsViewerState extends State<EventsViewer> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          body: SlidingUpPanel(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.3,
                ),
                Container(
                  height: 4,
                  width: screenWidth * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 30),
            maxHeight: screenHeight,
            minHeight: screenHeight * 0.63,
            panel: EventDetails(currentEvent: widget.currentEvent),
            body: Column(
              children: [
                widget.currentEvent.posterURL == null || widget.currentEvent.posterURL.isEmpty ?
                Image.asset(
                  Assets.mediaImgPath,
                  fit: BoxFit.cover,
                  height: screenHeight * 0.4,
                ): 
                CustomNetworkImage(
                  url: widget.currentEvent.posterURL,
                  height: screenHeight * 0.4,
                  errorWidget: (BuildContext context, _, __) {
                    return Image.asset(
                      Assets.mediaImgPath,
                      fit: BoxFit.cover,
                      height: screenHeight * 0.4,
                    );
                  },
                ),
                // Image.network(
                //   widget.currentEvent.posterURL,
                //   fit: BoxFit.cover,
                //   height: screenHeight * 0.4,
                // ),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=>
                  UpdateEvent(
                    title: widget.currentEvent.title,
                    shortDescription: widget.currentEvent.shortDescription,
                    longDescription: widget.currentEvent.longDescription,
                    venue: widget.currentEvent.venue,
                    googleUrl: widget.currentEvent.registrationLink,
                    fbUrl: widget.currentEvent.facebookPostURL,
                    startDate: widget.currentEvent.startDate,
                    endDate: widget.currentEvent.endDate,
                    startTime: TimeOfDay.fromDateTime(widget.currentEvent.startDate),
                    endTime: TimeOfDay.fromDateTime(widget.currentEvent.endDate),
                  )));
            },
            child: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: 35,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.close,
                  size: screenHeight * 0.035,
                  color: dark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
