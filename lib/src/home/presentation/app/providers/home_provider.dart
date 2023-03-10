// ignore_for_file: constant_identifier_names

import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:flutter/widgets.dart';

class HomeProvider extends ChangeNotifier {
  double _width = 895.5537109375;
  double _height = 387.870361328125;

  TextEditingController? _controller = TextEditingController();
  FocusNode? _focus = FocusNode();

  TextEditingController? get controller => _controller;

  FocusNode? get focus => _focus;

  double get width => _width;

  double get height => _height;

  bool viewMode = false;

  Sender? _sender;

  Sender? get sender => _sender;

  Conversation? _currentConversation;

  Conversation? get currentConversation => _currentConversation;

  bool enterTitle = true;

  String title = '';

  String hint = 'Enter Title';

  String? _editTitle;

  String? get editTitle => _editTitle;

  void setEditTitle(String conversationId) {
    _editTitle = conversationId;
    notifyListeners();
  }

  void resetEditTitle() {
    _editTitle = null;
    notifyListeners();
  }

  bool get isEnteringTitle {
    if (_controller == null) return false;
    return sender == null && _controller!.text.isNotEmpty && enterTitle;
  }

  bool get canSaveMessage {
    if (_controller == null) return false;
    return sender != null && _controller!.text.isNotEmpty;
  }

  void initializeDisposables() {
    _controller = TextEditingController();
    _focus = FocusNode();
  }

  void setState() {
    notifyListeners();
  }

  void disposeDisposables() {
    _controller?.dispose();
    _focus?.dispose();
    _controller = null;
    _focus = null;
  }

  void viewConversation(Conversation conversation) {
    _currentConversation = conversation;
    viewMode = true;
    notifyListeners();
  }

  void exitViewMode() {
    _currentConversation = null;
    viewMode = false;
    notifyListeners();
  }

  void setTitle(String title) {
    this.title = title;
    enterTitle = false;
    hint = 'Enter Message';
    resetFieldSize();
  }

  void updateSender(Sender sender) {
    _sender = sender;
    notifyListeners();
  }

  void setEnterTitle({bool listen = true}) {
    enterTitle = true;
    _width = 400;
    _height = 70;
    hint = 'Enter Title';
    if (listen) notifyListeners();
  }

  void resetSender() {
    _sender = null;
    notifyListeners();
  }

  void updateWidth(double width) {
    _width = width;
    notifyListeners();
  }

  void updateHeight(double height) {
    _height = height;
    notifyListeners();
  }

  void resetFieldSize() {
    _width = 895.5537109375;
    _height = 387.870361328125;
    notifyListeners();
  }
}

enum Sender { ME, CHATBOT }
