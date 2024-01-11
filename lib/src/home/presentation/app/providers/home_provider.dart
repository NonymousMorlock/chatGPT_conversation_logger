// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:conversation_log/core/extensions/date_extensions.dart';
import 'package:conversation_log/core/utils/constants.dart';
import 'package:conversation_log/core/utils/functions.dart';
import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/data/models/exported_conversation_model.dart';
import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:conversation_log/src/home/domain/entities/exported_conversation.dart';
import 'package:conversation_log/src/home/domain/entities/user_filled_conversation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(this._prefs) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getConversations();
    });
    _searchController.addListener(() {
      _search(_searchController.text);
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });
  }

  final SharedPreferences _prefs;

  late Timer timer;

  ViewType _viewType = ViewType.EXPORTED;

  ViewType get viewType => _viewType;

  double _width = 895.5537109375;
  double _height = 387.870361328125;

  bool _initializing = true;

  bool get initializing => _initializing;

  TextEditingController? _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  FocusNode? _focus = FocusNode();

  List<UserFilledConversation> _conversations = [];
  List<ExportedConversation> _exportedConversations = [];

  List<UserFilledConversation> _searchResults = [];
  List<ExportedConversation> _exportedSearchResults = [];

  List<UserFilledConversation> get conversations => _searchResults;

  List<ExportedConversation> get exportedConversations =>
      _exportedSearchResults;

  TextEditingController? get controller => _controller;

  TextEditingController get searchController => _searchController;

  DateTime? _lastPickedDate;

  DateTime? get lastPickedDate => _lastPickedDate;

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

  String _hint = 'Enter Title';

  String get hint => _hint;

  String? _editTitle;

  String? get editTitle => _editTitle;

  void setEditTitle(String conversationId) {
    _editTitle = conversationId;
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
  }

  set lastPickedDate(DateTime? date) {
    if (_lastPickedDate != date) {
      _lastPickedDate = date;
      notifyListeners();
    }
  }

  set viewType(ViewType type) {
    if (type == ViewType.EXPORTED && _exportedConversations.isEmpty) {
      showPlatformDialog(
        windowTitle: 'No Conversation Found',
        text: 'You have not imported any conversation yet.',
        noNegativeButton: true,
        positiveButtonTitle: 'Ok',
      );
      return;
    }
    if (_viewType != type) {
      _viewType = type;
      notifyListeners();
    }
  }

  Future<void> saveConversations() async {
    if (_exportedConversations.isEmpty) {
      await showPlatformDialog(
        windowTitle: 'No conversation found',
        text: 'You have not imported any conversation yet.',
        noNegativeButton: true,
        positiveButtonTitle: 'Ok',
      );
      return;
    }
    await _prefs.setStringList(
      kConversationStoreKey,
      _exportedConversations
          .map((e) => (e as ExportedConversationModel).toJson())
          .toList(),
    );
    await showPlatformDialog(
      windowTitle: 'Saved',
      text: 'Your conversations have been saved successfully.',
      noNegativeButton: true,
      positiveButtonTitle: 'Ok',
    );
  }

  Future<void> _getConversations() async {
    final conversations = _prefs.getStringList(kConversationStoreKey);
    if (conversations != null) {
      _exportedConversations =
          conversations.map(ExportedConversationModel.fromJson).toList();
      _exportedSearchResults = _exportedConversations;
      _initializing = false;
      notifyListeners();
    } else {
      await _initFromStorageIfExists('Initializing...');
      if (_exportedConversations.isEmpty) _viewType = ViewType.USER_FILLED;
    }
  }

  Future<void> _initFromStorageIfExists(String? message) async {
    // root/database/storage/conversations.json
    final file =
        File('${Directory.current.path}/database/storage/conversations.json');
    setConversationsFromFile(file);
  }

  void setConversationsFromFile(File file) {
    _initializing = true;
    notifyListeners();
    if (file.existsSync()) {
      final data = List<DataMap>.from(
        jsonDecode(file.readAsStringSync()) as List<dynamic>,
      );
      _exportedConversations =
          data.map(ExportedConversationModel.fromMap).toList();
      _exportedSearchResults = _exportedConversations;
    }
    _initializing = false;
    _viewType = ViewType.EXPORTED;
    notifyListeners();
  }

  set conversations(List<UserFilledConversation> conversations) {
    _conversations = conversations;
    _searchResults = conversations;
    notifyListeners();
  }

  void _search(String query) {
    if (query.isEmpty) {
      _searchResults = _conversations;
      _exportedSearchResults = _exportedConversations;
    } else {
      if (_viewType == ViewType.USER_FILLED) {
        _searchResults = _conversations
            .where(
              (conversation) =>
                  conversation.title
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  (conversation.message
                          ?.toLowerCase()
                          .contains(query.toLowerCase()) ??
                      false),
            )
            .toList();
      } else {
        _exportedSearchResults = _exportedConversations
            .where(
              (conversation) =>
                  conversation.title
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  (conversation.messages
                      .map(
                        (message) => message.content
                            .toLowerCase()
                            .contains(query.toLowerCase()),
                      )
                      .contains(true)),
            )
            .toList();
      }
    }
    notifyListeners();
  }

  bool searchByDate(DateTime date) {
    _lastPickedDate = date;
    _searchController.text = date.plainDate;
    if (viewType == ViewType.EXPORTED) {
      _exportedSearchResults = _exportedConversations
          .where(
            (conversation) =>
                (conversation.timeCreated.day == date.day ||
                    conversation.lastUpdateTime.day == date.day) &&
                (conversation.timeCreated.month == date.month ||
                    conversation.lastUpdateTime.month == date.month) &&
                (conversation.timeCreated.year == date.year ||
                    conversation.lastUpdateTime.year == date.year),
          )
          .toList();
      if (_exportedSearchResults.isEmpty) {
        _exportedSearchResults = _exportedConversations;
        notifyListeners();
        return false;
      }
    } else {
      _searchResults = _conversations
          .where(
            (conversation) =>
                (conversation.createdDate.day == date.day ||
                    conversation.modifiedDate.day == date.day) &&
                (conversation.createdDate.month == date.month ||
                    conversation.modifiedDate.month == date.month) &&
                (conversation.createdDate.year == date.year ||
                    conversation.modifiedDate.year == date.year),
          )
          .toList();

      if (_searchResults.isEmpty) {
        _searchResults = _conversations;
        notifyListeners();
        return false;
      }
    }
    notifyListeners();
    return true;
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
    return _sender != null && _controller!.text.isNotEmpty;
  }

  void resetInputs() {
    _controller?.clear();
    _sender = null;
    notifyListeners();
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
    _hint = 'Enter Message';
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
    _hint = 'Enter Title';
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

  @override
  void dispose() {
    _controller?.dispose();
    _focus?.dispose();
    timer.cancel();
    _searchController.dispose();
    super.dispose();
  }
}

enum Sender { ME, CHATBOT }

enum ViewType { EXPORTED, USER_FILLED }
