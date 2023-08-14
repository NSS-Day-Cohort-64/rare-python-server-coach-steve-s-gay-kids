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

-
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
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`)
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

INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (1, 1, 'Post 1', '2022-01-01', 'image_url_1.jpg', 'Nature', 1);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (2, 2, 'Post 2', '2022-02-02', 'image_url_2.jpg', 'History', 0);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (3, 3, 'Post 3', '2022-04-03', 'image_url_3.jpg', 'Geography', 1);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (4, 2, 'Post 1', '2022-06-01', 'image_url_4.jpg', 'Social Sciences', 1);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (5, 3, 'Post 2', '2022-10-02', 'image_url_5.jpg', 'Nature', 0);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (6, 1, 'Post 3', '2022-07-03', 'image_url_6.jpg', 'History', 1);

INSERT INTO Comments (post_id, author_id, content) VALUES (1, 2, 'Great article!');
INSERT INTO Comments (post_id, author_id, content) VALUES (1, 3, 'I have a different perspective on this topic.');
INSERT INTO Comments (post_id, author_id, content) VALUES (2, 1, 'Thanks for sharing this valuable information.');
INSERT INTO Comments (post_id, author_id, content) VALUES (3, 2, 'I completely agree with your analysis.');
INSERT INTO Comments (post_id, author_id, content) VALUES (4, 3, 'Interesting read!');
INSERT INTO Comments (post_id, author_id, content) VALUES (6, 1, 'I would like to hear more about this subject.');

INSERT INTO Reactions (label, image_url) VALUES ('Like', 'like.png');
INSERT INTO Reactions (label, image_url) VALUES ('Love', 'love.png');
INSERT INTO Reactions (label, image_url) VALUES ('Haha', 'haha.png');
INSERT INTO Reactions (label, image_url) VALUES ('Wow', 'wow.png');
INSERT INTO Reactions (label, image_url) VALUES ('Sad', 'sad.png');
INSERT INTO Reactions (label, image_url) VALUES ('Angry', 'angry.png');

INSERT INTO PostReactions ('user_id', 'reaction_id', 'post_id') VALUES ('1', '2', '2');
INSERT INTO PostReactions ('user_id', 'reaction_id', 'post_id') VALUES ('3', '2', '1');
INSERT INTO PostReactions ('user_id', 'reaction_id', 'post_id') VALUES ('2', '1', '3');

INSERT INTO Tags ('label') VALUES ('JavaScript');
INSERT INTO Tags ('label') VALUES ('React');
INSERT INTO Tags ('label') VALUES ('Python');

INSERT INTO PostTags ('post_id', 'tag_id') VALUES ('2', '1');
INSERT INTO PostTags ('post_id', 'tag_id') VALUES ('1', '2');
INSERT INTO PostTags ('post_id', 'tag_id') VALUES ('3', '2');

INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Categories ('label') VALUES ('Drama');
INSERT INTO Categories ('label') VALUES ('Gay');
