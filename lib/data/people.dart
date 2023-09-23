class Person {
  final String name;
  final String phone;
  final String picture;
  const Person(this.name, this.phone, this.picture);
}

final List<Person> people = _people
    .map((e) => Person(
        e['name'] as String, e['phone'] as String, e['picture'] as String))
    .toList(growable: false);

final List<Map<String, Object>> _people = [
  {
    "_id": "6508678f0175952c4e3c267a",
    "index": 0,
    "guid": "7e17ac29-aeac-40fd-8a1c-cf49c2015aa9",
    "isActive": true,
    "balance": "\$3,619.87",
    "picture": "http://placehold.it/32x32",
    "age": 27,
    "eyeColor": "brown",
    "name": "Shepard Vaughn",
    "gender": "male",
    "company": "VIRXO",
    "email": "shepardvaughn@virxo.com",
    "phone": "+1 (973) 456-3882",
    "address": "185 Knapp Street, Dixonville, District Of Columbia, 1298",
    "about":
        "Deserunt deserunt do deserunt aliquip dolor velit labore. Laboris non veniam est commodo dolore proident ullamco. Aute ipsum ea nostrud culpa proident quis qui laborum voluptate nulla esse veniam eu. Reprehenderit ullamco pariatur ad sunt officia occaecat qui. Consectetur Lorem deserunt elit occaecat in proident. Anim laboris labore mollit officia culpa ea minim minim.\r\n",
    "registered": "2016-09-19T02:58:54 -07:00",
    "latitude": -3.230526,
    "longitude": 79.922255,
    "tags": [
      "Lorem",
      "aliqua",
      "proident",
      "elit",
      "consectetur",
      "sit",
      "tempor"
    ],
    "friends": [
      {"id": 0, "name": "Gill Hart"},
      {"id": 1, "name": "Debra Small"},
      {"id": 2, "name": "Willis Wilder"}
    ],
    "greeting": "Hello, Shepard Vaughn! You have 10 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6508678f892b0e142fc70d0f",
    "index": 1,
    "guid": "f90eecba-a480-4120-82f9-80cf83364da1",
    "isActive": false,
    "balance": "\$3,153.05",
    "picture": "http://placehold.it/32x32",
    "age": 30,
    "eyeColor": "blue",
    "name": "Patton Cardenas",
    "gender": "male",
    "company": "BEDLAM",
    "email": "pattoncardenas@bedlam.com",
    "phone": "+1 (821) 426-2268",
    "address": "747 Oriental Court, Berwind, Connecticut, 7520",
    "about":
        "Veniam laboris reprehenderit esse incididunt velit aute cillum. Aliquip ipsum sunt Lorem quis enim magna magna ad aute consequat pariatur deserunt velit. Nostrud est exercitation eiusmod qui ullamco officia aute sit excepteur ipsum fugiat do anim excepteur. Quis deserunt amet eu eu consectetur duis anim. Officia eiusmod veniam ex sunt ad in do velit veniam ex ea excepteur. Ullamco ut irure laborum sunt nulla aute aliquip occaecat quis veniam sit.\r\n",
    "registered": "2020-11-17T07:56:03 -07:00",
    "latitude": -44.910755,
    "longitude": -157.458593,
    "tags": ["ut", "nostrud", "ea", "non", "anim", "do", "magna"],
    "friends": [
      {"id": 0, "name": "Moreno Combs"},
      {"id": 1, "name": "Violet Thornton"},
      {"id": 2, "name": "Foster Fox"}
    ],
    "greeting": "Hello, Patton Cardenas! You have 2 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6508678f3f3364f818acf778",
    "index": 2,
    "guid": "ab7455a5-36f5-4d92-9a83-14da7483890e",
    "isActive": false,
    "balance": "\$3,964.35",
    "picture": "http://placehold.it/32x32",
    "age": 24,
    "eyeColor": "brown",
    "name": "Wolf Beach",
    "gender": "male",
    "company": "ZILLACTIC",
    "email": "wolfbeach@zillactic.com",
    "phone": "+1 (943) 436-2421",
    "address": "740 Llama Court, Reno, Maine, 9096",
    "about":
        "Eiusmod consequat exercitation voluptate et quis. Veniam qui velit eu fugiat dolor laboris enim cillum. Laborum ipsum cillum laborum exercitation. Laboris commodo laborum sint magna ad aliqua duis. Occaecat mollit dolore consequat sit sit eu eu velit duis officia nisi cupidatat ipsum. Irure officia ullamco quis nostrud ullamco enim est sit est. Aliqua voluptate elit nisi ut duis laborum aliqua aliquip ullamco culpa.\r\n",
    "registered": "2020-07-13T03:48:17 -07:00",
    "latitude": -37.11313,
    "longitude": -62.886786,
    "tags": ["est", "nulla", "elit", "sit", "et", "laboris", "commodo"],
    "friends": [
      {"id": 0, "name": "Marcy Huff"},
      {"id": 1, "name": "Bridgette Vega"},
      {"id": 2, "name": "Beatriz Randolph"}
    ],
    "greeting": "Hello, Wolf Beach! You have 10 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6508678ff9281c634e87aabc",
    "index": 3,
    "guid": "7ccdd6cd-8780-41e8-8bde-45990a9a2063",
    "isActive": true,
    "balance": "\$3,556.17",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "green",
    "name": "Sandy Pennington",
    "gender": "female",
    "company": "ANIXANG",
    "email": "sandypennington@anixang.com",
    "phone": "+1 (856) 489-2877",
    "address": "561 Chester Street, Bergoo, Wisconsin, 1214",
    "about":
        "Excepteur enim eiusmod quis quis ad do ipsum reprehenderit laborum et ut amet enim eiusmod. Ex do ipsum sit proident cillum ut incididunt fugiat in adipisicing in commodo irure enim. Ea exercitation deserunt ut elit fugiat est fugiat Lorem velit fugiat magna laborum et id. Eu tempor excepteur laborum Lorem irure ea consequat veniam amet. Ut et duis anim occaecat laborum consequat sit nisi est ullamco cillum.\r\n",
    "registered": "2017-10-04T10:09:50 -07:00",
    "latitude": -50.395613,
    "longitude": -63.731345,
    "tags": ["ut", "duis", "amet", "velit", "et", "ea", "laboris"],
    "friends": [
      {"id": 0, "name": "Alston Fitzpatrick"},
      {"id": 1, "name": "Noble Obrien"},
      {"id": 2, "name": "Patricia Ewing"}
    ],
    "greeting": "Hello, Sandy Pennington! You have 3 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "6508678fe25bb86f1fb1568f",
    "index": 4,
    "guid": "795ca89e-3881-4d92-8db3-f4d971bda732",
    "isActive": false,
    "balance": "\$2,233.56",
    "picture": "http://placehold.it/32x32",
    "age": 23,
    "eyeColor": "blue",
    "name": "Dillon Downs",
    "gender": "male",
    "company": "CABLAM",
    "email": "dillondowns@cablam.com",
    "phone": "+1 (891) 447-2870",
    "address": "655 Boerum Place, Belvoir, Nebraska, 3013",
    "about":
        "Enim aliqua irure magna et pariatur ipsum veniam elit commodo officia et magna anim sunt. Tempor excepteur enim minim esse magna sint quis. Officia do mollit cillum ad ullamco commodo officia tempor. Sunt Lorem incididunt do ullamco velit aliqua nostrud commodo velit aute sit exercitation. Pariatur voluptate eiusmod adipisicing ipsum.\r\n",
    "registered": "2020-04-03T10:12:11 -07:00",
    "latitude": -50.99523,
    "longitude": 36.1718,
    "tags": ["occaecat", "pariatur", "officia", "ad", "ut", "anim", "dolor"],
    "friends": [
      {"id": 0, "name": "Cherry Franks"},
      {"id": 1, "name": "Stark Foster"},
      {"id": 2, "name": "Wood Hancock"}
    ],
    "greeting": "Hello, Dillon Downs! You have 9 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "6508678f05e5e98c5015e7db",
    "index": 5,
    "guid": "f29882e5-c42c-4e92-a308-80d90929b4cb",
    "isActive": true,
    "balance": "\$3,694.76",
    "picture": "http://placehold.it/32x32",
    "age": 30,
    "eyeColor": "brown",
    "name": "Ford Foley",
    "gender": "male",
    "company": "INTERFIND",
    "email": "fordfoley@interfind.com",
    "phone": "+1 (817) 582-3621",
    "address": "892 Leonora Court, Tooleville, Arkansas, 1883",
    "about":
        "Eiusmod cupidatat irure reprehenderit velit deserunt magna reprehenderit laborum ea. Commodo irure fugiat consectetur est enim. Amet aliquip incididunt adipisicing laboris consequat aute consequat in sint aliqua tempor ad fugiat excepteur. Cupidatat ea nisi sint labore do.\r\n",
    "registered": "2019-06-06T11:46:52 -07:00",
    "latitude": 36.128412,
    "longitude": -20.010726,
    "tags": [
      "velit",
      "Lorem",
      "ad",
      "consectetur",
      "ullamco",
      "incididunt",
      "aute"
    ],
    "friends": [
      {"id": 0, "name": "Douglas Cummings"},
      {"id": 1, "name": "Randolph Estrada"},
      {"id": 2, "name": "Hope Carlson"}
    ],
    "greeting": "Hello, Ford Foley! You have 9 unread messages.",
    "favoriteFruit": "strawberry"
  }
];
