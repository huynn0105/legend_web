import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_html/flutter_html.dart' as html;
import '../global_function.dart';
import '../utils/text_util.dart';
import 'html_table_widget.dart' as html_table_widget;
import '../styles.dart';

class HtmlWidget extends StatelessWidget {
  const HtmlWidget({
    Key? key,
    required this.data,
    this.isSelectable = false,
    // this.onMarkupMentionTap,
    this.maxLines,
    this.textOverflow,
    this.textColor,
    this.mentionTextColor,
    this.fontSize,
    this.alignment,
    this.textAlign,
    this.shrinkWrap = false,
    this.lineHeight = 1.5,
  }) : super(key: key);

  const HtmlWidget.raw({
    Key? key,
    required this.data,
    this.isSelectable = false,
  })  : /*onMarkupMentionTap = null,*/
        fontSize = null,
        maxLines = null,
        textColor = null,
        mentionTextColor = null,
        textOverflow = null,
        alignment = null,
        textAlign = null,
        shrinkWrap = false,
        lineHeight = 1.5,
        super(key: key);

  final String data;
  final bool isSelectable;

  final double? fontSize;
  final int? maxLines;
  final Color? textColor;
  final Color? mentionTextColor;
  final TextOverflow? textOverflow;
  final Alignment? alignment;
  final double lineHeight;
  final TextAlign? textAlign;
  final bool shrinkWrap;
  // final Function(MarkupDataModel)? onMarkupMentionTap;

  @override
  Widget build(BuildContext context) {
    final htmlWidget = html.Html(
      data: data,
      shrinkWrap: shrinkWrap,
      onLinkTap: (url, context, attributes, element) {
        if (TextUtils.isNotEmpty(url)) {
          GlobalFunction.launchScheme(
            url!,
            mode: LaunchMode.externalApplication,
          );
        }
      },
      style: style,
      customRenders: {
        html_table_widget.tableMatcher(): html_table_widget.customTableRender(
          onLinkTap: (url, context, attributes, element) {
            if (TextUtils.isNotEmpty(url)) {
              GlobalFunction.launchScheme(
                url!,
                mode: LaunchMode.externalApplication,
              );
            }
          },
        ),
        // html.tagMatcher('span'): html.CustomRender.inlineSpan(
        //   inlineSpan: (renderContext, buildChildren) {
        //     final markupText = renderContext.tree.element?.text ?? '';
        //     final markupTextStyle = renderContext.style.generateTextStyle();
        //     final defaultTextStyle = defaultStyle.generateTextStyle();
        //     final markupPattern = MarkupUtil.validPattern;
        //     final children = <InlineSpan>[];
        //
        //     if (TextUtils.isEmpty(markupPattern)) {
        //       children.add(
        //         TextSpan(
        //           text: markupText,
        //           style: defaultTextStyle.merge(markupTextStyle),
        //         ),
        //       );
        //     } else {
        //       markupText.splitMapJoin(
        //         RegExp(markupPattern),
        //         onMatch: (Match match) {
        //           final trigger = match[2] ?? '';
        //           final markup = MarkupDataModel(
        //             id: match[4] ?? '',
        //             display: match[3] ?? '',
        //           );
        //           children.add(
        //             TextSpan(
        //               text: '$trigger${markup.display}',
        //               style: defaultTextStyle.merge(markupTextStyle).copyWith(
        //                     fontWeight: UITextStyle.bold.fontWeight,
        //                     color: mentionTextColor,
        //                   ),
        //               // recognizer: TapGestureRecognizer()
        //               //   ..onTap = () {
        //               //     if (trigger == MarkupUtil.kMentionTrigger) {
        //               //       onMarkupMentionTap?.call(markup);
        //               //     }
        //               //   },
        //             ),
        //           );
        //           return '';
        //         },
        //         onNonMatch: (String text) {
        //           children.add(
        //             TextSpan(
        //               text: text,
        //               style: defaultTextStyle.merge(markupTextStyle),
        //             ),
        //           );
        //           return '';
        //         },
        //       );
        //     }
        //
        //     return TextSpan(
        //       style: markupTextStyle.copyWith(
        //         fontSize: fontSize,
        //         height: lineHeight,
        //         fontWeight: UITextStyle.bold.fontWeight,
        //       ),
        //       children: children,
        //     );
        //   },
        // ),
        // if (markupBuilder != null)
        //   html.tagMatcher('markup'): html.CustomRender.widget(
        //     widget: (renderContext, buildChildren) {
        //       return markupBuilder!(context, renderContext.tree.element?.text ?? '');
        //     },
        //   ),
      },
    );
    if (isSelectable) {
      return SelectionArea(
        magnifierConfiguration: TextMagnifierConfiguration.disabled,
        child: htmlWidget,
      );
    }
    return htmlWidget;
  }

  BorderSide get borderSide => const BorderSide(color: Colors.black, width: 0.5);

  html.CustomRenderMatcher spanMatcher() => (context) {
        return context.tree.element?.localName == 'span';
      };

  html.Style get defaultStyle {
    return html.Style(
      margin: html.Margins.zero,
      padding: EdgeInsets.zero,
      lineHeight: html.LineHeight.number(lineHeight),
      fontFamily: UITextStyle.regular.fontFamily,
      fontSize: fontSize == null ? null : html.FontSize(fontSize!),
      maxLines: maxLines,
      textOverflow: textOverflow,
      color: textColor,
      alignment: alignment,
      textAlign: textAlign,
    );
  }

  Map<String, html.Style> get style {
    return {
      "*": defaultStyle,
      "table": html.Style(
        height: html.Height.auto(),
        width: html.Width.auto(),
      ),
      "tr": html.Style(
        height: html.Height.auto(),
        width: html.Width.auto(),
      ),
      "th": html.Style(
        height: html.Height.auto(),
        border: Border(
          left: borderSide,
          bottom: borderSide,
          top: borderSide,
        ),
      ),
      "td": html.Style(
        height: html.Height.auto(),
        border: Border(
          left: borderSide,
          bottom: borderSide,
          top: borderSide,
          right: borderSide,
        ),
      ),
      "col": html.Style(
        height: html.Height.auto(),
        width: html.Width.auto(),
      ),
      "img": html.Style(
        height: html.Height.auto(),
        width: html.Width.auto(),
      ),
    };
  }
}
