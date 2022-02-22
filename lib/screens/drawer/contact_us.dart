import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import '../../components/share.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);
  static String id = "ContactUs";

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: const Text('Contact us',style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          elevation: 0.0,
          action: Container()
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColor
            )
          ),
          child: Center
            (
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                GestureDetector(
                  onTap: (){
                    // launchEmail(context);

                    openEmail("mailto:oqbahdx@gmail.com");
                  },
                  child: const Text(
                    'oqbahdx@gmail.com',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      color: Colors.black87,),
                  ),
                ),
                const SizedBox(height: 250,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          launchFacebook('fb://profile/oqbah.dx.7',
                              'https://www.facebook.com/oqbah.dx.7');
                        },
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.black87,
                          size: 65,
                        )),
                    IconButton(
                        onPressed: () {
                          openUrl(url: 'https://github.com/oqbahdx');
                        },
                        icon:  const FaIcon(
                          FontAwesomeIcons.github,
                          color: Colors.black87,
                          size: 60,
                        )),
                    IconButton(
                        onPressed: () {
                          openUrl(url: 'https://www.linkedin.com/in/oqbah-dx-25b9951b1/');
                        },
                        icon:  const FaIcon(
                          FontAwesomeIcons.linkedin,
                          color: Colors.black87,
                          size: 60,
                        )),
                    IconButton(
                        onPressed: () {
                          launchWhatsapp(context);
                        },
                        icon:  const FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.black87,
                          size: 60,
                        )),
                  ],)
              ],
            )),
        ),
          ),
        );


  }
}
