import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/model/%20chat_message_model.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../model/conversation_model.dart';
import '../utils/api_service.dart';
import '../utils/api_url.dart';

class ChatDetailsViewModel extends ChangeNotifier {
  ConversationModel? conversationModel;

  String messageType = '';
  String? message;
  String? selectedUrl;
  String? audioUrl;

  final RecorderController recorderController = RecorderController()
    ..androidEncoder = AndroidEncoder.aac
    ..androidOutputFormat = AndroidOutputFormat.mpeg4
    ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
    ..bitRate = 44100;
  // ..sampleRate = 44100;

  bool loading = false;
  bool isrecord = false;
  String? error;

  String? audiopath;

  late Directory appDirectory;
  String? path;

  updateISRecord(bool? rec) {
    isrecord = rec!;
    notifyListeners();
  }

  updateAduioFile(BuildContext context, String? audio) async {
    audiopath = audio;
    messageType = 'audio';
    // Convert audio to Uint8List
    Uint8List? audioBytes = await convertAudioToUint8List(audio);
    audioUrl = await context
        .read<FileUploadViewModel>()
        .pickedAudioUpload(audioBytes, 'chat', audiopath!.split('/').last);
    notifyListeners();
    sentmessage(context: context);
  }
  final TextEditingController messageController = TextEditingController();


  updateTextContect(String tex) {
    message = tex;
    messageType = 'text';
    notifyListeners();
  }

  updateImageContect(BuildContext contxt, String tex) {
    selectedUrl = tex;
    messageType = 'image';
    print("image");
    notifyListeners();
    sentmessage(context: contxt);
  }

  updateConversationModel(ConversationModel val) {
    conversationModel = val;
    notifyListeners();
  }

  void getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
  }

  Future record(
    BuildContext context, {
    // required FlutterSoundRecorder recorder,
    required bool isRecorderReady,
  }) async {
    if (!isRecorderReady) return;

    await recorderController.record(path: path);
    // startRecordTime = DateTime.now();
  }

  Future stop(
    BuildContext context, {
    // required FlutterSoundRecorder recorder,
    required bool isRecorderReady,
  }) async {
    if (!isRecorderReady) return;

    final audioPath = await recorderController.stop();

    await updateAduioFile(context, audioPath);
  }


  List<ChatMessageModel> messages = [];
  Future<void> fetchAllConversations(int page) async {
    if (conversationModel != null) {
      EasyLoading.show();
      String api = Api.getAllMessage;
      Response response = await ApiService()
          .get('$api/${conversationModel!.sId}?pageNumber=$page&pageSize=100');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['status']) {
          messages = (data['data']['messages'] as List)
              .map(
                (e) => ChatMessageModel.fromJson(e),
              )
              .toList();
        } else {
          messages.clear();
        }
        notifyListeners();
      }
      EasyLoading.dismiss();
    }
  }

  Future<void> sentmessage({required BuildContext context}) async {
    EasyLoading.show();
    print("messageType:- $messageType");
    print("audioUrl:- $audioUrl");

    Response response = await ApiService().post(Api.sentMessage, {
      "profileId": LoggedInUser.id,
      "content": messageType == 'image'
          ? selectedUrl
          : messageType == 'audio'
              ? audioUrl
              : message,
      "messageType": messageType
    });

    log(response.data.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          // Navigator.pop(context);
          EasyLoading.showSuccess(data['message']);
        }
      }
    }
    messageController.clear();
    fetchAllConversations(1);
    message = null;
    selectedUrl = null;
    audioUrl = null;
    notifyListeners();
    print("sended chat:-");

    EasyLoading.dismiss();
  }

  Future<void> updatemessage(
      {required String lastMessageId, required BuildContext context}) async {
    EasyLoading.show();
    Response response = await ApiService().post(Api.updateChat, {
      "conversationId": conversationModel!.sId,
      "lastMessageId": lastMessageId,
    });
    log(response.data.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      if (data['status']) {
        if (data.containsKey('message')) {
          // Navigator.pop(context);
          EasyLoading.showSuccess(data['message']);
        }
      }
    }
    EasyLoading.dismiss();
  }

  Future<Uint8List?> convertAudioToUint8List(String? audioPath) async {
    if (audioPath == null) return null;

    try {
      File audioFile = File(audioPath);

      // Check if file exists
      if (!await audioFile.exists()) {
        print('Audio file does not exist');
        return null;
      }

      // Read file as Uint8List
      Uint8List audioBytes = await audioFile.readAsBytes();
      return audioBytes;
    } catch (e) {
      print('Error converting audio to Uint8List: $e');
      return null;
    }
  }
}
