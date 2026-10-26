import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/core/icons/mutta_icons.dart';
import 'package:mutta_web/core/layout/app_breakpoint.dart';
import 'package:mutta_web/core/layout/content_frame.dart';
import 'package:mutta_web/core/theme/mutta_theme.dart';
import 'package:mutta_web/core/widgets/brand_text.dart';
import 'package:mutta_web/core/widgets/mutta_button.dart';
import 'package:mutta_web/core/widgets/mutta_mark.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/features/landing/logic/newsletter.dart';

class SiteFooter extends ConsumerStatefulWidget {
  const new({
    required this.footer,
    required this.instagramHandle,
    required this.navigation,
    required this.lockup,
    required this.onNavigate,
    required this.onInstagram,
    super.key,
  });

  final FooterContent footer;
  final String instagramHandle;
  final List<NavItem> navigation;
  final String lockup;
  final ValueChanged<String> onNavigate;
  final VoidCallback onInstagram;

  @override
  ConsumerState<SiteFooter> createState() => _SiteFooterState();
}

class _SiteFooterState extends ConsumerState<SiteFooter> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final footer = widget.footer;
    final newsletter = ref.watch(newsletterProvider);
    final message = switch (newsletter.status) {
      NewsletterStatus.invalid => footer.newsletterInvalid,
      NewsletterStatus.pendingIntegration => footer.newsletterPending,
      NewsletterStatus.idle => null,
    };
    return ColoredBox(
      color: tokens.surfaceSection,
      child: ContentFrame(
        child: Padding(
          padding: EdgeInsets.only(
            top: tokens.spacing.xxl,
            bottom: tokens.spacing.xl,
          ),
          child: Column(
            children: [
              Responsive(
                builder: (context, breakpoint) {
                  final brand = _BrandColumn(
                    footer: footer,
                    handle: widget.instagramHandle,
                    lockup: widget.lockup,
                    onInstagram: widget.onInstagram,
                  );
                  final nav = _NavColumn(
                    title: footer.navTitle,
                    items: widget.navigation,
                    onNavigate: widget.onNavigate,
                  );
                  final news = _NewsColumn(
                    footer: footer,
                    controller: _email,
                    message: message,
                    onSubmit: () {
                      ref.read(newsletterProvider.notifier).submit(_email.text);
                    },
                  );
                  if (breakpoint == AppBreakpoint.mobile) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        brand,
                        SizedBox(height: tokens.spacing.xl),
                        nav,
                        SizedBox(height: tokens.spacing.xl),
                        news,
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: brand),
                      Expanded(flex: 3, child: nav),
                      Expanded(flex: 4, child: news),
                    ],
                  );
                },
              ),
              SizedBox(height: tokens.spacing.xxl),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colors.surfaceContainer.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: tokens.spacing.lg),
                  child: Responsive(
                    builder: (context, breakpoint) {
                      final legal = BrandText(
                        footer.legal,
                        role: BrandRole.labelSm,
                        color: colors.onSurfaceVariant,
                      );
                      final links = Wrap(
                        spacing: tokens.spacing.lg,
                        children: [
                          for (final link in footer.links)
                            TextButton(
                              onPressed: () {
                                final section = link.section;
                                if (section == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'TODO: esta página todavía '
                                        'no está publicada.',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                widget.onNavigate(section);
                              },
                              child: BrandText(
                                link.label,
                                role: BrandRole.labelSm,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                        ],
                      );
                      if (breakpoint == AppBreakpoint.mobile) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            legal,
                            SizedBox(height: tokens.spacing.md),
                            links,
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Expanded(child: legal),
                          links,
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandColumn extends StatelessWidget {
  const new({
    required this.footer,
    required this.handle,
    required this.lockup,
    required this.onInstagram,
  });

  final FooterContent footer;
  final String handle;
  final String lockup;
  final VoidCallback onInstagram;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MuttaLockup(height: tokens.metrics.wordmarkHeight, tagline: lockup),
        SizedBox(height: tokens.spacing.md),
        Text(
          footer.quote,
          style: context.texts.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: tokens.spacing.md),
        BrandText(
          footer.about,
          role: BrandRole.bodySm,
          color: colors.onSurfaceVariant,
        ),
        SizedBox(height: tokens.spacing.md),
        TextButton.icon(
          onPressed: onInstagram,
          icon: Icon(muttaIcon('photo_camera'), color: colors.onSurfaceVariant),
          label: BrandText(
            handle,
            role: BrandRole.labelMd,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _NavColumn extends StatelessWidget {
  const new({
    required this.title,
    required this.items,
    required this.onNavigate,
  });

  final String title;
  final List<NavItem> items;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandText(title, role: BrandRole.labelLg),
        for (final item in items)
          TextButton(
            onPressed: () => onNavigate(item.section),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              foregroundColor: colors.onSurfaceVariant,
            ),
            child: BrandText(
              item.label,
              role: BrandRole.bodyMd,
              color: colors.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

class _NewsColumn extends StatelessWidget {
  const new({
    required this.footer,
    required this.controller,
    required this.message,
    required this.onSubmit,
  });

  final FooterContent footer;
  final TextEditingController controller;
  final String? message;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = context.colors;
    final note = message;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandText(footer.newsletterTitle, role: BrandRole.labelLg),
        SizedBox(height: tokens.spacing.md),
        BrandText(
          footer.newsletterBody,
          role: BrandRole.bodySm,
          color: colors.onSurfaceVariant,
        ),
        SizedBox(height: tokens.spacing.md),
        Responsive(
          builder: (context, breakpoint) {
            final field = TextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.email],
              style: context.texts.bodySmall?.copyWith(color: colors.onSurface),
              decoration: InputDecoration(
                hintText: footer.newsletterPlaceholder,
              ),
              onSubmitted: (_) => onSubmit(),
            );
            final button = MuttaButton(
              label: footer.newsletterCta,
              onPressed: onSubmit,
            );
            if (breakpoint == AppBreakpoint.mobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  field,
                  SizedBox(height: tokens.spacing.sm),
                  button,
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: field),
                SizedBox(width: tokens.spacing.sm),
                button,
              ],
            );
          },
        ),
        SizedBox(height: tokens.spacing.sm),
        BrandText(
          footer.newsletterNote,
          role: BrandRole.labelSm,
          color: colors.outline,
        ),
        if (note != null) ...[
          SizedBox(height: tokens.spacing.sm),
          BrandText(note, role: BrandRole.bodySm, color: colors.primary),
        ],
      ],
    );
  }
}
