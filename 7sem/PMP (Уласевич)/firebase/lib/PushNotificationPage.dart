import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationPage extends StatefulWidget {
  @override
  _PushNotificationPageState createState() => _PushNotificationPageState();
}

class _PushNotificationPageState extends State<PushNotificationPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final TextEditingController _topicController = TextEditingController();
  String _errorMessage = '';
  String _token = '';

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  Future<void> _initializeFirebaseMessaging() async {
    try {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
        String? token = await _firebaseMessaging.getToken();
        print('Firebase token: $token');
        setState(() {
          _token = token ?? 'Token not available';
        });
      } else {
        print('User declined or has not yet granted permission');
      }
    } catch (e) {
      print('Failed to initialize notifications: $e');
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  Future<void> _subscribeToTopic(String topic) async {
    setState(() {
      _errorMessage = '';
    });
    if (topic.isNotEmpty) {
      try {
        await _firebaseMessaging.subscribeToTopic(topic);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Subscribed to topic: $topic'),
          ),
        );
      } catch (e) {
        print('Failed to subscribe to topic: $e');
        setState(() {
          _errorMessage = 'Failed to subscribe to topic: $e';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Topic name cannot be empty';
      });
    }
  }

  Future<void> _unsubscribeFromTopic(String topic) async {
    setState(() {
      _errorMessage = '';
    });
    if (topic.isNotEmpty) {
      try {
        await _firebaseMessaging.unsubscribeFromTopic(topic);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unsubscribed from topic: $topic'),
          ),
        );
      } catch (e) {
        print('Failed to unsubscribe from topic: $e');
        setState(() {
          _errorMessage = 'Failed to unsubscribe from topic: $e';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Topic name cannot be empty';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Push Notifications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Subscribe to Topic',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _topicController,
              decoration: InputDecoration(
                labelText: 'Enter topic name',
                border: OutlineInputBorder(),
                errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _subscribeToTopic(_topicController.text);
              },
              child: Text('Subscribe'),
            ),
            SizedBox(height: 20),
            Text(
              'Unsubscribe from Topic',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                _unsubscribeFromTopic(_topicController.text);
              },
              child: Text('Unsubscribe'),
            ),
            SizedBox(height: 20),
            Text(
              'FirebaseMessaging token: $_token',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}