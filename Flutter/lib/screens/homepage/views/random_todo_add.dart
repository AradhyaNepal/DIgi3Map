import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/view/add_domain.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class RandomTodoAdd extends StatelessWidget {
  const RandomTodoAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Random Todo',
                  style: Styles.bigHeading,
                ),
                Constants.kSmallBox,
                CustomImagePicker(imageLocation: ValueNotifier(null)),
                Constants.kVerySmallBox,
                TextFormField(
                    validator: (value){
                      if(value!.isEmpty) return "Please Enter Domain Name";
                      return null;
                    },
                    maxLength: 50,
                    decoration:Styles.getDecorationWithLable("Name")
                ),
                Constants.kVerySmallBox,
                TextFormField(
                  maxLength:1000 ,
                  maxLines: 3,
                  keyboardType:TextInputType.multiline,
                  decoration:Styles.getDecorationWithLable("Description"),
                  validator: (value){
                    if(value!.isEmpty) return "Please Enter Domain Description";
                    return null;
                  },
                ),
                Constants.kVerySmallBox,
                Text(
                  'Domain',
                  style: Styles.opacityHeadingStyle,
                ),
                Constants.kVerySmallBox,
                Row(
                  children: [
                    SelectionCollection(
                      valuesList: ['Fitness','Commander'],
                      unSelectable: true,

                      value: ValueNotifier(""),
                    ),
                    ElevatedButton(
                        style:ElevatedButton.styleFrom(
                            primary: ColorConstant.kBlueColor
                        ) ,
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AddDomain(provider: DomainProvider(),)));
                        },
                        child: const Text("Add")
                    )
                  ],
                ),

                Constants.kSmallBox,
                const Text(
                  "OR",
                  textAlign: TextAlign.center,
                  style: Styles.bigHeading,
                ),
                Text(
                  "Priority Value",
                  style: Styles.opacityHeadingStyle,
                ),

                Constants.kVerySmallBox,
                SelectionCollection(
                  valuesList: ['High','Medium','Low'],
                  unSelectable: true,

                  value: ValueNotifier(""),
                ),

                Constants.kSmallBox,
                CustomBlueButton(
                    text: "Add",
                    onPressed: (){
                      Navigator.pop(context);
                    }
                ),
                Constants.kMediumBox,

              ],
            ),
          ),
        ),
      ),
    );
  }
}

