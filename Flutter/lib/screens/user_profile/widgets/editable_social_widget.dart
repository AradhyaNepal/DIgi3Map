
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/SocialModel.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class EditableSocialWidget extends StatefulWidget {
  const EditableSocialWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<EditableSocialWidget> createState() => _EditableSocialWidgetState();
}

class _EditableSocialWidgetState extends State<EditableSocialWidget> {
  final List<SocialModel> socialsWidgetList=[];
  final TextEditingController platformController=TextEditingController();
  final TextEditingController usernameController=TextEditingController();
  @override
  void initState() {
    super.initState();
    socialsWidgetList.add(
        SocialModel(
            platform: "Instagram",
            username: "anonymoussssssoul"
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Other Socials (Max 5)",
          style: Styles.opacityHeadingStyle,
        ),
        Constants.kVerySmallBox,
        for(int i=0;i<socialsWidgetList.length;i++)
          Row(
            children: [
              Expanded(
                  child: SelectableText(
                    socialsWidgetList[i].platform,
                    style: Styles.smallHeading,
                  )
              ),
              SizedBox(width: 5,),
              Expanded(
                  child: SelectableText(
                      socialsWidgetList[i].username
                  )
              ),

              SizedBox(width: 5,),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      socialsWidgetList.removeAt(i);
                    });
                  },
                  child: Text("Remove"),
                ),
              )
            ],
          ),
        Constants.kVerySmallBox,

        socialsWidgetList.length>=5?SizedBox():Row(
          children: [
            Expanded(
                child: TextField(
                  controller: platformController,
                  decoration: InputDecoration(
                      hintText: "Platform"
                  ),
                )
            ),
            SizedBox(width: 5,),
            Expanded(
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: "Username"
                  ),
                )
            ),

            SizedBox(width: 5,),
            Expanded(
              child: ElevatedButton(
                onPressed: (){
                  if(!platformController.text.isEmpty && !usernameController.text.isEmpty){
                    socialsWidgetList.add(
                        SocialModel(
                            platform: platformController.text,
                            username: usernameController.text
                        )
                    );
                    platformController.clear();
                    usernameController.clear();
                    setState(() {

                    });
                  }


                },
                child: Text("Add"),
              ),
            )
          ],
        )
      ],
    );
  }
}
