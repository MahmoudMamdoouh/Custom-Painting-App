import 'dart:convert';

import 'package:custom_paint/app/modules/home/widgets/points_model.dart';
import 'package:custom_paint/app/savedData/file_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  //!================================ Properties ===============================
  PageController pageController = PageController();

  final groub =
      <RxList<GroupPoints>>[<GroupPoints>[].obs, <GroupPoints>[].obs].obs;

  /// the list of Offsets that goes to the CustomPainter
  // final offsets = <Offset>[].obs;

  final _paintingName = <String>[].obs;

  final _savedPaintingsKeys = <String>[].obs;

  ///  to change font colors in the home view
  final _fontColor = const Color(0xff5e85e8).obs;

  ///  to change font colors in the home view
  final _backgrounColor = const Color(0xff44464a).obs;

  ///  to change font size in the home view
  final _fontSize = 3.0.obs;

  ///  index of every SET of moves made in the big [Offsets] list
  ///  takes the index of the single offsets to use it in the undo later
  final _evreyGroupOfOffsets = <List<int>>[];

  ///  put every [_evreyGroupOfOffsets] in it to use it later in the undo
  final _allGroupOfOffsets = <List<List<int>>>[];

  ///  takes every undo list of offsets to use it in the redo
  final _redoList = <List<GroupPoints>>[];

  final _pageViewPadding = 0.0.obs;

  final _isPageViewOpen = false.obs;

  final _isRubberUsed = false.obs;

  final _numberOfPageView = 1.obs;

  final _currentPageIndex = 0.obs;

  //!===========================================================================
  //!============================ Getters/Setters ==============================

  Color get fontColor => _fontColor.value;
  set fontColor(Color newValue) => _fontColor(newValue);

  List<String> get paintingName => _paintingName;
  set paintingName(List<String> newValue) => _paintingName(newValue);

  List<String> get savedPaintingsKeys => _savedPaintingsKeys;
  set savedPaintingsKeys(List<String> newValue) =>
      _savedPaintingsKeys(newValue);

  Color get backgrounColor => _backgrounColor.value;
  set backgrounColor(Color newValue) => _backgrounColor(newValue);

  double get fontSize => _fontSize.value;
  set fontSize(double newValue) => _fontSize(newValue);

  int get numberOfPageView => _numberOfPageView.value;
  set numberOfPageView(int newValue) => _numberOfPageView(newValue);

  int get currentPageIndex => _currentPageIndex.value;
  set currentPageIndex(int newValue) => _currentPageIndex(newValue);

  double get pageViewPadding => _pageViewPadding.value;
  set pageViewPadding(double newValue) => _pageViewPadding(newValue);

  bool get isRubberUsed => _isRubberUsed.value;
  set isRubberUsed(bool newValue) => _isRubberUsed(newValue);

  bool get isPageViewOpen => _isPageViewOpen.value;
  set isPageViewOpen(bool newValue) => _isPageViewOpen(newValue);

  //!===========================================================================
  //!============================ Functions ====================================

  //?=============== DrawCustomPainter ======================
  void creatList(
    Offset values,
  ) {
    // clear the list every time user start to paint
    _evreyGroupOfOffsets.clear();
    for (var i = 0; i < currentPageIndex + 1; i++) {
      _evreyGroupOfOffsets.add([]);
    }
    groub[currentPageIndex].add(GroupPoints(
        size: fontSize,
        offsetX: values.dx,
        offsetY: values.dy,
        color: fontColor));

    // add the offset index to list
    _evreyGroupOfOffsets[currentPageIndex].add(groub[currentPageIndex].length);
  }

  void updateList(
    Offset values,
  ) {
    // add the Offset to the list to paint
    groub[currentPageIndex].add(GroupPoints(
        size: fontSize,
        offsetX: values.dx,
        offsetY: values.dy,
        color: fontColor));
    // add the offset index to list
    _evreyGroupOfOffsets[currentPageIndex].add(groub[currentPageIndex].length);
  }

  void addList() {
    // add the Offset.zero to have space between every line
    groub[currentPageIndex].add(GroupPoints(
        size: fontSize, offsetX: 0.0, offsetY: 0.0, color: fontColor));
    for (var i = 0; _allGroupOfOffsets.length < currentPageIndex + 1; i++) {
      _allGroupOfOffsets.add([]);
    }
    // add the offset index to list
    _evreyGroupOfOffsets[currentPageIndex].add(groub[currentPageIndex].length);

    // tempList to save the value of [ _evreyGroupOfOffsets ]
    // in a new list to make it not another allias
    List<List<int>> tempList = List.from(_evreyGroupOfOffsets);
    // add the set of index in biger list
    _allGroupOfOffsets[currentPageIndex].add(tempList[currentPageIndex]);
  }

//?========================================================
  //?=============== RubberCustomPainter ======================

  void reomvePoints(
    Offset values,
  ) {
    //! the best solution
    groub[currentPageIndex].add(GroupPoints(
        offsetX: values.dx,
        offsetY: values.dy - 83,
        color: Colors.transparent,
        size: 20));

    //! the worst solution
    // var temp = groub.indexWhere((element) {
    //   return (element.offset.dx <= (values.dx + 2) &&
    //           element.offset.dx >= (values.dx - 2)) &&
    //       (element.offset.dy <= ((values.dy - 83) + 2) &&
    //           element.offset.dy >= ((values.dy - 83) - 2));
    // });

    // if (temp == -1) return;
    // groub.removeAt(temp);
    // groub.insert(temp,
    //     GroupPoints(offset: Offset.zero, color: fontColor, size: fontSize));
  }

//?========================================================

//*============================================
//*============================================

//?===================== clear ============================
  void clear() {
    if (_redoList.isNotEmpty && _redoList.length >= currentPageIndex) {
      _redoList[currentPageIndex].clear();
    }
    if (_allGroupOfOffsets.length >= currentPageIndex) {
      _allGroupOfOffsets[currentPageIndex].clear();
    }
    _redoList.add(groub[currentPageIndex].toList());
    groub[currentPageIndex].clear();
  }
//?========================================================

//*============================================
//*============================================

//?===================== undo =============================
  void undo() {
    // if the _allGroupOfOffsets is emty then there is nothing to delete

//*=================================
// tempList to have the values of Offsets the going to be deleted
//to if the user wanted to redo after
    if (_allGroupOfOffsets.length > currentPageIndex) {
      if (_allGroupOfOffsets[currentPageIndex].isEmpty) return;
      var tempList = <GroupPoints>[];
      for (var int in _allGroupOfOffsets[currentPageIndex].last) {
        tempList.add(groub[currentPageIndex].elementAt(int - 1));
      }
      _redoList.add(tempList);
    } else {
      if (groub.length > currentPageIndex) {
        groub.removeAt(currentPageIndex);
      }
      return;
    }
//*=================================

    // remove offsets of the last move
    groub[currentPageIndex].removeRange(
        _allGroupOfOffsets[currentPageIndex].last.first - 1,
        _allGroupOfOffsets[currentPageIndex].last.last);
    // remove index of offsets we allredy deleted

    _allGroupOfOffsets[currentPageIndex].removeLast();
  }
//?========================================================

//*======================================
//*======================================

//?===================== Redo =============================
  void redo() {
    // if the redo list is emty then user cant redo
    if (_redoList.isEmpty) return;
    if (_redoList[currentPageIndex].isEmpty) return;
//*==================================
    // pint every Offsets user needs to redo in the last move deleted
    // be sure that [_evreyGroupOfOffsets] is clear
    // to add the last painted (the rePainted)
    _evreyGroupOfOffsets.clear();
    for (var i = 0; i < currentPageIndex + 1; i++) {
      _evreyGroupOfOffsets.add([]);
    }
    for (var item in _redoList.last) {
      // add the Offset
      // offsets.add(item);
      groub[currentPageIndex].add(item);

      // add there index if the userwanted to undo later
      _evreyGroupOfOffsets[currentPageIndex]
          .add(groub[currentPageIndex].length);
    }

    // tempList to save the value of [ _evreyGroupOfOffsets ]
    // in a new list to make it not another allias
    List<int> tempList = List.from(_evreyGroupOfOffsets[currentPageIndex]);
    // add the set of index in biger list
    _allGroupOfOffsets[currentPageIndex].add(tempList);
//*==================================

    // remove it from the list
    _redoList.removeLast();
  }

//?========================================================
//?========================================================
//=================== SAVE PAINTING =======================

  void savePainting(String paintingName) async {
    var mm = <GroupOffsetss>[];
    for (var item in groub[currentPageIndex]) {
      mm.add(GroupOffsetss(
        offsetX: item.offsetX,
        offsetY: item.offsetY,
        size: item.size,
        color: item.color.value,
      ));
    }

    final paintings = Drawings(id: paintingName, groupOffsetss: mm);
    final encoded = jsonEncode(paintings);

    SharedPreferences savePainting = await SharedPreferences.getInstance();
    savePainting.setString(paintingName, encoded);
  }

//?========================================================
//?========================================================
  void getSavedPaintingsName() async {
    SharedPreferences savedPainting = await SharedPreferences.getInstance();
    savedPaintingsKeys = savedPainting.getKeys().toList();
  }
//?========================================================
//?========================================================

  Future<void> applyPainting(String paintingNameKey) async {
    addAnotherPainting();
    SharedPreferences applyyPainting = await SharedPreferences.getInstance();
    var encodedData = applyyPainting.getString(paintingNameKey);
    var decodedData = jsonDecode(encodedData!);
    for (var item in decodedData['painting']) {
      groub[currentPageIndex + 1].add(GroupPoints(
          offsetX: item['offsetX'],
          offsetY: item['offsetY'],
          color: Color(item['color']),
          size: item['size']));
    }
  }

//?========================================================
//?========================================================

  void addAnotherPainting() async {
    groub.add(<GroupPoints>[].obs);
    isPageViewOpen = true;
    await Future.delayed(const Duration(seconds: 1));
    numberOfPageView++;
    pageController.animateToPage(numberOfPageView - 1,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    await Future.delayed(const Duration(seconds: 1));
    isPageViewOpen = false;
  }

  void openPages() {
    isPageViewOpen = true;
  }
}
