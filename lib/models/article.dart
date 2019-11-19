import 'package:flutter/material.dart';

class Article {
  final String title;
  final String imagePath;
  final String description;
  final String time;
  final String author;

  Article({
    this.title,
    this.imagePath,
    this.description,
    this.time,
    this.author,
  });
}

List articles = [
  Article(
      title: "Nu kör vi!!",
      imagePath:
          "https://lh3.googleusercontent.com/LynHYBvMrs7kgjLW2B62KgcRjulvVPQl7wNqvK5eMf-nkR6Q7GpjqI_XLMygglCy6bzZZto48J-C4EUjHkPTAWANjGdmH-jP7S-MH7VU5rM3LD6nc_FUnYkT3m6lpOlFIu1HlCdd8OdOhWzjLkBYvUPrv1tXZvtaoK7LiVGdxuVcaLBhoIvg88COKQ0sLfC9nVtA0jM6JWuIW3lvEvO1q262tRpLyTiO6Ri8hwUHylVmJ51vB-seqjRVfWpO5lWeFvEaarS5_OhTytt9UtfuKF_AOfRKNUi3_90i71CLJCHO9GWVkNS9FluSo9nj6bu6WKydtBOiPuO_-kPjOv8pCDtcWcASeo9F8BUOyI5IT9503AnVuKITYKDaxLM8qUe29xJDVy99EC7aboD29NQmUkGVA7uC9MsxlNvEh_tj7bl4UEXH3_ticxJnhGnrfvUIH2YXrzFdRILc_ivUB1P8rgLyam_bk2gViFCPVJPik2Uyd8_HO-PkAINWbJAUE9Izrb80_bJNh2x24MymzRHSS6Iy8Dk1sBOBFC9CXwITZ3RV2e61SGKlNmXOD8eGLpJqVKZKhnV-KRFBNlAe8d0pfnm0zoniYz9r-qz5HMQbGnSc2vKHdhub2yoRZbPCZ4y1bk4EjCzvy4ZEO7uJUKErmcIxclHfzWt6U5lRG4W6nSNZuMIyz2KAd-eIecED4w=w2880-h1642",
      description:
          "Bacon ipsum dolor amet short ribs brisket venison rump drumstick pig sausage prosciutto chicken spare ribs salami picanha doner. Kevin capicola sausage, buffalo bresaola venison turkey shoulder picanha ham pork tri-tip meatball meatloaf ribeye. Doner spare ribs andouille bacon sausage. Ground round jerky brisket pastrami shank.",
      time: "Idag",
      author: "Thomas Indrias"),
  Article(
      title: "Pre-MTD!!",
      imagePath:
          "https://lh3.googleusercontent.com/LynHYBvMrs7kgjLW2B62KgcRjulvVPQl7wNqvK5eMf-nkR6Q7GpjqI_XLMygglCy6bzZZto48J-C4EUjHkPTAWANjGdmH-jP7S-MH7VU5rM3LD6nc_FUnYkT3m6lpOlFIu1HlCdd8OdOhWzjLkBYvUPrv1tXZvtaoK7LiVGdxuVcaLBhoIvg88COKQ0sLfC9nVtA0jM6JWuIW3lvEvO1q262tRpLyTiO6Ri8hwUHylVmJ51vB-seqjRVfWpO5lWeFvEaarS5_OhTytt9UtfuKF_AOfRKNUi3_90i71CLJCHO9GWVkNS9FluSo9nj6bu6WKydtBOiPuO_-kPjOv8pCDtcWcASeo9F8BUOyI5IT9503AnVuKITYKDaxLM8qUe29xJDVy99EC7aboD29NQmUkGVA7uC9MsxlNvEh_tj7bl4UEXH3_ticxJnhGnrfvUIH2YXrzFdRILc_ivUB1P8rgLyam_bk2gViFCPVJPik2Uyd8_HO-PkAINWbJAUE9Izrb80_bJNh2x24MymzRHSS6Iy8Dk1sBOBFC9CXwITZ3RV2e61SGKlNmXOD8eGLpJqVKZKhnV-KRFBNlAe8d0pfnm0zoniYz9r-qz5HMQbGnSc2vKHdhub2yoRZbPCZ4y1bk4EjCzvy4ZEO7uJUKErmcIxclHfzWt6U5lRG4W6nSNZuMIyz2KAd-eIecED4w=w2880-h1642",
      description:
          "Hodor. Hodor hodor, hodor. Hodor hodor hodor hodor hodor. Hodor. Hodor! Hodor hodor, hodor; hodor hodor hodor. Hodor. Hodor hodor; hodor hodor - hodor, hodor, hodor hodor. Hodor, hodor. Hodor. Hodor, hodor hodor hodor; hodor hodor; hodor hodor hodor! Hodor hodor HODOR! Hodor hodor... Hodor hodor hodor...",
      time: "Igår 16.20",
      author: "Thomas Indrias"),
  Article(
      title: "En vecka kvar...",
      imagePath:
          "https://lh3.googleusercontent.com/LynHYBvMrs7kgjLW2B62KgcRjulvVPQl7wNqvK5eMf-nkR6Q7GpjqI_XLMygglCy6bzZZto48J-C4EUjHkPTAWANjGdmH-jP7S-MH7VU5rM3LD6nc_FUnYkT3m6lpOlFIu1HlCdd8OdOhWzjLkBYvUPrv1tXZvtaoK7LiVGdxuVcaLBhoIvg88COKQ0sLfC9nVtA0jM6JWuIW3lvEvO1q262tRpLyTiO6Ri8hwUHylVmJ51vB-seqjRVfWpO5lWeFvEaarS5_OhTytt9UtfuKF_AOfRKNUi3_90i71CLJCHO9GWVkNS9FluSo9nj6bu6WKydtBOiPuO_-kPjOv8pCDtcWcASeo9F8BUOyI5IT9503AnVuKITYKDaxLM8qUe29xJDVy99EC7aboD29NQmUkGVA7uC9MsxlNvEh_tj7bl4UEXH3_ticxJnhGnrfvUIH2YXrzFdRILc_ivUB1P8rgLyam_bk2gViFCPVJPik2Uyd8_HO-PkAINWbJAUE9Izrb80_bJNh2x24MymzRHSS6Iy8Dk1sBOBFC9CXwITZ3RV2e61SGKlNmXOD8eGLpJqVKZKhnV-KRFBNlAe8d0pfnm0zoniYz9r-qz5HMQbGnSc2vKHdhub2yoRZbPCZ4y1bk4EjCzvy4ZEO7uJUKErmcIxclHfzWt6U5lRG4W6nSNZuMIyz2KAd-eIecED4w=w2880-h1642",
      description:
          "Nori grape silver beet broccoli kombu beet greens fava bean potato quandong celery. Bunya nuts black-eyed pea prairie turnip leek lentil turnip greens parsnip. Sea lettuce lettuce water chestnut eggplant winter purslane fennel azuki bean earthnut pea sierra leone bologi leek soko chicory celtuce parsley jícama salsify.",
      time: "27 Feb, 14.02",
      author: "Thomas Indrias"),
];
