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

INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (1, 1, 'Post 1', '2022-01-01', 'image_url_1.jpg', 'Nature', 1);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (2, 2, 'Post 2', '2022-02-02', 'image_url_2.jpg', 'History', 0);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (3, 3, 'Post 3', '2022-04-03', 'image_url_3.jpg', 'Geography', 1);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (4, 2, 'Post 1', '2022-06-01', 'image_url_4.jpg', 'Social Sciences', 1);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (5, 3, 'Post 2', '2022-10-02', 'image_url_5.jpg', 'Nature', 0);
INSERT INTO Posts (user_id, category_id, title, publication_date, image_url, content, approved) VALUES (6, 1, 'Post 3', '2022-07-03', 'image_url_6.jpg', 'History', 1);

CREATE TABLE "Comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "author_id" INTEGER,
  "content" varchar,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

INSERT INTO Comments (post_id, author_id, content) VALUES (1, 2, 'Great article!');
INSERT INTO Comments (post_id, author_id, content) VALUES (1, 3, 'I have a different perspective on this topic.');
INSERT INTO Comments (post_id, author_id, content) VALUES (2, 1, 'Thanks for sharing this valuable information.');
INSERT INTO Comments (post_id, author_id, content) VALUES (3, 2, 'I completely agree with your analysis.');
INSERT INTO Comments (post_id, author_id, content) VALUES (4, 3, 'Interesting read!');
INSERT INTO Comments (post_id, author_id, content) VALUES (6, 1, 'I would like to hear more about this subject.');

CREATE TABLE "Reactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar,
  "image_url" varchar
);

INSERT INTO Reactions (label, image_url) VALUES ('Like', 'like.png');
INSERT INTO Reactions (label, image_url) VALUES ('Love', 'love.png');
INSERT INTO Reactions (label, image_url) VALUES ('Haha', 'haha.png');
INSERT INTO Reactions (label, image_url) VALUES ('Wow', 'wow.png');
INSERT INTO Reactions (label, image_url) VALUES ('Sad', 'sad.png');
INSERT INTO Reactions (label, image_url) VALUES ('Angry', 'angry.png');

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

INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Tags ('label') VALUES ('JavaScript');
INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://pngtree.com/so/happy');
