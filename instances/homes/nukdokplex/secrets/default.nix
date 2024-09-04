{ config, ... }: {
  age = {
    secrets = {
      "nukdokplex@nukdokplex.ru".file = ./mail/. + "/nukdokplex-at-nukdokplex.ru.age";
      "nukdokplex@outlook.com".file = ./mail/. + "/nukdokplex-at-outlook.com.age";
      "vik.titoff2014@gmail.com".file = ./mail/. + "/vik.titoff2014-at-gmail.com.age";
      "vik.titoff2014@yandex.ru".file = ./mail/. + "/vik.titoff2014-at-yandex.ru.age";
    };
  };
}
