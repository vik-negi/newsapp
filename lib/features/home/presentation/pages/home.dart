import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/features/auth/presentation/provider/auth_provider.dart';
import 'package:news/features/home/presentation/providers/news_provider.dart';
import 'package:news/resourses/r.dart';
import 'package:news/utils/ago_timestemp.dart';
import 'package:news/utils/constants.dart';
import 'package:news/utils/customShimmer.dart';
import 'package:news/utils/cw_text.dart';
import 'package:news/utils/my_widget.dart';
import 'package:news/utils/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showSelectCountryBottomSheet(
      String selectedCountry, Function(String val) onSelect) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: R.color.veryLightBlue,
      anchorPoint: const Offset(0.5, 0.5),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.5,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (context) {
        return Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: R.color.white,
          ),
          child: StatefulBuilder(builder: (context, nstate) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CWText(
                      text: "Select Country",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onSelect(Constants.countryList[index].values.first);

                          // Navigator.pop(context);
                          selectedCountry =
                              Constants.countryList[index].values.first;
                          Provider.of<NewsProvider>(context, listen: false)
                              .fetchTopHeadlines();
                          Navigator.pop(context);
                          Provider.of<LocalAuthProvider>(context, listen: false)
                              .updateUser(
                            countryCode: selectedCountry,
                          );
                          nstate(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(14, 13, 6, 13),
                          decoration: BoxDecoration(
                            color: selectedCountry ==
                                    Constants.countryList[index].values.first
                                ? R.color.lightBlue.withOpacity(0.6)
                                : R.color.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              CWText(
                                text: Constants.countryList[index].keys.first,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return selectedCountry ==
                                  Constants.countryList[index].values.first ||
                              (index > 0 &&
                                  selectedCountry ==
                                      Constants
                                          .countryList[index + 1].values.first)
                          ? const SizedBox(height: 5)
                          : const Divider(
                              height: 1,
                            );
                    },
                    itemCount: Constants.countryList.length,
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  void showSelectCategoryBottomSheet(
      String? selectCategory, Function(String val) onSelect) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: R.color.veryLightBlue,
      anchorPoint: const Offset(0.5, 0.5),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.5,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (context) {
        return Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: R.color.white,
          ),
          child: StatefulBuilder(builder: (context, nstate) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CWText(
                      text: "Select Category",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onSelect(Constants.categoryList[index]);
                          // Navigator.pop(context);
                          selectCategory = Constants.categoryList[index];
                          nstate(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(14, 13, 6, 13),
                          decoration: BoxDecoration(
                            color:
                                selectCategory == Constants.categoryList[index]
                                    ? R.color.lightBlue.withOpacity(0.6)
                                    : R.color.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              CWText(
                                text: Constants.categoryList[index],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return selectCategory == Constants.categoryList[index] ||
                              (index > 0 &&
                                  selectCategory ==
                                      Constants.countryList[index + 1])
                          ? const SizedBox(height: 5)
                          : const Divider(
                              height: 1,
                            );
                    },
                    itemCount: Constants.categoryList.length,
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  void showMoreOptionsBottomSheet(
      {Function()? onSelectLanguage,
      required Function() onSelectCountry,
      required Function() onSelectCategory}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: R.color.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              vSpacer(17),
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              vSpacer(17),
              // ListTile(
              //   onTap: onSelectLanguage,
              //   title: const CWText(
              //     text: "Select Language",
              //     fontSize: 14,
              //     fontWeight: FontWeight.w500,
              //   ),
              //   trailing: const Icon(Icons.arrow_forward_ios),
              // ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Constants.profile);
                },
                title: const CWText(
                  text: "Profile",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(
                height: 2,
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                onTap: onSelectCountry,
                title: const CWText(
                  text: "Select Country",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: onSelectCategory,
                title: const CWText(
                  text: "Select Category",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSelectLanguageBottomSheet(
      String selectedLanguage, Function(String val) onSelect) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: R.color.veryLightBlue,
      anchorPoint: const Offset(0.5, 0.5),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.5,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (context) {
        return Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: R.color.white,
          ),
          child: StatefulBuilder(builder: (context, nstate) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CWText(
                      text: "Select Language",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onSelect(Constants.languageList[index].values.first);
                          // Navigator.pop(context);
                          selectedLanguage =
                              Constants.languageList[index].values.first;
                          nstate(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(14, 13, 6, 13),
                          decoration: BoxDecoration(
                            color: selectedLanguage ==
                                    Constants.languageList[index].values.first
                                ? R.color.lightBlue.withOpacity(0.6)
                                : R.color.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              CWText(
                                text: Constants.languageList[index].keys.first,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return selectedLanguage ==
                                  Constants.languageList[index].values.first ||
                              (index > 0 &&
                                  selectedLanguage ==
                                      Constants
                                          .languageList[index + 1].values.first)
                          ? const SizedBox(height: 5)
                          : const Divider(
                              height: 1,
                            );
                    },
                    itemCount: Constants.languageList.length,
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<NewsProvider>(context, listen: false).fetchTopHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.color.veryLightBlue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CWText(
          text: "MyNews",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: R.color.white,
        ),
        backgroundColor: R.color.myBlue,
        foregroundColor: R.color.white,
        actions: [
          Consumer<NewsProvider>(builder: (context, provider, child) {
            return IconButton(
              onPressed: () => showSelectCountryBottomSheet(
                  provider.selectedCountry, (String val) {
                provider.setSelectedCountry(val);
              }),
              icon: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/location.svg",
                  ),
                  hSpacer(8),
                  CWText(
                    text: provider.selectedCountry.toUpperCase(),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: R.color.white,
                  ),
                ],
              ),
            );
          }),
          Consumer<NewsProvider>(builder: (context, provider, child) {
            return IconButton(
              onPressed: () {
                showMoreOptionsBottomSheet(onSelectLanguage: () {
                  Navigator.pop(context);
                  showSelectLanguageBottomSheet(provider.selectedLanguage,
                      (String val) {
                    provider.setSelectedLanguage(val);
                    provider.setCurrentPage(1);
                    provider.fetchTopHeadlines();
                    Navigator.pop(context);
                  });
                }, onSelectCountry: () {
                  Navigator.pop(context);
                  showSelectCountryBottomSheet(provider.selectedCountry,
                      (String val) {
                    provider.setSelectedCountry(val);
                    // provider.setCurrentPage(1);
                    // provider.fetchTopHeadlines();
                    // Provider.of<LocalAuthProvider>(context, listen: false)
                    //     .updateUser(
                    //   countryCode: val,
                    // );
                  });
                }, onSelectCategory: () {
                  Navigator.pop(context);
                  showSelectCategoryBottomSheet(provider.selectedCategory,
                      (String val) {
                    provider.setSelectedCategory(val);
                    provider.setCurrentPage(1);
                    provider.fetchTopHeadlines();
                    Navigator.pop(context);
                  });
                });
              },
              icon: Icon(
                Icons.more_vert,
                color: R.color.white,
              ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 27, 17, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CWText(
                text: "Top Headlines",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              vSpacer(15),
              Consumer<NewsProvider>(builder: (context, provider, child) {
                return Wrap(
                  children: [
                    if (provider.selectedCategory != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: R.color.myBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CWText(
                              text: provider.selectedCategory!,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            hSpacer(5),
                            InkWell(
                              onTap: () {
                                provider.setSelectedCategory(null);
                                provider.setCurrentPage(1);
                                provider.fetchTopHeadlines();
                              },
                              child: const Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }),
              Consumer<NewsProvider>(builder: (context, provider, child) {
                // if (true) {
                if (provider.isTopHeadlinesLoading) {
                  return Column(
                    children: List.generate(
                      10,
                      (index) => Container(
                        height: 150,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: R.color.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vSpacer(10),
                                  const CustomShimmer(
                                    height: 10,
                                    width: 100,
                                    radius: 10,
                                  ),
                                  vSpacer(10),
                                  const CustomShimmer(height: 10, radius: 10),
                                  vSpacer(5),
                                  const CustomShimmer(height: 10, radius: 10),
                                  vSpacer(5),
                                  const CustomShimmer(height: 10, radius: 10),
                                  vSpacer(15),
                                  const CustomShimmer(
                                    height: 5,
                                    width: 100,
                                    radius: 10,
                                  ),
                                ],
                              ),
                            ),
                            hSpacer(10),
                            const CustomShimmer(
                              height: 119,
                              width: 119,
                              radius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (provider.topHeadlines.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        vSpacer(100),
                        const CWText(
                          text: "No data found",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        String? _url = provider.topHeadlines[index].url;
                        if (_url == null) {
                          showSnackbar(context, "No url found");
                          return;
                        }
                        if (!await launchUrl(Uri.parse(_url))) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(14, 13, 6, 13),
                        decoration: BoxDecoration(
                          color: R.color.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (provider
                                          .topHeadlines[index].source?.name !=
                                      null)
                                    CWText(
                                      text: provider
                                          .topHeadlines[index]!.source!.name!,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  vSpacer(7),
                                  CWText(
                                    maxLines: 3,
                                    text: provider.topHeadlines[index].title,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  vSpacer(13),
                                  CWText(
                                      text: formatTimeAgo(provider
                                          .topHeadlines[index].publishedAt),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: R.color.lightBlue,
                                      fontStyle: FontStyle.italic),
                                ],
                              ),
                            ),
                            hSpacer(19),
                            Container(
                              height: 119,
                              width: 119,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(provider
                                          .topHeadlines[index].urlToImage ??
                                      "https://static.vecteezy.com/system/resources/thumbnails/006/299/370/original/world-breaking-news-digital-earth-hud-rotating-globe-rotating-free-video.jpg"),
                                  fit: BoxFit.cover,
                                  onError: (exception, stackTrace) {
                                    Icon(
                                      Icons.error,
                                      color: R.color.black,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  itemCount: provider.topHeadlines.length,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
