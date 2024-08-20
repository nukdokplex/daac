let
  hostPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaI1J1wi4HhDvfp+glq29fEFCBq4jKSmyGe4FUbBWTX"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkbZqq3rGEtfP1sv8VkEfe4tvGRKnhutXCBkz3W39vBMbELPHKEBw0A6pcUrAiV3gcvRI5eeLfZfZFrAhvbVyyUjMKLG6UQGo0d72T3VGMkcaWFYNPtSU7oJvspbath6fTUuwG5S4By9lhX682pECVDFxA3BGKIkHzQw6nxzEPeT6qMk7gSXowGvwZj4OVa5+KNWOhrM3tRvSPQMgQp4GQ2n++h8syx9OdHJV1DhPxPENWHAYyiMIJe6fVNKsAlZpGMM4r0N3ncuoqok9ljOrtpyF1mOviprV1nd5r6UleR0DNIxDgwOuJ5X2vGLeQegA+pZZuCoIRkcYGZDmVQIrfYmaui+JPNeUdqgAFYKoHWUc8dUaMGuH2LPKrfJ6oFxTGpt5U3AnpVF/Ck22Y0Ibmgjl3iCpwEd3r4ysxbBYapttKkVK2cHKayrG6ahMmioLEJNwmFqrAG2YlH55byw4q1/MHw9rkiz7/9fxAqk8AMhgeZ9lG4me09/DVApZGpxd/vTVkKjS4Ce5El3ugrtOpJPUs7pqVybTValoCO0/Xh982+pTE2AamhmrLlUctRrn2h4uUiZPt6N02/hSfH8mzbvz2mj7Qquu1seS/p1aydD3hz3px14QuoVnCgqqXq4i3kNeQd6/WTe+Mq2I+aSkQnniR1ABsKEOdx/v6jJTqsQ=="
  ];
in {
  "secureboot/db/db.key.age".publicKeys = hostPublicKeys;
  "secureboot/db/db.pem.age".publicKeys = hostPublicKeys;
  "secureboot/KEK/KEK.key.age".publicKeys = hostPublicKeys;
  "secureboot/KEK/KEK.pem.age".publicKeys = hostPublicKeys;
  "secureboot/PK/PK.key.age".publicKeys = hostPublicKeys;
  "secureboot/PK/PK.pem.age".publicKeys = hostPublicKeys;
  "wifi_passwords.age".publicKeys = hostPublicKeys;
}