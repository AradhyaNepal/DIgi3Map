import 'dart:io';

import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final ValueNotifier<String?> imageLocation;
  final ValueNotifier<bool>? imageSelected;
  final bool fromServer;

  const CustomImagePicker({
    required this.imageLocation,
    this.imageSelected,
    this.fromServer=false,
    Key? key
  }):super(key: key);

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  late final ImagePicker _imagePicker;
  bool _useFirst=false;
  @override
  void initState() {
    super.initState();
    _imagePicker=ImagePicker();
    _useFirst=widget.imageLocation.value!=null;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 125,
        width: 125,
        child: GestureDetector(
          onTap: openImagePicker,
          child: widget.imageLocation.value!=null?
              _useFirst?
              widget.fromServer?
              Image.network(
                Service.baseApiNoDash+widget.imageLocation.value!,
                fit: BoxFit.fill,
              ):
              Image.asset(
                  widget.imageLocation.value!,
                fit: BoxFit.fill,
              ):
              Image.file(
                File(widget.imageLocation.value!),
                fit: BoxFit.fill,

              )
              :Image.asset(
              AssetsLocation.selectImageLocation,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void openImagePicker() async{
    final pickedImage= await _imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      setState(() {
        _useFirst=false;
        if(widget.imageSelected!=null){
          widget.imageSelected!.value=true;
        }
        widget.imageLocation.value=pickedImage.path;
      });
    }

  }
}
