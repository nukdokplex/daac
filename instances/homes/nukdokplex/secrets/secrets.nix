let 
  publicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILP3djnqXG8HZH5ite4kHimvxEZziUfTA7hRkaIynPg4 nukdokplex@nukdokplex.ru"
  ];
in {
  # mail
  "mail/nukdokplex-at-nukdokplex.ru.age" = { inherit publicKeys; };
  "mail/nukdokplex-at-outlook.com.age" = { inherit publicKeys; };
  "mail/vik.titoff2014-at-gmail.com.age" = { inherit publicKeys; };
  "mail/vik.titoff2014-at-yandex.ru.age" = { inherit publicKeys; };
}