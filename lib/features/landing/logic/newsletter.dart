import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NewsletterStatus { idle, invalid, pendingIntegration }

class NewsletterState {
  const new({required this.status, required this.email});

  const new idle() : status = NewsletterStatus.idle, email = '';

  final NewsletterStatus status;
  final String email;
}

class NewsletterNotifier extends Notifier<NewsletterState> {
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  NewsletterState build() => const NewsletterState.idle();

  void submit(String email) {
    final trimmed = email.trim();
    if (!_emailPattern.hasMatch(trimmed)) {
      state = NewsletterState(status: NewsletterStatus.invalid, email: trimmed);
      return;
    }
    // TODO(mutta): conectar con el servicio de newsletter.
    state = NewsletterState(
      status: NewsletterStatus.pendingIntegration,
      email: trimmed,
    );
  }
}

final newsletterProvider =
    NotifierProvider<NewsletterNotifier, NewsletterState>(
      NewsletterNotifier.new,
    );
