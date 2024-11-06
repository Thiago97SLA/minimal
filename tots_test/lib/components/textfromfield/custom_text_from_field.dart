import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tots_test/utils/custom_font_style.dart';
import 'package:tots_test/utils/palette.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.controller,
    this.text,
    this.prefixImage,
    this.validator,
    this.onSaved,
    this.onEditingComplete,
    this.autofocus = false,
    this.maxLength,
    this.onChange,
    this.margin,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    super.key,
    this.isEnabled = true,
    this.focusNode,
    this.helperText,
    this.maxLines = 1,
    this.customFormatters = const [],
    this.hintText,
    this.subtitle,
    this.iconSuffix,
    this.iconPreffix,
    this.mandatory = false,
    this.textAlign = TextAlign.start,
    this.isPassword = false,
    this.withBorder = false,
  });

  final bool isEnabled;
  final bool obscureText;
  final EdgeInsetsGeometry? margin;
  final FocusNode? focusNode;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter> customFormatters;
  final String? text;
  final TextAlign textAlign;
  final bool autofocus;
  final String? helperText;
  final String? prefixImage;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;
  final String? subtitle;
  final IconData? iconSuffix;
  final IconData? iconPreffix;
  final bool mandatory;
  final bool isPassword;
  final bool withBorder;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  List<TextInputFormatter> inputFormatters = <TextInputFormatter>[];

  bool isobscureText = true;

  @override
  void initState() {
    if (widget.textInputType == TextInputType.number) {
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    }
    if (widget.maxLength != null) {
      inputFormatters = [
        ...inputFormatters,
        LengthLimitingTextInputFormatter(widget.maxLength)
      ];
    }
    if (widget.customFormatters.isNotEmpty) {
      inputFormatters = [...inputFormatters, ...widget.customFormatters];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.subtitle != null) ...[
          Row(
            children: [
              Text(
                widget.subtitle!,
                textAlign: TextAlign.left,
                style:
                    FontConstants.body2.copyWith(color: Palette.current.black),
              ),
              if (widget.mandatory)
                Text(
                  ' *',
                  textAlign: TextAlign.left,
                  style: FontConstants.body2.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Palette.current.errorDark),
                ),
            ],
          ),
          const SizedBox(height: 5),
        ],
        Container(
          margin: widget.margin,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  if (widget.prefixImage != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: Image.asset(widget.prefixImage!,
                          width: 25, height: 25),
                    ),
                  TextFormField(
                    textAlign: widget.textAlign,
                    obscureText:
                        widget.isPassword ? isobscureText : widget.obscureText,
                    keyboardType: widget.textInputType,
                    onEditingComplete: widget.onEditingComplete,
                    onSaved: widget.onSaved,
                    onChanged: widget.onChange,
                    autofocus: widget.autofocus,
                    inputFormatters: inputFormatters,
                    autocorrect:
                        widget.textInputType != TextInputType.emailAddress,
                    focusNode: widget.focusNode,
                    maxLines: widget.maxLines,
                    enabled: widget.isEnabled,
                    style: FontConstants.body2
                        .copyWith(color: Palette.current.black),
                    decoration: InputDecoration(
                      border: widget.withBorder
                          ? const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            )
                          : null,
                      labelText: widget.text,
                      fillColor: Palette.current.black,
                      hintText: widget.hintText,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: FontConstants.body2
                          .copyWith(color: Palette.current.black),
                      focusColor: Palette.current.black,
                      suffixIcon: widget.iconSuffix != null
                          ? Icon(widget.iconSuffix)
                          : null,
                      prefixIcon: widget.iconPreffix != null
                          ? Icon(widget.iconPreffix)
                          : null,
                      contentPadding: widget.prefixImage != null
                          ? const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 40,
                              right: 20,
                            )
                          : const EdgeInsets.all(16),
                    ),
                    controller: widget.controller,
                    validator: widget.validator,
                  ),
                  if (widget.isPassword)
                    Positioned(
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isobscureText = !isobscureText;
                            });
                          },
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Palette.current.grey,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (widget.helperText != null)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: double.infinity,
                  child: Text(
                    widget.helperText!,
                    key: Key('helperText: ${widget.helperText}'),
                    style: FontConstants.subCaption1
                        .copyWith(color: Palette.current.black),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
