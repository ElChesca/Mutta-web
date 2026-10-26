import 'package:json_annotation/json_annotation.dart';

part 'event_content.g.dart';

@JsonSerializable(explicitToJson: true)
class EventContent {
  const new({
    required this.chrome,
    required this.event,
    required this.navigation,
    required this.hero,
    required this.lineup,
    required this.tagline,
    required this.location,
    required this.faq,
    required this.footer,
  });

  factory fromJson(Map<String, dynamic> json) => _$EventContentFromJson(json);

  final ChromeContent chrome;
  final EventInfo event;
  final List<NavItem> navigation;
  final HeroContent hero;
  final LineupContent lineup;
  final TaglineContent tagline;
  final LocationContent location;
  final FaqContent faq;
  final FooterContent footer;

  Map<String, dynamic> toJson() => _$EventContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChromeContent {
  const new({
    required this.brand,
    required this.buyLabel,
    required this.profileImage,
    required this.profileAlt,
    required this.openMenuLabel,
    required this.closeMenuLabel,
  });

  factory fromJson(Map<String, dynamic> json) => _$ChromeContentFromJson(json);

  final String brand;
  final String buyLabel;
  final String profileImage;
  final String profileAlt;
  final String openMenuLabel;
  final String closeMenuLabel;

  Map<String, dynamic> toJson() => _$ChromeContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EventInfo {
  const new({
    required this.name,
    required this.edition,
    required this.startsAt,
    required this.instagramUrl,
    required this.instagramHandle,
    required this.mapsUrl,
  });

  factory fromJson(Map<String, dynamic> json) => _$EventInfoFromJson(json);

  final String name;
  final String edition;
  final DateTime startsAt;
  final String instagramUrl;
  final String instagramHandle;
  final String mapsUrl;

  Map<String, dynamic> toJson() => _$EventInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NavItem {
  const new({required this.label, required this.section});

  factory fromJson(Map<String, dynamic> json) => _$NavItemFromJson(json);

  final String label;
  final String section;

  Map<String, dynamic> toJson() => _$NavItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HeroContent {
  const new({
    required this.badge,
    required this.title,
    required this.edition,
    required this.dateLine,
    required this.venueLine,
    required this.highlightEyebrow,
    required this.highlightName,
    required this.highlightSubtitle,
    required this.highlightBadge,
    required this.quote,
    required this.description,
    required this.countdownLabel,
    required this.countdownUnits,
    required this.primaryCta,
    required this.secondaryCta,
    required this.posterImage,
    required this.posterAlt,
    required this.posterBadge,
    required this.posterLocationLabel,
    required this.posterLocation,
    required this.posterLocationDetail,
  });

  factory fromJson(Map<String, dynamic> json) => _$HeroContentFromJson(json);

  final String badge;
  final String title;
  final String edition;
  final String dateLine;
  final String venueLine;
  final String highlightEyebrow;
  final String highlightName;
  final String highlightSubtitle;
  final String highlightBadge;
  final String quote;
  final String description;
  final String countdownLabel;
  final List<String> countdownUnits;
  final String primaryCta;
  final String secondaryCta;
  final String posterImage;
  final String posterAlt;
  final String posterBadge;
  final String posterLocationLabel;
  final String posterLocation;
  final String posterLocationDetail;

  Map<String, dynamic> toJson() => _$HeroContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LineupContent {
  const new({
    required this.eyebrow,
    required this.title,
    required this.intro,
    required this.headliner,
    required this.support,
    required this.soundTitle,
    required this.soundBody,
  });

  factory fromJson(Map<String, dynamic> json) => _$LineupContentFromJson(json);

  final String eyebrow;
  final String title;
  final String intro;
  final Headliner headliner;
  final List<SupportArtist> support;
  final String soundTitle;
  final String soundBody;

  Map<String, dynamic> toJson() => _$LineupContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Headliner {
  const new({
    required this.badge,
    required this.time,
    required this.name,
    required this.tags,
    required this.bio,
    required this.image,
    required this.imageAlt,
    required this.previewTitle,
    required this.previewLive,
    required this.previewTrack,
  });

  factory fromJson(Map<String, dynamic> json) => _$HeadlinerFromJson(json);

  final String badge;
  final String time;
  final String name;
  final String tags;
  final String bio;
  final String image;
  final String imageAlt;
  final String previewTitle;
  final String previewLive;
  final String previewTrack;

  Map<String, dynamic> toJson() => _$HeadlinerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SupportArtist {
  const new({
    required this.time,
    required this.name,
    required this.style,
    required this.image,
    required this.imageAlt,
  });

  factory fromJson(Map<String, dynamic> json) => _$SupportArtistFromJson(json);

  final String time;
  final String name;
  final String style;
  final String image;
  final String imageAlt;

  Map<String, dynamic> toJson() => _$SupportArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TaglineContent {
  const new({required this.lead, required this.mark});

  factory fromJson(Map<String, dynamic> json) => _$TaglineContentFromJson(json);

  final String lead;
  final String mark;

  Map<String, dynamic> toJson() => _$TaglineContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocationContent {
  const new({
    required this.eyebrow,
    required this.title,
    required this.body,
    required this.mapImage,
    required this.mapAlt,
    required this.mapTitle,
    required this.mapSubtitle,
    required this.mapCta,
    required this.notes,
    required this.dressLabel,
    required this.dressTitle,
    required this.dressChip,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$LocationContentFromJson(json);

  final String eyebrow;
  final String title;
  final List<TextRun> body;
  final String mapImage;
  final String mapAlt;
  final String mapTitle;
  final String mapSubtitle;
  final String mapCta;
  final List<InfoNote> notes;
  final String dressLabel;
  final String dressTitle;
  final String dressChip;

  Map<String, dynamic> toJson() => _$LocationContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InfoNote {
  const new({required this.icon, required this.title, required this.body});

  factory fromJson(Map<String, dynamic> json) => _$InfoNoteFromJson(json);

  final String icon;
  final String title;
  final String body;

  Map<String, dynamic> toJson() => _$InfoNoteToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FaqContent {
  const new({
    required this.eyebrow,
    required this.title,
    required this.items,
    required this.supportTitle,
    required this.supportBody,
    required this.supportCta,
  });

  factory fromJson(Map<String, dynamic> json) => _$FaqContentFromJson(json);

  final String eyebrow;
  final String title;
  final List<FaqItem> items;
  final String supportTitle;
  final String supportBody;
  final String supportCta;

  Map<String, dynamic> toJson() => _$FaqContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FaqItem {
  const new({
    required this.id,
    required this.question,
    required this.answer,
    required this.initiallyExpanded,
  });

  factory fromJson(Map<String, dynamic> json) => _$FaqItemFromJson(json);

  final String id;
  final String question;
  final String answer;
  final bool initiallyExpanded;

  Map<String, dynamic> toJson() => _$FaqItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FooterContent {
  const new({
    required this.quote,
    required this.about,
    required this.navTitle,
    required this.newsletterTitle,
    required this.newsletterBody,
    required this.newsletterPlaceholder,
    required this.newsletterCta,
    required this.newsletterNote,
    required this.newsletterInvalid,
    required this.newsletterPending,
    required this.legal,
    required this.links,
  });

  factory fromJson(Map<String, dynamic> json) => _$FooterContentFromJson(json);

  final String quote;
  final String about;
  final String navTitle;
  final String newsletterTitle;
  final String newsletterBody;
  final String newsletterPlaceholder;
  final String newsletterCta;
  final String newsletterNote;
  final String newsletterInvalid;
  final String newsletterPending;
  final String legal;
  final List<FooterLink> links;

  Map<String, dynamic> toJson() => _$FooterContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FooterLink {
  const new({required this.label, this.section});

  factory fromJson(Map<String, dynamic> json) => _$FooterLinkFromJson(json);

  final String label;
  final String? section;

  Map<String, dynamic> toJson() => _$FooterLinkToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TextRun {
  const new({required this.text, this.emphasis});

  factory fromJson(Map<String, dynamic> json) => _$TextRunFromJson(json);

  final String text;
  final String? emphasis;

  Map<String, dynamic> toJson() => _$TextRunToJson(this);
}
