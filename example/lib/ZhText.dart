import 'package:flutter/material.dart';
import 'dart:ui' as ui show TextHeightBehavior, TextDirection;

import 'OpenCC.dart';

class ZhText extends StatefulWidget {
  TextStyle style;
  StrutStyle strutStyle;
  TextAlign textAlign;
  ui.TextDirection textDirection;
  Locale locale;
  bool softWrap;
  TextOverflow overflow;
  double textScaleFactor;
  int maxLines;
  String semanticsLabel;
  TextWidthBasis textWidthBasis;
  ui.TextHeightBehavior textHeightBehavior;

  String data;

  ZhText(
    this.data, {
    Key key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  _ZhTextState createState() => _ZhTextState();
}

class _ZhTextState extends State<ZhText> {
  String text = "";
  @override
  void initState() {
    _tranTxt();

    super.initState();
  }

  _tranTxt() {
    text = widget.data;

    Future(() async {
      text = await OpenCC.s2twp(widget.data);
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant ZhText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      setState(() {
        _tranTxt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaleFactor: widget.textScaleFactor,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
    );
  }
}
