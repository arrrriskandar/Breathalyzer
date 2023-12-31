import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_breathalyzer/Components/buy_me_a_coffee_themes.dart';

/// Url to the buy me a coffee website
const String buyMeACoffeeUrl = "https://www.buymeacoffee.com/";

/// The [BuyMeACoffeeWidget] is the widget. It has a tap event and will trigger as soon someone taps it.
/// It opens up a browser window in the default browser of the device and
/// navigates to the specified UserID on Buy me a coffee.
class BuyMeACoffeeWidget extends StatelessWidget {
  /// Constructor of the BuyMeACoffee Widget
  const BuyMeACoffeeWidget({
    Key? key,
    required this.sponsorID,
    this.customText = "Buy me a coffee",
    this.textStyle,
    this.backgroundColor,
    this.theme,
  }) : super(key: key);

  /// The id for the user where it should link to.
  final String sponsorID;

  /// Custom text for the widget
  final String customText;

  /// Overwrites the textStyle of the widget
  final TextStyle? textStyle;

  /// Color of the background if none is provided the [theme] background
  /// will be used or the fallback
  final Color? backgroundColor;

  /// The theme of the widget, it changes the appearence of the Button
  ///
  /// There are multiple themes provided
  /// - [OrangeTheme]
  /// - [YellowTheme]
  /// - [BlackTheme]
  /// - [BlueTheme]
  /// - [PurpleTheme]
  /// - [WhiteTheme]
  ///
  /// Find more [BuyMeACoffeeThemeData]
  final BuyMeACoffeeThemeData? theme;

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    TextStyle? textStyle;

    if (theme == null && backgroundColor == null) {
      backgroundColor = const Color(0xFFFF813F);
    } else if (backgroundColor != null) {
      backgroundColor = backgroundColor;
    } else {
      backgroundColor = theme!.backgroundColor;
    }

    return GestureDetector(
      onTap: () async {
        final urlString = buyMeACoffeeUrl + sponsorID;
        if (await canLaunch(urlString)) {
          await launch(urlString);
        } else {
          throw "BuyMeACoffeeWidget - Something went wrong!";
        }
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 217.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
          height: 51.0,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(190, 190, 190, 0.5),
                blurRadius: 2.0,
                offset: Offset.lerp(const Offset(0, 0), const Offset(1, 1), 1)!,
              )
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.network(
                "https://cdn.buymeacoffee.com/buttons/bmc-new-btn-logo.svg",
                width: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  customText,
                  style: textStyle ??
                      TextStyle(
                        fontFamily: "Cookie",
                        color: theme == null ? Colors.white : theme!.textColor,
                        fontSize: 28.0,
                        letterSpacing: 0.6,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}