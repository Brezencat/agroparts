CREATE TYPE "orders_type" AS ENUM (
  'buy',
  'salling'
);

CREATE TABLE "TRANSPORT" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" nvarchar(255) NOT NULL,
  "type" nvarchar(255),
  "group" nvarchar(255),
  "is_del" bit NOT NULL DEFAULT 0,
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

CREATE TABLE "PARTS" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" nvarchar(255) NOT NULL,
  "code" nvarchar(255) NOT NULL DEFAULT '-1',
  "price" decimal(10,2) NOT NULL DEFAULT 0,
  "image" binary,
  "is_del" bit NOT NULL DEFAULT 0,
  "status" tinyint NOT NULL,
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

CREATE TABLE "TRANSPORT_PARTS" (
  "id" SERIAL NOT NULL,
  "transpotr_id" int NOT NULL,
  "parts_id" int NOT NULL,
  "is_del" bit NOT NULL DEFAULT 0,
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

CREATE TABLE "WAREHOUSE" (
  "id" SERIAL NOT NULL,
  "parts_id" int NOT NULL,
  "quantity" int NOT NULL,
  "status" int NOT NULL,
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

CREATE TABLE "MERCHANT" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" nvarchar(255) NOT NULL,
  "location_id" int NOT NULL,
  "description" nvarchar(2000),
  "is_del" bit NOT NULL DEFAULT 0,
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

CREATE TABLE "CUSTOMER" (
  "id" SERIAL NOT NULL,
  "name" nvarchar(255) NOT NULL,
  "location_id" int NOT NULL,
  "description" nvarchar(2000),
  "is_del" bit NOT NULL DEFAULT 0,
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

CREATE TABLE "LOCATION" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "postal_code" int,
  "city" nvarchar(255) NOT NULL,
  "region" nvarchar(255),
  "country" nvarchar(255),
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

CREATE TABLE "ORDERS" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" nvarchar(255),
  "description" nvarchar(4000),
  "client_id" int NOT NULL,
  "type" orders_type NOT NULL,
  "status" tinyint NOT NULL,
  "is_del" bit NOT NULL DEFAULT 0,
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

CREATE TABLE "ORDER_ITEMS" (
  "id" SERIAL NOT NULL,
  "order_id" int NOT NULL,
  "warehouse_id" int NOT NULL,
  "status" int NOT NULL,
  "is_del" bit NOT NULL DEFAULT 0,
  "create_date" timestamp NOT NULL DEFAULT 'getdate()',
  "change_date" timestamp NOT NULL DEFAULT 'getdate()'
);

ALTER TABLE "TRANSPORT_PARTS" ADD FOREIGN KEY ("transpotr_id") REFERENCES "TRANSPORT" ("id");

ALTER TABLE "TRANSPORT_PARTS" ADD FOREIGN KEY ("parts_id") REFERENCES "PARTS" ("id");

ALTER TABLE "WAREHOUSE" ADD FOREIGN KEY ("parts_id") REFERENCES "PARTS" ("id");

ALTER TABLE "MERCHANT" ADD FOREIGN KEY ("location_id") REFERENCES "LOCATION" ("id");

ALTER TABLE "CUSTOMER" ADD FOREIGN KEY ("location_id") REFERENCES "LOCATION" ("id");

ALTER TABLE "ORDERS" ADD FOREIGN KEY ("client_id") REFERENCES "MERCHANT" ("id");

ALTER TABLE "ORDERS" ADD FOREIGN KEY ("client_id") REFERENCES "CUSTOMER" ("id");

ALTER TABLE "ORDER_ITEMS" ADD FOREIGN KEY ("order_id") REFERENCES "ORDERS" ("id");

ALTER TABLE "ORDER_ITEMS" ADD FOREIGN KEY ("warehouse_id") REFERENCES "WAREHOUSE" ("id");

COMMENT ON COLUMN "TRANSPORT"."name" IS 'название техники';

COMMENT ON COLUMN "TRANSPORT"."type" IS 'тип техники';

COMMENT ON COLUMN "TRANSPORT"."group" IS 'группа техники';
