// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  late StreamChatClient client;
  late Channel channel;
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initStreamChatClient();
  }

  Future<void> _initStreamChatClient() async {
    client = StreamChatClient(
      'APIKEY HERE',
      logLevel: Level.INFO,
    );

    await client.connectUser(
      User(id: 'tutorial-flutter'),
      'USERTOKEN',
    );

    channel = client.channel('messaging', id: 'flutterdevs');
    await channel.watch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamChat(
            client: client,
            child: MaterialApp(
              home: StreamChannel(
                channel: channel,
                child: Scaffold(
                  appBar: const StreamChannelHeader(),
                  body: Column(
                    children: const <Widget>[
                      Expanded(
                        child: StreamMessageListView(),
                      ),
                      StreamMessageInput(),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
