enum RouteNames {
  // Navigation
  home('home', '/home'),
  cart('cart', '/cart'),
  orders('orders', '/orders'),
  profile('profile', '/profile'),
  product('product', '/product/:id'),
  requestQuote('requestQuote', '/request-quote'),

  // Authentication
  login('login', '/login'),
  codeVerification('codeVerification', '/codeVerification'),
  completeInfo('completeInfo', '/completeInfo'),
  editInfo('editInfo', '/editInfo');

  final String name, path;

  const RouteNames(this.name, this.path);
}
