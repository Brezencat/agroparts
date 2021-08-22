//// -- LEVEL 1
//// -- Tables and References

// Creating tables
Table TRANSPORT as T { //техника
  id int [pk, increment, not null] // auto-increment
  name nvarchar(255) [not null, note: 'название техники']
  type nvarchar(255) [null, note: 'тип техники']
  group nvarchar(255) [null, note: 'группа техники']
  is_del bit [not null, default: 0]//признак выведенной позиции
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
}

Table PARTS as P { //запчасти
  id int [pk, increment, not null] // barcode???
  name nvarchar(255) [not null]//название
  code nvarchar(255) [not null, default: '-1']//каталожный номер
  price decimal(10,2) [not null, default: 0.0]//цена
  image binary [null]//изображение запчасти
  is_del bit [not null, default: 0]//признак выведенной позиции
  status tinyint [not null]//, default: 1]//выводим или нет, ещё что-нибудь
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
}

Table TRANSPORT_PARTS as TP {
  id int [increment, not null]
  transpotr_id int [not null, ref: > T.id]
  parts_id int [not null, ref: > P.id]
  is_del bit [not null, default: 0]//признак выведенной позиции
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
}

Table WAREHOUSE as W {
  id int [increment, not null]
  parts_id int [not null, ref: > P.id]
  quantity int [not null]
  status int [not null]//default: ... //в наличии, списано (если недосчитались)
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
}

Table MERCHANT as M { //партнёры, откуда привозишь запчасти
  id int [pk, increment, not null] //внутренний номер
  name nvarchar(255) [not null]//название продавца
  location_id int [not null, ref: > L.id]
  description nvarchar(2000) [null]
  is_del bit [not null, default: 0]
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
}

Table CUSTOMER as C {
  id int [increment, not null]
  name nvarchar(255) [not null]
  location_id int [not null, ref: > L.id]
  description nvarchar(2000) [null]
  is_del bit [not null, default: 0]
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
}

Table LOCATION as L {
  id int [pk, increment, not null]
  postal_code int [null]
  city nvarchar(255) [not null]
  region nvarchar(255) [null]
  country nvarchar(255) [null]
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
 }

Table ORDERS as O {
  id int [pk, increment, not null]
  name nvarchar(255) [null]
  description nvarchar(4000) [null]
  //customer_id int [ref: > C.id]
  //merchan_id int [ref: > M.id]
  client_id int [not null, ref: > M.id, ref: > C.id]
  type orders_type [not null]//buy (покупка) или salling (продажа)[]
  status tinyint [not null] //статус заказа
  is_del bit [not null, default: 0]
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
}

Table ORDER_ITEMS as OI {
  id int [increment, not null]
  order_id int [not null, ref: > O.id]
  warehouse_id int [not null, ref: > W.id]
  status int [not null] //in_stock (в наличии), in transit (в пути), out of stock (отсутсвует, распродано), to order (заказать) 
  is_del bit [not null, default: 0]
  create_date timestamp [not null, default: 'getdate()']
  change_date timestamp [not null, default: 'getdate()']
}
//вынести статусы в отдельную табличку
//идентификатор, наименование, где используется
//таблица связи техники и запчастей
//таблица с количеством запчастей
//таблица с продуктами, запчасти, которые купили у поставщиков и по какой цене.


// Creating references
// You can also define relaionship separately
// > many-to-one; < one-to-many; - one-to-one
//Ref: T.country_code > countries.code  
//Ref: merchants.country_code > countries.code


//// -- Level 3 
//// -- Enum, Indexes

// Enum for 'orders' table
Enum orders_type {
  buy
  salling
}

//----------------------------------------------//

//// -- LEVEL 2
//// -- Adding column settings

//Table order_items {
//  order_id int [ref: > orders.id] // inline relationship (many-to-one)
//  product_id int
//  quantity int [default: 1] // default value
//}
//
//Ref: order_items.product_id > products.id

//Table orders {
//  id int [pk] // primary key
//  user_id int [not null, unique]
//  status varchar
//  created_at varchar [note: 'When order created'] // add column note
//}

//----------------------------------------------//

//// -- Level 3 
//// -- Enum, Indexes

// Enum for 'products' table below
//Enum products_status {
//  out_of_stock
//  in_stock
//  running_low [note: 'less than 20'] // add column note
//}

// Indexes: You can define a single or multi-column index 
//Table products {
//  id int [pk]
//  name varchar
//  merchant_id int [not null]
//  price int
//  status products_status
//  created_at datetime [default: `now()`]
  
//  Indexes {
//   (merchant_id, status) [name:'product_status']
 //   id [unique]
 // }
//}

//Table merchants {
 // id int
 // country_code int
 // merchant_name varchar
  
 // "created at" varchar
//  admin_id int //[ref: > T.id]
 // Indexes {
 //   (id, country_code) [pk]
 // }
//}

//Table merchant_periods {
//  id int [pk]
//  merchant_id int
//  country_code int
//  start_date datetime
//  end_date datetime
//}

//Ref: products.merchant_id > merchants.id // many-to-one
//composite foreign key
//Ref: merchant_periods.(merchant_id, country_code) > merchants.(id, country_code)
