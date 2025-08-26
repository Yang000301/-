CREATE DATABASE GameSpace;
GO
USE GameSpace;
GO
CREATE TABLE [Users] (
  [User_ID] int PRIMARY KEY IDENTITY(1, 1),
  [User_name] nvarchar UNIQUE NOT NULL,
  [User_Account] nvarchar UNIQUE NOT NULL,
  [User_Password] nvarchar NOT NULL
)
GO

CREATE TABLE [User_Introduce] (
  [User_ID] int PRIMARY KEY,
  [User_NickName] NVARCHAR UNIQUE NOT NULL,
  [Gender] CHAR NOT NULL,
  [IdNumber] nvarchar(255) UNIQUE NOT NULL,
  [Cellphone] nvarchar(255) UNIQUE NOT NULL,
  [Email] nvarchar UNIQUE NOT NULL,
  [Address] nvarchar NOT NULL,
  [DateOfBirth] date NOT NULL,
  [Create_Account] datetime2 NOT NULL,
  [User_Picture] varbinary(max),
  [User_Introduce] NVARCHAR(200)
)
GO

CREATE TABLE [User_Rights] (
  [User_Id] int PRIMARY KEY,
  [User_Status] bit,
  [ShoppingPermission] bit,
  [MessagePermission] bit,
  [SalesAuthority] bit
)
GO

CREATE TABLE [User_wallet] (
  [User_Id] int PRIMARY KEY,
  [User_Point] int,
  [Coupon_Number] VARCHAR
)
GO

CREATE TABLE [MemberSalesProfile] (
  [User_Id] int PRIMARY KEY,
  [BankCode] int,
  [BankAccountNumber] nvarchar(255),
  [AccountCoverPhoto] varbinary(max)
)
GO

CREATE TABLE [User_Sales_Information] (
  [User_Id] int PRIMARY KEY,
  [UserSales_Wallet] int
)
GO

CREATE TABLE [ManagerData] (
  [Manager_Id] INT PRIMARY KEY,
  [Manager_Name] NVARCHAR,
  [Manager_Account] VARCHAR UNIQUE,
  [Manager_Password] NVARCHAR,
  [Administrator_registration_date] datetime2
)
GO

CREATE TABLE [ManagerRolePermission] (
  [ManagerRole_Id] INT PRIMARY KEY,
  [role_name] NVARCHAR NOT NULL,
  [AdministratorPrivilegesManagement] bit,
  [UserStatusManagement] bit,
  [ShoppingPermissionManagement] bit,
  [MessagePermissionManagement] bit,
  [Pet_Rights_Management] bit,
  [customer_service] bit
)
GO

CREATE TABLE [ManagerRole] (
  [Manager_Id] INT,
  [ManagerRole_Id] INT,
  [ManagerRole] NVARCHAR,
  PRIMARY KEY ([Manager_Id], [ManagerRole_Id])
)
GO

CREATE TABLE [games] (
  [game_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar,
  [genre] nvarchar,
  [created_at] datetime2 DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [metric_sources] (
  [source_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar,
  [note] nvarchar,
  [created_at] datetime2
)
GO

CREATE TABLE [metrics] (
  [metric_id] int PRIMARY KEY IDENTITY(1, 1),
  [source_id] int,
  [code] nvarchar(255),
  [unit] nvarchar(255),
  [description] nvarchar,
  [is_active] bit,
  [created_at] datetime2
)
GO

CREATE TABLE [game_source_map] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [game_id] int,
  [source_id] int,
  [external_key] nvarchar(255)
)
GO

CREATE TABLE [game_metric_daily] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [game_id] int,
  [metric_id] int,
  [date] date,
  [value] decimal(18,4),
  [agg_method] nvarchar(255),
  [quality] nvarchar(255),
  [created_at] datetime2,
  [updated_at] datetime2
)
GO

CREATE TABLE [popularity_index_daily] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [game_id] int,
  [date] date,
  [index_value] decimal(18,4),
  [created_at] datetime2
)
GO

CREATE TABLE [leaderboard_snapshots] (
  [snapshot_id] int PRIMARY KEY IDENTITY(1, 1),
  [period] nvarchar(255),
  [ts] datetime2,
  [rank] int,
  [game_id] int,
  [index_value] decimal(18,4),
  [created_at] datetime2
)
GO

CREATE TABLE [posts] (
  [post_id] int PRIMARY KEY IDENTITY(1, 1),
  [type] nvarchar,
  [game_id] int,
  [title] nvarchar,
  [tldr] nvarchar,
  [body_md] nvarchar,
  [status] nvarchar(255),
  [pinned] bit,
  [created_by] int,
  [published_at] datetime2,
  [created_at] datetime2,
  [updated_at] datetime2
)
GO

CREATE TABLE [post_metric_snapshot] (
  [post_id] int PRIMARY KEY,
  [game_id] int,
  [date] date,
  [index_value] decimal(18,4),
  [details_json] NVARCHAR(max),
  [created_at] datetime2
)
GO

CREATE TABLE [post_sources] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [post_id] int,
  [source_name] nvarchar(255),
  [url] nvarchar(255),
  [created_at] datetime2
)
GO

CREATE TABLE [banned_words] (
  [word_id] int PRIMARY KEY IDENTITY(1, 1),
  [word] nvarchar,
  [created_at] datetime2
)
GO

CREATE TABLE [forums] (
  [forum_id] int PRIMARY KEY IDENTITY(1, 1),
  [game_id] int,
  [name] nvarchar(255),
  [description] nvarchar,
  [created_at] datetime2
)
GO

CREATE TABLE [threads] (
  [thread_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [forum_id] int,
  [author_user_id] int,
  [title] nvarchar,
  [status] nvarchar(255),
  [created_at] datetime2,
  [updated_at] datetime2
)
GO

CREATE TABLE [thread_posts] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [thread_id] bigint,
  [author_user_id] int,
  [content_md] nvarchar,
  [parent_post_id] bigint,
  [status] nvarchar(255),
  [created_at] datetime2,
  [updated_at] datetime2
)
GO

CREATE TABLE [reactions] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [user_id] int,
  [target_type] nvarchar(255),
  [target_id] bigint,
  [kind] nvarchar(255),
  [created_at] datetime2
)
GO

CREATE TABLE [bookmarks] (
  [id] bigint PRIMARY KEY IDENTITY(1, 1),
  [user_id] int,
  [target_type] nvarchar(255),
  [target_id] bigint,
  [created_at] datetime2
)
GO

CREATE TABLE [UserSignInStats] (
  [LogID] int PRIMARY KEY IDENTITY(1, 1),
  [SignTime] datetime2 NOT NULL DEFAULT 'SYSUTCDATETIME()',
  [UserID] int NOT NULL,
  [PointsChanged] int NOT NULL DEFAULT (0),
  [ExpGained] int NOT NULL DEFAULT (0),
  [PointsChangedTime] datetime2 NOT NULL DEFAULT 'SYSUTCDATETIME()',
  [ExpGainedTime] datetime2 NOT NULL DEFAULT 'SYSUTCDATETIME()'
)
GO

CREATE TABLE [Pet] (
  [PetID] int PRIMARY KEY IDENTITY(1, 1),
  [UserID] int NOT NULL,
  [PetName] nvarchar(50) NOT NULL DEFAULT '小可愛',
  [Level] int NOT NULL DEFAULT (0),
  [LevelUpTime] datetime2 NOT NULL DEFAULT 'SYSUTCDATETIME()',
  [Experience] int NOT NULL DEFAULT (0),
  [Hunger] int NOT NULL DEFAULT (0),
  [Mood] int NOT NULL DEFAULT (0),
  [Stamina] int NOT NULL DEFAULT (0),
  [Cleanliness] int NOT NULL DEFAULT (0),
  [Health] int NOT NULL DEFAULT (0),
  [SkinColor] nvarchar(50) NOT NULL DEFAULT '#ADD8E6',
  [ColorChangedTime] datetime2 NOT NULL DEFAULT 'SYSUTCDATETIME()',
  [BackgroundColor] nvarchar(50) NOT NULL DEFAULT '粉藍',
  [BackgroundColorChangedTime] datetime2 NOT NULL DEFAULT 'SYSUTCDATETIME()',
  [PointsChanged] int NOT NULL DEFAULT (0),
  [PointsChangedTime] datetime2 NOT NULL DEFAULT 'SYSUTCDATETIME()'
)
GO

CREATE TABLE [MiniGame] (
  [PlayID] int PRIMARY KEY IDENTITY(1, 1),
  [UserID] int NOT NULL,
  [PetID] int NOT NULL,
  [Level] int NOT NULL DEFAULT (0),
  [MonsterCount] int NOT NULL DEFAULT (0),
  [SpeedMultiplier] decimal(5,2) NOT NULL DEFAULT (1),
  [Result] nvarchar(10) NOT NULL DEFAULT 'Unknown',
  [ExpGained] int NOT NULL DEFAULT (0),
  [ExpGainedTime] datetime2,
  [PointsChanged] int NOT NULL DEFAULT (0),
  [PointsChangedTime] datetime2,
  [HungerDelta] int NOT NULL DEFAULT (0),
  [MoodDelta] int NOT NULL DEFAULT (0),
  [StaminaDelta] int NOT NULL DEFAULT (0),
  [CleanlinessDelta] int NOT NULL DEFAULT (0),
  [StartTime] datetime2 NOT NULL DEFAULT 'SYSUTCDATETIME()',
  [EndTime] datetime2,
  [Aborted] bit NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [Official_Store_Ranking] (
  [ranking_id] INT PRIMARY KEY,
  [period_type] NVARCHAR,
  [ranking_date] DATE,
  [product_ID] INT,
  [ranking_metric] VARCHAR,
  [ranking_position] TINYINT,
  [trading_amount] DECIMAL,
  [trading_volume] INT,
  [ranking_updated_at] DATETIME2
)
GO

CREATE TABLE [Supplier] (
  [supplier_id] INT PRIMARY KEY,
  [supplier_name] NVARCHAR
)
GO

CREATE TABLE [OrderInfo] (
  [order_id] INT PRIMARY KEY,
  [user_id] INT,
  [order_date] DATETIME2,
  [order_status] NVARCHAR,
  [payment_status] NVARCHAR,
  [order_total] DECIMAL,
  [payment_at] DATETIME2,
  [shipped_at] DATETIME2,
  [completed_at] DATETIME2
)
GO

CREATE TABLE [OrderItems] (
  [item_id] INT PRIMARY KEY,
  [order_id] INT,
  [product_id] INT,
  [line_no] INT,
  [unit_price] DECIMAL,
  [quantity] INT,
  [subtotal] DECIMAL
)
GO

CREATE TABLE [ProductInfo] (
  [product_id] INT PRIMARY KEY,
  [product_name] NVARCHAR,
  [product_type] NVARCHAR,
  [price] DECIMAL,
  [currency_code] NVARCHAR,
  [Shipment_Quantity] INT,
  [product_created_by] NVARCHAR,
  [product_created_at] DATETIME2,
  [product_updated_by] NVARCHAR,
  [product_updated_at] DATETIME2,
  [user_id] INT
)
GO

CREATE TABLE [GameProductDetails] (
  [product_id] int PRIMARY KEY,
  [product_name] NVARCHAR,
  [product_description] NVARCHAR,
  [supplier_id] int,
  [platform_id] int,
  [game_id] int,
  [game_name] NVARCHAR,
  [download_link] NVARCHAR
)
GO

CREATE TABLE [OtherProductDetails] (
  [product_id] int PRIMARY KEY,
  [product_name] NVARCHAR,
  [product_description] NVARCHAR,
  [supplier_id] int,
  [platform_id] int,
  [digital_code] NVARCHAR,
  [size] NVARCHAR,
  [color] NVARCHAR,
  [weight] NVARCHAR,
  [dimensions] NVARCHAR,
  [material] NVARCHAR,
  [stock_quantity] NVARCHAR
)
GO

CREATE TABLE [ProductInfoAuditLog] (
  [log_id] BIGINT,
  [product_id] INT,
  [action_type] NVARCHAR,
  [field_name] NVARCHAR,
  [old_value] NVARCHAR,
  [new_value] NVARCHAR,
  [Manager_Id] INT,
  [changed_at] DATETIME2
)
GO

CREATE TABLE [PlayerMarketRanking] (
  [p_ranking_id] int PRIMARY KEY,
  [p_period_type] nvarchar(255),
  [p_ranking_date] date,
  [p_product_id] int,
  [p_ranking_metric] nvarchar(255),
  [p_ranking_position] int,
  [p_trading_amount] DECIMAL,
  [p_trading_volume] int,
  [updated_at] datetime2
)
GO

CREATE TABLE [PlayerMarketProductInfo] (
  [p_product_id] int PRIMARY KEY,
  [p_product_type] nvarchar,
  [p_product_title] nvarchar,
  [p_product_name] nvarchar,
  [p_product_description] nvarchar,
  [product_id] int,
  [seller_id] int,
  [p_status] nvarchar,
  [price] decimal,
  [p_product_img_id] nvarchar,
  [created_at] datetime2,
  [updated_at] datetime2
)
GO

CREATE TABLE [PlayerMarketProductImgs] (
  [p_product_img_id] int PRIMARY KEY,
  [p_product_id] int,
  [p_product_img_url] nvarchar(max)
)
GO

CREATE TABLE [PlayerMarketOrderInfo] (
  [p_order_id] int PRIMARY KEY,
  [p_product_id] int,
  [seller_id] int,
  [buyer_id] int,
  [p_order_date] datetime2,
  [p_order_status] nvarchar,
  [p_payment_status] nvarchar,
  [p_unit_price] int,
  [p_quantity] int,
  [p_order_total] int,
  [p_order_created_at] datetime2,
  [p_order_updated_at] datetime2
)
GO

CREATE TABLE [PlayerMarketOrderTradepage] (
  [p_order_tradepage_id] int PRIMARY KEY,
  [p_order_id] int,
  [p_product_id] int,
  [p_order_platform_fee] int,
  [seller_transferred_at] datetime2,
  [buyer_received_at] datetime2,
  [completed_at] datetime2
)
GO

CREATE TABLE [PlayerMarketTradeMsg] (
  [trade_msg_id] int PRIMARY KEY,
  [p_order_tradepage_id] int,
  [msg_from] nvarchar,
  [message_text] nvarchar,
  [created_at] datetime2
)
GO

CREATE TABLE [Admins] (
  [manager_id] int PRIMARY KEY,
  [last_login] datetime2
)
GO

CREATE TABLE [Mutes] (
  [mute_id] int PRIMARY KEY IDENTITY(1, 1),
  [mute_name] nvarchar,
  [created_at] datetime2,
  [is_active] bit NOT NULL DEFAULT (1),
  [manager_id] int
)
GO

CREATE TABLE [Styles] (
  [style_id] int PRIMARY KEY IDENTITY(1, 1),
  [style_name] nvarchar,
  [effect_desc] nvarchar,
  [created_at] datetime2,
  [manager_id] int
)
GO

CREATE TABLE [Notification_Sources] (
  [source_id] int PRIMARY KEY IDENTITY(1, 1),
  [source_name] nvarchar
)
GO

CREATE TABLE [Notification_Actions] (
  [action_id] int PRIMARY KEY IDENTITY(1, 1),
  [action_name] nvarchar
)
GO

CREATE TABLE [Notifications] (
  [notification_id] int PRIMARY KEY IDENTITY(1, 1),
  [source_id] int NOT NULL,
  [action_id] int NOT NULL,
  [sender_id] int NOT NULL,
  [sender_manager_id] int,
  [notification_title] nvarchar,
  [notification_message] nvarchar,
  [created_at] datetime2 NOT NULL,
  [group_id] int
)
GO

CREATE TABLE [Notification_Recipients] (
  [recipient_id] int PRIMARY KEY IDENTITY(1, 1),
  [notification_id] int NOT NULL,
  [user_id] int NOT NULL,
  [is_read] bit NOT NULL DEFAULT (0),
  [read_at] datetime2
)
GO

CREATE TABLE [Chat_Message] (
  [message_id] int PRIMARY KEY IDENTITY(1, 1),
  [manager_id] int,
  [sender_id] int NOT NULL,
  [receiver_id] int,
  [chat_content] nvarchar NOT NULL,
  [sent_at] datetime2 NOT NULL,
  [is_read] bit NOT NULL DEFAULT (0),
  [is_sent] bit NOT NULL DEFAULT (1)
)
GO

CREATE TABLE [Groups] (
  [group_id] int PRIMARY KEY IDENTITY(1, 1),
  [group_name] nvarchar,
  [created_by] int,
  [created_at] datetime2
)
GO

CREATE TABLE [Group_Member] (
  [group_id] int NOT NULL,
  [user_id] int NOT NULL,
  [joined_at] datetime2,
  [is_admin] bit NOT NULL DEFAULT (0),
  PRIMARY KEY ([group_id], [user_id])
)
GO

CREATE TABLE [Group_Chat] (
  [group_chat_id] int PRIMARY KEY IDENTITY(1, 1),
  [group_id] int,
  [sender_id] int,
  [group_chat_content] nvarchar,
  [sent_at] datetime2,
  [is_sent] bit NOT NULL DEFAULT (1)
)
GO

CREATE TABLE [Group_Block] (
  [block_id] int PRIMARY KEY IDENTITY(1, 1),
  [group_id] int,
  [user_id] int,
  [blocked_by] int,
  [created_at] datetime2
)
GO

CREATE TABLE [Relation] (
  [relation_id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [user_id] int NOT NULL,
  [friend_id] int NOT NULL,
  [status_id] int NOT NULL,
  [friend_nickname] nvarchar(10),
  [created_at] datetime2 NOT NULL DEFAULT (SYSDATETIME()),
  [updated_at] datetime2
)
GO

CREATE TABLE [Relation_Status] (
  [status_id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [status_name] nvarchar(10) NOT NULL
)
GO

CREATE UNIQUE INDEX [metrics_index_0] ON [metrics] ("source_id", "code")
GO

CREATE UNIQUE INDEX [game_source_map_index_1] ON [game_source_map] ("game_id", "source_id")
GO

CREATE INDEX [game_source_map_index_2] ON [game_source_map] ("source_id", "external_key")
GO

CREATE UNIQUE INDEX [game_metric_daily_index_3] ON [game_metric_daily] ("game_id", "metric_id", "date")
GO

CREATE INDEX [game_metric_daily_index_4] ON [game_metric_daily] ("date", "metric_id")
GO

CREATE INDEX [game_metric_daily_index_5] ON [game_metric_daily] ("game_id", "date")
GO

CREATE UNIQUE INDEX [popularity_index_daily_index_6] ON [popularity_index_daily] ("game_id", "date")
GO

CREATE INDEX [popularity_index_daily_index_7] ON [popularity_index_daily] ("date")
GO

CREATE INDEX [leaderboard_snapshots_index_8] ON [leaderboard_snapshots] ("period", "ts", "rank")
GO

CREATE UNIQUE INDEX [leaderboard_snapshots_index_9] ON [leaderboard_snapshots] ("period", "ts", "rank", "game_id")
GO

CREATE INDEX [leaderboard_snapshots_index_10] ON [leaderboard_snapshots] ("period", "ts", "game_id")
GO

CREATE INDEX [posts_index_11] ON [posts] ("type", "created_at")
GO

CREATE INDEX [posts_index_12] ON [posts] ("game_id", "created_at")
GO

CREATE INDEX [posts_index_13] ON [posts] ("status", "created_at")
GO

CREATE INDEX [post_sources_index_14] ON [post_sources] ("post_id")
GO

CREATE UNIQUE INDEX [forums_index_15] ON [forums] ("game_id")
GO

CREATE INDEX [threads_index_16] ON [threads] ("forum_id", "updated_at")
GO

CREATE INDEX [thread_posts_index_17] ON [thread_posts] ("thread_id", "created_at")
GO

CREATE UNIQUE INDEX [reactions_index_18] ON [reactions] ("user_id", "target_type", "target_id", "kind")
GO

CREATE INDEX [reactions_index_19] ON [reactions] ("target_type", "target_id")
GO

CREATE UNIQUE INDEX [bookmarks_index_20] ON [bookmarks] ("user_id", "target_type", "target_id")
GO

CREATE INDEX [bookmarks_index_21] ON [bookmarks] ("target_type", "target_id")
GO

CREATE UNIQUE INDEX [Notification_Actions_index_22] ON [Notification_Actions] ("action_name")
GO

CREATE UNIQUE INDEX [Notification_Recipients_index_23] ON [Notification_Recipients] ("notification_id", "user_id")
GO

CREATE INDEX [IX_Inbox] ON [Notification_Recipients] ("user_id", "is_read", "recipient_id")
GO

CREATE INDEX [Chat_Message_index_25] ON [Chat_Message] ("sent_at")
GO

CREATE INDEX [Chat_Message_index_26] ON [Chat_Message] ("receiver_id", "sent_at")
GO

CREATE INDEX [Group_Chat_index_27] ON [Group_Chat] ("group_id")
GO

CREATE INDEX [Group_Chat_index_28] ON [Group_Chat] ("group_id", "sent_at")
GO

CREATE UNIQUE INDEX [Group_Block_index_29] ON [Group_Block] ("group_id", "user_id")
GO

CREATE INDEX [Group_Block_index_30] ON [Group_Block] ("group_id")
GO

CREATE INDEX [Group_Block_index_31] ON [Group_Block] ("user_id")
GO

CREATE UNIQUE INDEX [Relation_index_32] ON [Relation] ("user_id", "friend_id")
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者編號',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Users',
@level2type = N'Column', @level2name = 'User_ID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者姓名',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Users',
@level2type = N'Column', @level2name = 'User_name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '登入帳號（唯一）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Users',
@level2type = N'Column', @level2name = 'User_Account';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者密碼',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Users',
@level2type = N'Column', @level2name = 'User_Password';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'FK 到 Users',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'User_ID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者暱稱',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'User_NickName';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '性別',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'Gender';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '身分證字號',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'IdNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '聯繫電話',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'Cellphone';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '電子郵件（唯一）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'Email';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '地址',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'Address';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '出生年月日',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'DateOfBirth';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '創建帳號日期',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'Create_Account';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '頭像圖片 URL',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'User_Picture';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者自介',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Introduce',
@level2type = N'Column', @level2name = 'User_Introduce';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'FK 到 Users',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Rights',
@level2type = N'Column', @level2name = 'User_Id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者狀態',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Rights',
@level2type = N'Column', @level2name = 'User_Status';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '購物權限',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Rights',
@level2type = N'Column', @level2name = 'ShoppingPermission';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '留言權限',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Rights',
@level2type = N'Column', @level2name = 'MessagePermission';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '銷售權限',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Rights',
@level2type = N'Column', @level2name = 'SalesAuthority';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'FK 到 Users',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_wallet',
@level2type = N'Column', @level2name = 'User_Id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者編號',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_wallet',
@level2type = N'Column', @level2name = 'User_Point';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '優惠券編號',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_wallet',
@level2type = N'Column', @level2name = 'Coupon_Number';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'FK 到 Users',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MemberSalesProfile',
@level2type = N'Column', @level2name = 'User_Id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '銀行代號',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MemberSalesProfile',
@level2type = N'Column', @level2name = 'BankCode';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '銀行帳號',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MemberSalesProfile',
@level2type = N'Column', @level2name = 'BankAccountNumber';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '帳戶封面照片',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MemberSalesProfile',
@level2type = N'Column', @level2name = 'AccountCoverPhoto';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'FK 到 Users',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Sales_Information',
@level2type = N'Column', @level2name = 'User_Id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者銷售錢包',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User_Sales_Information',
@level2type = N'Column', @level2name = 'UserSales_Wallet';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理者編號',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerData',
@level2type = N'Column', @level2name = 'Manager_Id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理者姓名',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerData',
@level2type = N'Column', @level2name = 'Manager_Name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理者帳號（建議唯一）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerData',
@level2type = N'Column', @level2name = 'Manager_Account';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理者密碼（實務請存雜湊）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerData',
@level2type = N'Column', @level2name = 'Manager_Password';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理者註冊時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerData',
@level2type = N'Column', @level2name = 'Administrator_registration_date';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理者角色編號',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRolePermission',
@level2type = N'Column', @level2name = 'ManagerRole_Id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '顯示名稱  舉例:商城管理員',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRolePermission',
@level2type = N'Column', @level2name = 'role_name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理者權限管理',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRolePermission',
@level2type = N'Column', @level2name = 'AdministratorPrivilegesManagement';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者狀態管理',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRolePermission',
@level2type = N'Column', @level2name = 'UserStatusManagement';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '商城權限管理',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRolePermission',
@level2type = N'Column', @level2name = 'ShoppingPermissionManagement';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '論壇權限管理',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRolePermission',
@level2type = N'Column', @level2name = 'MessagePermissionManagement';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物權限管理',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRolePermission',
@level2type = N'Column', @level2name = 'Pet_Rights_Management';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '客服權限管理',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRolePermission',
@level2type = N'Column', @level2name = 'customer_service';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'FK: 管理者',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRole',
@level2type = N'Column', @level2name = 'Manager_Id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'FK: 角色',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRole',
@level2type = N'Column', @level2name = 'ManagerRole_Id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '角色名稱',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'ManagerRole',
@level2type = N'Column', @level2name = 'ManagerRole';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '遊戲主檔：列出平台所有遊戲',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'games';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'UTC',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'games',
@level2type = N'Column', @level2name = 'created_at';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '數據來源字典：定義要抓的外部平台',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'metric_sources';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '指標字典：來源底下的可用指標清單',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'metrics';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '外部ID對應表：把內部遊戲對應到各來源的外部鍵',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'game_source_map';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '每天每指標的原始值（清洗後），是計算指數的底稿',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'game_metric_daily';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '每日熱度指數（計算結果）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'popularity_index_daily';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '榜單快照：直接給前台讀，避免重算',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'leaderboard_snapshots';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '統一貼文表：洞察與未來UGC都走這',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'posts';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '洞察發佈時的數據快照（固定展示）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'post_metric_snapshot';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '洞察引用來源清單',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'post_sources';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '論壇版主檔：每遊戲一個版',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'forums';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '版內主題（討論串）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'threads';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '主題回覆（支援二層結構）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'thread_posts';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '通用讚表（多型）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'reactions';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = '通用收藏表（多型）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'bookmarks';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '簽到記錄 ID，自動遞增',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserSignInStats',
@level2type = N'Column', @level2name = 'LogID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '簽到時間（預設 UTC 當下時間）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserSignInStats',
@level2type = N'Column', @level2name = 'SignTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '會員 ID，外鍵參考 Users.UserID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserSignInStats',
@level2type = N'Column', @level2name = 'UserID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '此次簽到會員點數增減數量',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserSignInStats',
@level2type = N'Column', @level2name = 'PointsChanged';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '此次簽到寵物獲得經驗值',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserSignInStats',
@level2type = N'Column', @level2name = 'ExpGained';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '點數變動時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserSignInStats',
@level2type = N'Column', @level2name = 'PointsChangedTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物經驗值獲得時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserSignInStats',
@level2type = N'Column', @level2name = 'ExpGainedTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物 ID，自動遞增',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'PetID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物主人會員 ID，外鍵參考 Users.UserID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'UserID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物名稱，若未提供則預設',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'PetName';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物當前等級',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'Level';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物最後一次升級時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'LevelUpTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物累計總經驗值',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'Experience';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '飢餓值（0–100）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'Hunger';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '心情值（0–100）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'Mood';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '體力值（0–100）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'Stamina';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '清潔值（0–100）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'Cleanliness';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '健康度（0–100）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'Health';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '膚色十六進位',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'SkinColor';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '最後一次膚色更換時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'ColorChangedTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '背景色',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'BackgroundColor';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '最後一次被景色更換時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'BackgroundColorChangedTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '最近一次幫寵物換色所花費之會員點數',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'PointsChanged';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '幫寵物換色所花費之會員點數變動時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Pet',
@level2type = N'Column', @level2name = 'PointsChangedTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '遊戲執行記錄 ID，自動遞增',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'PlayID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '玩家會員 ID，外鍵參考 Users.UserID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'UserID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '出戰寵物 ID，外鍵參考 Pet.PetID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'PetID';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '遊戲關卡等級',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'Level';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '需面對的怪物數量',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'MonsterCount';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '怪物移動速度倍率',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'SpeedMultiplier';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '遊戲結果: Win(贏)/Lose(輸)/Abort(中退)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'Result';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物本次獲得經驗值',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'ExpGained';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物獲得經驗值時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'ExpGainedTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '本次會員點數增減',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'PointsChanged';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '本次會員點數變動時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'PointsChangedTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物飢餓值變化量',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'HungerDelta';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物心情值變化量',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'MoodDelta';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物體力值變化量',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'StaminaDelta';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '寵物清潔值變化量',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'CleanlinessDelta';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '遊戲開始時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'StartTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '遊戲結束時間，若中退則為null',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'EndTime';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '是否中途放棄 (0=否,1=是)，預設為0(否)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MiniGame',
@level2type = N'Column', @level2name = 'Aborted';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理員ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Admins',
@level2type = N'Column', @level2name = 'manager_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '上次登入時間，用於後台登入追蹤',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Admins',
@level2type = N'Column', @level2name = 'last_login';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '禁言選項ID（字典）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Mutes',
@level2type = N'Column', @level2name = 'mute_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '禁言名稱',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Mutes',
@level2type = N'Column', @level2name = 'mute_name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '建立時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Mutes',
@level2type = N'Column', @level2name = 'created_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '是否啟用',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Mutes',
@level2type = N'Column', @level2name = 'is_active';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '設置者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Mutes',
@level2type = N'Column', @level2name = 'manager_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '樣式ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Styles',
@level2type = N'Column', @level2name = 'style_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '樣式名稱',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Styles',
@level2type = N'Column', @level2name = 'style_name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '效果說明',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Styles',
@level2type = N'Column', @level2name = 'effect_desc';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '建立時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Styles',
@level2type = N'Column', @level2name = 'created_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '設置者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Styles',
@level2type = N'Column', @level2name = 'manager_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '來源類型ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Sources',
@level2type = N'Column', @level2name = 'source_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '來源名稱',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Sources',
@level2type = N'Column', @level2name = 'source_name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '行為類型ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Actions',
@level2type = N'Column', @level2name = 'action_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '行為名稱',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Actions',
@level2type = N'Column', @level2name = 'action_name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '通知ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'notification_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '來源類型ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'source_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '行為類型ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'action_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '發送者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'sender_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '發送者ID(管理員)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'sender_manager_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '通知標題',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'notification_title';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '通知內容',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'notification_message';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '建立時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'created_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '群組ID（若為群組相關）',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notifications',
@level2type = N'Column', @level2name = 'group_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '接收紀錄ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Recipients',
@level2type = N'Column', @level2name = 'recipient_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '通知ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Recipients',
@level2type = N'Column', @level2name = 'notification_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Recipients',
@level2type = N'Column', @level2name = 'user_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '是否已讀',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Recipients',
@level2type = N'Column', @level2name = 'is_read';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '已讀時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Notification_Recipients',
@level2type = N'Column', @level2name = 'read_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '訊息ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Chat_Message',
@level2type = N'Column', @level2name = 'message_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '管理員ID(客服)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Chat_Message',
@level2type = N'Column', @level2name = 'manager_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '發送者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Chat_Message',
@level2type = N'Column', @level2name = 'sender_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '接收者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Chat_Message',
@level2type = N'Column', @level2name = 'receiver_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '訊息內容',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Chat_Message',
@level2type = N'Column', @level2name = 'chat_content';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '發送時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Chat_Message',
@level2type = N'Column', @level2name = 'sent_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '是否已讀',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Chat_Message',
@level2type = N'Column', @level2name = 'is_read';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '是否寄送',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Chat_Message',
@level2type = N'Column', @level2name = 'is_sent';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '群組ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Groups',
@level2type = N'Column', @level2name = 'group_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '群組名稱',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Groups',
@level2type = N'Column', @level2name = 'group_name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '建立者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Groups',
@level2type = N'Column', @level2name = 'created_by';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '建立時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Groups',
@level2type = N'Column', @level2name = 'created_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '群組ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Member',
@level2type = N'Column', @level2name = 'group_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Member',
@level2type = N'Column', @level2name = 'user_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '加入時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Member',
@level2type = N'Column', @level2name = 'joined_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '是否為管理員',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Member',
@level2type = N'Column', @level2name = 'is_admin';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '群組聊天ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Chat',
@level2type = N'Column', @level2name = 'group_chat_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '群組ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Chat',
@level2type = N'Column', @level2name = 'group_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '發送者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Chat',
@level2type = N'Column', @level2name = 'sender_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '訊息內容',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Chat',
@level2type = N'Column', @level2name = 'group_chat_content';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '發送時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Chat',
@level2type = N'Column', @level2name = 'sent_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '是否寄送',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Chat',
@level2type = N'Column', @level2name = 'is_sent';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '封鎖ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Block',
@level2type = N'Column', @level2name = 'block_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '群組ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Block',
@level2type = N'Column', @level2name = 'group_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '被封鎖者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Block',
@level2type = N'Column', @level2name = 'user_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '封鎖者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Block',
@level2type = N'Column', @level2name = 'blocked_by';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '建立時間',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Group_Block',
@level2type = N'Column', @level2name = 'created_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '好友關係ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation',
@level2type = N'Column', @level2name = 'relation_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '使用者ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation',
@level2type = N'Column', @level2name = 'user_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '好友ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation',
@level2type = N'Column', @level2name = 'friend_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '狀態ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation',
@level2type = N'Column', @level2name = 'status_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '好友暱稱，預設NULL',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation',
@level2type = N'Column', @level2name = 'friend_nickname';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '建立時間，自動生成',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation',
@level2type = N'Column', @level2name = 'created_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '更新時間，更新狀態時使用',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation',
@level2type = N'Column', @level2name = 'updated_at';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '狀態ID',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation_Status',
@level2type = N'Column', @level2name = 'status_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '狀態名稱 (待確認/好友/摯友/封鎖)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Relation_Status',
@level2type = N'Column', @level2name = 'status_name';
GO

ALTER TABLE [User_Introduce] ADD FOREIGN KEY ([User_ID]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [User_Rights] ADD FOREIGN KEY ([User_Id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [User_wallet] ADD FOREIGN KEY ([User_Id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [MemberSalesProfile] ADD FOREIGN KEY ([User_Id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [User_Sales_Information] ADD FOREIGN KEY ([User_Id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [ManagerRole] ADD FOREIGN KEY ([Manager_Id]) REFERENCES [ManagerData] ([Manager_Id])
GO

ALTER TABLE [ManagerRole] ADD FOREIGN KEY ([ManagerRole_Id]) REFERENCES [ManagerRolePermission] ([ManagerRole_Id])
GO

ALTER TABLE [metrics] ADD FOREIGN KEY ([source_id]) REFERENCES [metric_sources] ([source_id])
GO

ALTER TABLE [game_source_map] ADD FOREIGN KEY ([game_id]) REFERENCES [games] ([game_id])
GO

ALTER TABLE [game_source_map] ADD FOREIGN KEY ([source_id]) REFERENCES [metric_sources] ([source_id])
GO

ALTER TABLE [game_metric_daily] ADD FOREIGN KEY ([game_id]) REFERENCES [games] ([game_id])
GO

ALTER TABLE [game_metric_daily] ADD FOREIGN KEY ([metric_id]) REFERENCES [metrics] ([metric_id])
GO

ALTER TABLE [popularity_index_daily] ADD FOREIGN KEY ([game_id]) REFERENCES [games] ([game_id])
GO

ALTER TABLE [leaderboard_snapshots] ADD FOREIGN KEY ([game_id]) REFERENCES [games] ([game_id])
GO

ALTER TABLE [posts] ADD FOREIGN KEY ([game_id]) REFERENCES [games] ([game_id])
GO

ALTER TABLE [posts] ADD FOREIGN KEY ([created_by]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [post_metric_snapshot] ADD FOREIGN KEY ([post_id]) REFERENCES [posts] ([post_id])
GO

ALTER TABLE [post_metric_snapshot] ADD FOREIGN KEY ([game_id]) REFERENCES [games] ([game_id])
GO

ALTER TABLE [post_sources] ADD FOREIGN KEY ([post_id]) REFERENCES [posts] ([post_id])
GO

ALTER TABLE [forums] ADD FOREIGN KEY ([game_id]) REFERENCES [games] ([game_id])
GO

ALTER TABLE [threads] ADD FOREIGN KEY ([forum_id]) REFERENCES [forums] ([forum_id])
GO

ALTER TABLE [threads] ADD FOREIGN KEY ([author_user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [thread_posts] ADD FOREIGN KEY ([thread_id]) REFERENCES [threads] ([thread_id])
GO

ALTER TABLE [thread_posts] ADD FOREIGN KEY ([author_user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [thread_posts] ADD FOREIGN KEY ([parent_post_id]) REFERENCES [thread_posts] ([id])
GO

ALTER TABLE [reactions] ADD FOREIGN KEY ([user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [bookmarks] ADD FOREIGN KEY ([user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [UserSignInStats] ADD FOREIGN KEY ([UserID]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [User_wallet] ADD FOREIGN KEY ([User_Point]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Pet] ADD FOREIGN KEY ([UserID]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [MiniGame] ADD FOREIGN KEY ([UserID]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [MiniGame] ADD FOREIGN KEY ([PetID]) REFERENCES [Pet] ([PetID])
GO

ALTER TABLE [Official_Store_Ranking] ADD FOREIGN KEY ([product_ID]) REFERENCES [ProductInfo] ([product_id])
GO

ALTER TABLE [OrderInfo] ADD FOREIGN KEY ([user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [OrderItems] ADD FOREIGN KEY ([order_id]) REFERENCES [OrderInfo] ([order_id])
GO

ALTER TABLE [OrderItems] ADD FOREIGN KEY ([product_id]) REFERENCES [ProductInfo] ([product_id])
GO

ALTER TABLE [GameProductDetails] ADD FOREIGN KEY ([product_id]) REFERENCES [ProductInfo] ([product_id])
GO

ALTER TABLE [GameProductDetails] ADD FOREIGN KEY ([supplier_id]) REFERENCES [Supplier] ([supplier_id])
GO

ALTER TABLE [OtherProductDetails] ADD FOREIGN KEY ([product_id]) REFERENCES [ProductInfo] ([product_id])
GO

ALTER TABLE [OtherProductDetails] ADD FOREIGN KEY ([supplier_id]) REFERENCES [Supplier] ([supplier_id])
GO

ALTER TABLE [ProductInfoAuditLog] ADD FOREIGN KEY ([product_id]) REFERENCES [ProductInfo] ([product_id])
GO

ALTER TABLE [ProductInfoAuditLog] ADD FOREIGN KEY ([Manager_Id]) REFERENCES [ManagerData] ([Manager_Id])
GO

ALTER TABLE [PlayerMarketRanking] ADD FOREIGN KEY ([p_product_id]) REFERENCES [PlayerMarketProductInfo] ([p_product_id])
GO

ALTER TABLE [PlayerMarketProductInfo] ADD FOREIGN KEY ([product_id]) REFERENCES [ProductInfo] ([product_id])
GO

ALTER TABLE [PlayerMarketProductInfo] ADD FOREIGN KEY ([seller_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [PlayerMarketProductImgs] ADD FOREIGN KEY ([p_product_id]) REFERENCES [PlayerMarketProductInfo] ([p_product_id])
GO

ALTER TABLE [PlayerMarketOrderInfo] ADD FOREIGN KEY ([p_product_id]) REFERENCES [PlayerMarketProductInfo] ([p_product_id])
GO

ALTER TABLE [PlayerMarketOrderInfo] ADD FOREIGN KEY ([seller_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [PlayerMarketOrderInfo] ADD FOREIGN KEY ([buyer_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [PlayerMarketOrderTradepage] ADD FOREIGN KEY ([p_order_id]) REFERENCES [PlayerMarketOrderInfo] ([p_order_id])
GO

ALTER TABLE [PlayerMarketOrderTradepage] ADD FOREIGN KEY ([p_product_id]) REFERENCES [PlayerMarketProductInfo] ([p_product_id])
GO

ALTER TABLE [PlayerMarketTradeMsg] ADD FOREIGN KEY ([p_order_tradepage_id]) REFERENCES [PlayerMarketOrderTradepage] ([p_order_tradepage_id])
GO

ALTER TABLE [Admins] ADD FOREIGN KEY ([manager_id]) REFERENCES [ManagerData] ([Manager_Id])
GO

ALTER TABLE [Mutes] ADD FOREIGN KEY ([manager_id]) REFERENCES [ManagerData] ([Manager_Id])
GO

ALTER TABLE [Styles] ADD FOREIGN KEY ([manager_id]) REFERENCES [ManagerData] ([Manager_Id])
GO

ALTER TABLE [Notifications] ADD FOREIGN KEY ([source_id]) REFERENCES [Notification_Sources] ([source_id])
GO

ALTER TABLE [Notifications] ADD FOREIGN KEY ([action_id]) REFERENCES [Notification_Actions] ([action_id])
GO

ALTER TABLE [Notifications] ADD FOREIGN KEY ([sender_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Notifications] ADD FOREIGN KEY ([sender_manager_id]) REFERENCES [ManagerData] ([Manager_Id])
GO

ALTER TABLE [Notifications] ADD FOREIGN KEY ([group_id]) REFERENCES [Groups] ([group_id])
GO

ALTER TABLE [Notification_Recipients] ADD FOREIGN KEY ([notification_id]) REFERENCES [Notifications] ([notification_id])
GO

ALTER TABLE [Notification_Recipients] ADD FOREIGN KEY ([user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Chat_Message] ADD FOREIGN KEY ([manager_id]) REFERENCES [ManagerData] ([Manager_Id])
GO

ALTER TABLE [Chat_Message] ADD FOREIGN KEY ([sender_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Chat_Message] ADD FOREIGN KEY ([receiver_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Groups] ADD FOREIGN KEY ([created_by]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Group_Member] ADD FOREIGN KEY ([group_id]) REFERENCES [Groups] ([group_id])
GO

ALTER TABLE [Group_Member] ADD FOREIGN KEY ([user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Group_Chat] ADD FOREIGN KEY ([group_id]) REFERENCES [Groups] ([group_id])
GO

ALTER TABLE [Group_Chat] ADD FOREIGN KEY ([sender_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Group_Block] ADD FOREIGN KEY ([group_id]) REFERENCES [Groups] ([group_id])
GO

ALTER TABLE [Group_Block] ADD FOREIGN KEY ([user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Group_Block] ADD FOREIGN KEY ([blocked_by]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Relation] ADD FOREIGN KEY ([user_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Relation] ADD FOREIGN KEY ([friend_id]) REFERENCES [Users] ([User_ID])
GO

ALTER TABLE [Relation] ADD FOREIGN KEY ([status_id]) REFERENCES [Relation_Status] ([status_id])
GO
