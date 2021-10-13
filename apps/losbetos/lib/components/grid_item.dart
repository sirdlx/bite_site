import 'package:flutter/material.dart';
import 'package:losbetosapp/components/hero_image.dart';

class BiteGridItem extends StatelessWidget {
  final String? subtitle;

  final String? title;

  final ImageProvider? image;

  final void Function()? onPressed;

  final Key? heroKey;

  const BiteGridItem({
    Key? key,
    this.subtitle,
    this.title,
    this.image,
    this.onPressed,
    this.heroKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('image::$image ');

    if (image == null) {
      return buildBody(context);
    }

    return buildBody(
        context,
        Padding(
          padding: const EdgeInsets.all(.3),
          child: HeroImage(image: image!),
        ));
  }

  Container buildBody(BuildContext context, [Widget? child]) {
    return Container(
      // height: 200,
      // width: 200 * 1.6,
      // color: Colors.red,
      // clipBehavior: Clip.antiAlias,
      // decoration: BoxDecoration(),
      // padding: EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        // style: ButtonStyle(
        //   // elevation: MaterialStateProperty.resolveWith((states) => 1),
        //   backgroundColor: MaterialStateProperty.all(
        //     Colors.transparent,
        //   ),
        //   padding: MaterialStateProperty.resolveWith(
        //     (states) => EdgeInsets.all(0),
        //   ),
        // ),
        // onPressed: onPressed,
        child: GestureDetector(
          onTap: onPressed,
          child: GridTile(
            child: child ??
                Container(
                  color: Colors.red,
                  height: double.infinity,
                  width: double.infinity,
                ),
            // header: Container(
            //   padding: EdgeInsets.all(8),
            //   // height: 16,
            //   // color: Colors.amber,
            //   child: title != null ? Text(title!) : null,
            // ),
            footer: Material(
              // color: child != null
              //     ? Theme.of(context).canvasColor.withOpacity(.3)
              //     :
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(0),
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       child: title != null
                //           ? Text(
                //               title!,
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //             )
                //           : null,
                //     ),
                //     Row(
                //       children: [
                //         Container(
                //           child: subtitle != null
                //               ? Text(
                //                   subtitle!,
                //                   style: Theme.of(context).textTheme.caption,
                //                 )
                //               : null,
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                child: ListTile(
                  tileColor: Theme.of(context).canvasColor.withOpacity(.3),
                  // contentPadding: EdgeInsets.all(0),
                  subtitle: subtitle != null ? Text(subtitle!) : null,
                  title: title != null
                      ? Text(
                          title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                ),
              ),
              // child: ListTile(
              //   // tileColor:
              //   //     // Theme.of(context).brightness == Brightness.light
              //   //     // ?
              //   //     Colors.white
              //   // // : null
              //   // ,
              //   contentPadding: EdgeInsets.all(4),
              //   subtitle: subtitle != null ? Text(subtitle!) : null,
              //   title: title != null ? Text(title!) : null,

              //   // leading: IconButton(
              //   //   onPressed: () {},
              //   //   icon: Icon(
              //   //     Icons.add_shopping_cart_outlined,
              //   //   ),
              //   // ),
              // ),
            ),
            // child: Hero(
            //   tag: ValueKey(image.hashCode),
            //   // child: Container(
            //   //   decoration: BoxDecoration(
            //   //     image: image != null
            //   //         ? DecorationImage(image: image!, fit: BoxFit.cover)
            //   //         : null,
            //   //   ),
            //   // ),
            //   child: image != null
            //       ? Image(image: image!, fit: BoxFit.cover)
            //       : Container(),
            // ),
            // child: Container(
            //   color: Colors.amber,
            //   child: image != null
            //       ?
            //       // Hero(
            //       //     tag: ValueKey(image.hashCode),
            //       //     child:

            //       Image(
            //           image: image!,
            //           // fit: BoxFit.cover,
            //         )
            //       // ,
            //       // )
            //       : Container(),
            // ),
            // child: image != null
            //     ? HeroImage(
            //         image: image!,
            //       )
            //     // : Container(
            //     //     decoration: BoxDecoration(
            //     //       image: DecorationImage(
            //     //         image: image!,
            //     //         fit: BoxFit.cover,
            //     //       ),
            //     //     ),
            //     //   )
            //     : Container(),
          ),
        ),
      ),
    );
  }
}
