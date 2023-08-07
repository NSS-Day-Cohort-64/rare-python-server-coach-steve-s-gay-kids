CREATE TABLE "Users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "bio" varchar,
  "username" varchar,
  "password" varchar,
  "profile_image_url" varchar,
  "created_on" date,
  "active" bit
);

CREATE TABLE "DemotionQueue" (
  "action" varchar,
  "admin_id" INTEGER,
  "approver_one_id" INTEGER,
  FOREIGN KEY(`admin_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`approver_one_id`) REFERENCES `Users`(`id`),
  PRIMARY KEY (action, admin_id, approver_one_id)
);


CREATE TABLE "Subscriptions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER,
  "author_id" INTEGER,
  "created_on" date,
  FOREIGN KEY(`follower_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Posts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "category_id" INTEGER,
  "title" varchar,
  "publication_date" date,
  "image_url" varchar,
  "content" varchar,
  "approved" bit,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
);

CREATE TABLE "Comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "author_id" INTEGER,
  "content" varchar,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Reactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar,
  "image_url" varchar
);

CREATE TABLE "PostReactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "reaction_id" INTEGER,
  "post_id" INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`reaction_id`) REFERENCES `Reactions`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE "Tags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

CREATE TABLE "PostTags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "tag_id" INTEGER,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`tag_id`) REFERENCES `Tags`(`id`)
);

CREATE TABLE "Categories" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

/* INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Tags ('label') VALUES ('JavaScript');
INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://pngtree.com/so/happy');
 */

INSERT INTO Users (id, first_name, last_name, email, bio, username, password, profile_image_url, created_on, active)
VALUES (1, 'Briana', 'Phillips', 'BrianaPhillips@gmail.com', 'Bio: XYZ', 'BrianaPhillips', 'BrianaPhillips1', 'BrianaPhillips_profile_image_url', '2023-08-07', '1');

INSERT INTO Users (id, first_name, last_name, email, bio, username, password, profile_image_url, created_on, active)
VALUES (2, 'Elena', 'Spraldin', 'ElenaSpraldin@gmail.com', 'Bio: XYZ', 'ElenaSpraldin', 'ElenaSpraldin1', 'ElenaSpraldin_profile_image_url', '2023-08-07', '1');

INSERT INTO Users (id, first_name, last_name, email, bio, username, password, profile_image_url, created_on, active)
VALUES (3, 'Miguel', 'Morales', 'MiguelMorales@gmail.com', 'Bio: XYZ', 'MiguelMorales', 'MiguelMorales1', 'MiguelMorales_profile_image_url', '2023-08-07', '1');

INSERT INTO Users (id, first_name, last_name, email, bio, username, password, profile_image_url, created_on, active)
VALUES (4, 'Jack', 'Hill', 'JackHill@gmail.com', 'Bio: XYZ', 'JackHill', 'JackHill1', 'JackHill_profile_image_url', '2023-08-07', '1');

INSERT INTO Users (id, first_name, last_name, email, bio, username, password, profile_image_url, created_on, active)
VALUES (5, 'Jill', 'Hill', 'JillHill@gmail.com', 'Bio: XYZ', 'JillHill', 'JillHill1', 'JillHill_profile_image_url', '2023-08-07', '1');




INSERT INTO DemotionQueue (action, admin_id, approver_one_id)
VALUES ('action1', 1, 2);

INSERT INTO DemotionQueue (action, admin_id, approver_one_id)
VALUES ('action2', 3, 4);

INSERT INTO DemotionQueue (action, admin_id, approver_one_id)
VALUES ('action3', 5, 6);



INSERT INTO Subscriptions (id, follower_id, author_id, created_on)
VALUES (1, 1, 2, '2023-08-07');

INSERT INTO Subscriptions (id, follower_id, author_id, created_on)
VALUES (2, 3, 4, '2023-08-07');

INSERT INTO Subscriptions (id, follower_id, author_id, created_on)
VALUES (3, 5, 6, '2023-08-07');
