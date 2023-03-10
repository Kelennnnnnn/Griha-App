import 'package:griha/app/models/item_model.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

@override
class HouseCard extends StatefulWidget {
  const HouseCard(this.item, this.onTap, {super.key});
  final Item item;
  final Function()? onTap;

  @override
  State<HouseCard> createState() => _HouseCardState();
}

class _HouseCardState extends State<HouseCard> {
  CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 152,
                child: CarouselSlider.builder(
                  itemCount: widget.item.images.length,
                  itemBuilder: ((context, index, realIndex) {
                    return Container(
                        width: double.infinity,
                        height: 165,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                          image: DecorationImage(
                            image: AssetImage(widget.item.images[index]),
                            fit: BoxFit.cover,
                          ),
                        ));
                  }),
                  options: CarouselOptions(
                    scrollPhysics: BouncingScrollPhysics(),
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    onPageChanged: (index, reason) {},
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.item.category!,
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.item.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  Text(
                    widget.item.location!,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.item.price}/ Month",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: ,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
