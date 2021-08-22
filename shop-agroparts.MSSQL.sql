CREATE TABLE [TRANSPORT] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL,
  [type] nvarchar(255),
  [group] nvarchar(255),
  [is_del] bit NOT NULL DEFAULT (0),
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

CREATE TABLE [PARTS] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL,
  [code] nvarchar(255) NOT NULL DEFAULT '-1',
  [price] decimal(10,2) NOT NULL DEFAULT (0),
  [image] binary,
  [is_del] bit NOT NULL DEFAULT (0),
  [status] tinyint NOT NULL,
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

CREATE TABLE [TRANSPORT_PARTS] (
  [id] int NOT NULL IDENTITY(1, 1),
  [transpotr_id] int NOT NULL,
  [parts_id] int NOT NULL,
  [is_del] bit NOT NULL DEFAULT (0),
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

CREATE TABLE [WAREHOUSE] (
  [id] int NOT NULL IDENTITY(1, 1),
  [parts_id] int NOT NULL,
  [quantity] int NOT NULL,
  [status] int NOT NULL,
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

CREATE TABLE [MERCHANT] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL,
  [location_id] int NOT NULL,
  [description] nvarchar(2000),
  [is_del] bit NOT NULL DEFAULT (0),
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

CREATE TABLE [CUSTOMER] (
  [id] int NOT NULL IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL,
  [location_id] int NOT NULL,
  [description] nvarchar(2000),
  [is_del] bit NOT NULL DEFAULT (0),
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

CREATE TABLE [LOCATION] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [postal_code] int,
  [city] nvarchar(255) NOT NULL,
  [region] nvarchar(255),
  [country] nvarchar(255),
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

CREATE TABLE [ORDERS] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] nvarchar(255),
  [description] nvarchar(4000),
  [client_id] int NOT NULL,
  [type] nvarchar(255) NOT NULL CHECK ([type] IN ('buy', 'salling')) NOT NULL,
  [status] tinyint NOT NULL,
  [is_del] bit NOT NULL DEFAULT (0),
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

CREATE TABLE [ORDER_ITEMS] (
  [id] int NOT NULL IDENTITY(1, 1),
  [order_id] int NOT NULL,
  [warehouse_id] int NOT NULL,
  [status] int NOT NULL,
  [is_del] bit NOT NULL DEFAULT (0),
  [create_date] timestamp NOT NULL DEFAULT 'getdate()',
  [change_date] timestamp NOT NULL DEFAULT 'getdate()'
)
GO

ALTER TABLE [TRANSPORT_PARTS] ADD FOREIGN KEY ([transpotr_id]) REFERENCES [TRANSPORT] ([id])
GO

ALTER TABLE [TRANSPORT_PARTS] ADD FOREIGN KEY ([parts_id]) REFERENCES [PARTS] ([id])
GO

ALTER TABLE [WAREHOUSE] ADD FOREIGN KEY ([parts_id]) REFERENCES [PARTS] ([id])
GO

ALTER TABLE [MERCHANT] ADD FOREIGN KEY ([location_id]) REFERENCES [LOCATION] ([id])
GO

ALTER TABLE [CUSTOMER] ADD FOREIGN KEY ([location_id]) REFERENCES [LOCATION] ([id])
GO

ALTER TABLE [ORDERS] ADD FOREIGN KEY ([client_id]) REFERENCES [MERCHANT] ([id])
GO

ALTER TABLE [ORDERS] ADD FOREIGN KEY ([client_id]) REFERENCES [CUSTOMER] ([id])
GO

ALTER TABLE [ORDER_ITEMS] ADD FOREIGN KEY ([order_id]) REFERENCES [ORDERS] ([id])
GO

ALTER TABLE [ORDER_ITEMS] ADD FOREIGN KEY ([warehouse_id]) REFERENCES [WAREHOUSE] ([id])
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'название техники',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TRANSPORT',
@level2type = N'Column', @level2name = 'name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'тип техники',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TRANSPORT',
@level2type = N'Column', @level2name = 'type';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'группа техники',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'TRANSPORT',
@level2type = N'Column', @level2name = 'group';
GO
