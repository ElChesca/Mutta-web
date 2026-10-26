import 'package:json_annotation/json_annotation.dart';

part 'event_content.g.dart';

@JsonSerializable(explicitToJson: true)
class EventContent {
  const new({
    required this.chrome,
    required this.event,
    required this.navigation,
    required this.hero,
    required this.passes,
    required this.lineup,
    required this.experience,
    required this.location,
    required this.faq,
    required this.footer,
  });

  factory fromJson(Map<String, dynamic> json) => _$EventContentFromJson(json);

  final ChromeContent chrome;
  final EventInfo event;
  final List<NavItem> navigation;
  final HeroContent hero;
  final PassesContent passes;
  final LineupContent lineup;
  final ExperienceContent experience;
  final LocationContent location;
  final FaqContent faq;
  final FooterContent footer;

  Map<String, dynamic> toJson() => _$EventContentToJson(this);

  PassTier passById(String id) {
    return passes.tiers.firstWhere((tier) => tier.id == id);
  }
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
class PassesContent {
  const new({
    required this.eyebrow,
    required this.title,
    required this.intro,
    required this.checkout,
    required this.tiers,
  });

  factory fromJson(Map<String, dynamic> json) => _$PassesContentFromJson(json);

  final String eyebrow;
  final String title;
  final String intro;
  final CheckoutCopy checkout;
  final List<PassTier> tiers;

  Map<String, dynamic> toJson() => _$PassesContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CheckoutCopy {
  const new({
    required this.selectionLabel,
    required this.totalLabel,
    required this.payLabel,
    required this.summaryTemplate,
    required this.minQuantity,
    required this.maxQuantity,
    required this.initialPassId,
  });

  factory fromJson(Map<String, dynamic> json) => _$CheckoutCopyFromJson(json);

  final String selectionLabel;
  final String totalLabel;
  final String payLabel;
  final String summaryTemplate;
  final int minQuantity;
  final int maxQuantity;
  final String initialPassId;

  Map<String, dynamic> toJson() => _$CheckoutCopyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PassTier {
  const new({
    required this.id,
    required this.name,
    required this.description,
    required this.priceArs,
    required this.priceSuffix,
    required this.includes,
    required this.cta,
    required this.footnote,
    required this.featured,
    required this.badgeLeft,
    this.badgeRight,
    this.badgeRightTone,
    this.ribbon,
    this.defaultSummary,
  });

  factory fromJson(Map<String, dynamic> json) => _$PassTierFromJson(json);

  final String id;
  final String name;
  final String description;
  final int priceArs;
  final String priceSuffix;
  final List<String> includes;
  final String cta;
  final String footnote;
  final bool featured;
  final String badgeLeft;
  final String? badgeRight;
  final String? badgeRightTone;
  final String? ribbon;
  final String? defaultSummary;

  Map<String, dynamic> toJson() => _$PassTierToJson(this);
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
class ExperienceContent {
  const new({
    required this.eyebrow,
    required this.title,
    required this.intro,
    required this.isotipo,
    required this.pillars,
    required this.wristband,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$ExperienceContentFromJson(json);

  final String eyebrow;
  final String title;
  final String intro;
  final IsotipoContent isotipo;
  final List<Pillar> pillars;
  final WristbandContent wristband;

  Map<String, dynamic> toJson() => _$ExperienceContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IsotipoContent {
  const new({
    required this.badge,
    required this.monochromeLabel,
    required this.sunsetLabel,
    required this.eyebrow,
    required this.title,
    required this.body,
    required this.points,
  });

  factory fromJson(Map<String, dynamic> json) => _$IsotipoContentFromJson(json);

  final String badge;
  final String monochromeLabel;
  final String sunsetLabel;
  final String eyebrow;
  final String title;
  final List<TextRun> body;
  final List<IsotipoPoint> points;

  Map<String, dynamic> toJson() => _$IsotipoContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IsotipoPoint {
  const new({required this.title, required this.body, required this.icon});

  factory fromJson(Map<String, dynamic> json) => _$IsotipoPointFromJson(json);

  final String title;
  final String body;
  final String icon;

  Map<String, dynamic> toJson() => _$IsotipoPointToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pillar {
  const new({required this.icon, required this.title, required this.body});

  factory fromJson(Map<String, dynamic> json) => _$PillarFromJson(json);

  final String icon;
  final String title;
  final String body;

  Map<String, dynamic> toJson() => _$PillarToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WristbandContent {
  const new({
    required this.eyebrow,
    required this.title,
    required this.body,
    required this.brand,
    required this.meta,
    required this.note,
    required this.official,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$WristbandContentFromJson(json);

  final String eyebrow;
  final String title;
  final List<TextRun> body;
  final String brand;
  final String meta;
  final String note;
  final String official;

  Map<String, dynamic> toJson() => _$WristbandContentToJson(this);
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
