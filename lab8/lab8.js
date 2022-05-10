// 12. Рейсы, пассажиры, билеты.

db = connect("localhost:27017/lab08");
db.createCollection("flight");
db.flight.remove({});


// 3.1 Отобразить коллекции базы данных
print("Отобразить коллекции базы данных");
print(db.getCollectionNames());


// 3.2 Вставка записей

// Вставка одной записи insertOne
db.flight.insertOne({
  start_date: "2022-01-02",
  end_date: "2022-01-03",
  price: 300,
  plane: {
    title: "Kathra'natir",
    capacity: 100,
    fuel_consumption: 3000,
    adoptionDate: "2015-11-24"
  },
  passengers: [
    {
      first_name: "Whitney",
      last_name: "Houston",
      birth_date: "1963-08-09",
      ssn: "132-22-5706",
      ticket: {
        purchase_date: "2021-12-20",
        price_multiplier: 1.5,
        class: "business"
      },
      bags: [
        {
          mass: 2,
          isChecked: false,
          isCarryOn: true,
          color: "blue"
        }
      ]
    }
  ]
});

// Вставка нескольких записей insertMany
db.flight.insertMany([
  {
    start_date: "2022-02-02",
    end_date: "2022-02-04",
    price: 300,
    plane: {
      title: "Bigfernal",
      capacity: 120,
      fuel_consumption: 3500,
      adoptionDate: "2013-09-19"
    },
    passengers: [
      {
        first_name: "Violent",
        last_name: "J",
        birth_date: "1975-12-14",
        ssn: "132-22-5756",
        ticket: {
          purchase_date: "2022-01-03",
          price_multiplier: 1,
          class: "econom"
        },
        bags: []
      }
    ]
  },
  {
    start_date: "2022-05-04",
    end_date: "2022-05-07",
    price: 150,
    plane: {
      title: "Insatiable Ur'zul",
      capacity: 50,
      adoptionDate: "1997-07-05"
    },
    passengers: [
      {
        first_name: "Whitney",
        last_name: "Houston",
        birth_date: "1963-08-09",
        ssn: "132-22-5706",
        ticket: {
          purchase_date: "2021-12-20",
          price_multiplier: 1.5,
          class: "business"
        },
        bags: []
      },
      {
        first_name: "Imp",
        last_name: "Mama",
        birth_date: "1955-06-11",
        ssn: "162-21-5706",
        ticket: {
          purchase_date: "2022-01-05",
          price_multiplier: 1.5,
          class: "business"
        },
        bags: [
          {
            mass: 4,
            isChecked: true,
            isCarryOn: false,
            color: "green"
          }
        ]
      }
    ]
  }
]);


// 3.3 Удаление записей

// Удаление одной записи по условию deleteOne
// db.flight.deleteOne({ end_date: "2022-05-07" });

// Удаление нескольких записей по условию deleteMany
// db.flight.deleteMany({ price: 300 });


// 3.4 Поиск записей

// Поиск по ID
print("Поиск по ID");
printjson(db.flight.findOne({ _id: ObjectId("62795d12a79c32d43db05da1") }));

// Поиск записи по атрибуту первого уровня
print("Поиск записи по атрибуту первого уровня");
printjson(db.flight.findOne({ price: 150 }));

// Поиск записи по вложенному атрибуту
print("Поиск записи по вложенному атрибуту");
printjson(db.flight.findOne({ "plane.title": "Kathra'natir" }));

// Поиск записи по нескольким атрибутам (логический оператор AND)
print("Поиск записи по нескольким атрибутам (логический оператор AND)");
printjson(db.flight.findOne({
  "$and": [
    { "plane.title": "Kathra'natir" },
    { start_date: "2022-01-02" }
  ]
}));

// Поиск записи по одному из условий (логический оператор OR)
print("Поиск записи по одному из условий (логический оператор OR)");
printjson(db.flight.findOne({
  "$or": [
    { "plane.title": "Insatiable Ur'zul" },
    { price: 300 }
  ]
}));

// Поиск с использованием оператора сравнения
print("Поиск с использованием оператора сравнения");
db.flight.find({
  price: { "$gt": 200 }
}).forEach(printjson);

// Поиск с использованием двух операторов сравнения
print("Поиск с использованием двух операторов сравнения");
db.flight.find({
  price: { "$gt": 100, "$lt": 350 }
}).forEach(printjson);

// Поиск по значению в массиве
print("Поиск по значению в массиве");
db.flight.find({
  passengers: {
    "$elemMatch": {
      first_name: "Whitney"
    }
  }
}).forEach(printjson);

// Поиск по количеству элементов в массиве
print("Поиск по количеству элементов в массиве");
db.flight.find({
  passengers: { "$size": 2 }
}).forEach(printjson);

// Поиск записей без атрибута
print("Поиск записей без атрибута");
db.flight.find({
  "plane.fuel_consumption": { "$exists": false }
}).forEach(printjson);


// 3.5 Обновление записей

// Изменить значение атрибута у записи
db.flight.updateOne(
  { "plane.title": "Kathra'natir" },
  { "$set": { price: 280 } }
);

// Удалить атрибут у записи
db.flight.updateOne(
  { end_date: "2022-02-04" },
  { "$unset": { "plane.fuel_consumption": 0 } }
);

// Добавить атрибут записи
db.flight.updateMany(
  {},
  { "$set": { "plane.isAwesome": true } }
);
