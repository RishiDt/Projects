import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VideoInfo {
  final videoName;
  final uploadedBy;
  final uploadedAt;
  final videoDescription;
  final videoLocation;
  final comments;

  //will be set while fetching firestore document
  String? url;

  Map<String, dynamic> _doc = {};

  VideoInfo({
    required this.videoName,
    required this.uploadedBy,
    this.uploadedAt,
    this.videoDescription,
    this.url,
    this.videoLocation,
    this.comments,
  }) {
    _doc = {
      "videoName": videoName,
      "uploadedBy": uploadedBy,
      "uploadedAt": uploadedAt,
      "videoDescription": videoDescription,
      "url": url,
      "videoLocation": videoLocation,
      "comments": comments
    };
  }

  static fromDoc(_doc) {
    return VideoInfo(
        videoName: _doc['videoName'],
        uploadedBy: _doc['uploadedBy'],
        uploadedAt: _doc['uploadedAt'],
        videoDescription: _doc['videoDescription'],
        url: _doc['url'],
        videoLocation: _doc['videoLocation'],
        comments: _doc['comments']);
  }

  Map<String, dynamic> get doc => _doc;

  bool addToDoc({key, value}) {
    switch (key) {
      case 'videoName':
        _doc['videoName'] = value;
        return true;
      case 'uploadedBy':
        _doc['UploadedBy'] = value;
        return true;
      case 'uploadedAt':
        _doc['uploadedAt'] = value;
        return true;
      case 'videoDescription':
        _doc['videoDescription'] = value;
        return true;
      case 'videoLocation':
        _doc['videoLocation'] = value;
        return true;
      case 'comments':
        _doc['comments'] = value;
        return true;
      case 'url':
        _doc['url'] = value;
        return true;
      default:
        return false;
    }
  }
}
