CREATE TABLE image
(
  image_id   INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  filename   VARCHAR(255)                       NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT image_image_id_uindex
  UNIQUE (image_id)
);

CREATE TABLE member
(
  member_id  INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  image_id   INT(11) UNSIGNED                     NULL,
  first_name VARCHAR(255)                         NULL,
  last_name  VARCHAR(255)                         NULL,
  nikname    VARCHAR(64)                          NOT NULL,
  email      VARCHAR(64)                          NOT NULL,
  password   VARCHAR(60)                          NULL,
  status     ENUM ('new', 'active') DEFAULT 'new' NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP   NOT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP   NOT NULL,
  CONSTRAINT member_member_id_uindex
  UNIQUE (member_id),
  CONSTRAINT member_image_image_id_fk
  FOREIGN KEY (image_id) REFERENCES image (image_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX member_image_image_id_fk
  ON member (image_id);

CREATE TABLE message
(
  message_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  member_id  INT(11) UNSIGNED                   NOT NULL,
  content    VARCHAR(255)                       NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT message_message_id_uindex
  UNIQUE (message_id),
  CONSTRAINT message_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX message_member_member_id_fk
  ON message (member_id);

CREATE TABLE album
(
  album_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  CONSTRAINT album_album_id_uindex
  UNIQUE (album_id)
);

CREATE TABLE album_image
(
  album_image_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  album_id       INT(11) UNSIGNED NULL,
  image_id       INT(11) UNSIGNED NULL,
  member_id      INT(11) UNSIGNED NOT NULL,
  CONSTRAINT album_image_album_image_id_uindex
  UNIQUE (album_image_id),
  CONSTRAINT album_image_album_album_id_fk
  FOREIGN KEY (album_id) REFERENCES album (album_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT album_image_image_image_id_fk
  FOREIGN KEY (image_id) REFERENCES image (image_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT album_image_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX album_image_album_album_id_fk
  ON album_image (album_id);

CREATE INDEX album_image_image_image_id_fk
  ON album_image (image_id);

CREATE INDEX album_image_member_member_id_fk
  ON album_image (member_id);

CREATE TABLE album_member
(
  album_member_id INT(11) UNSIGNED NULL,
  album_id        INT(11) UNSIGNED NOT NULL,
  member_id       INT(11) UNSIGNED NOT NULL,
  CONSTRAINT album_member_album_album_id_fk
  FOREIGN KEY (album_id) REFERENCES album (album_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT album_member_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX album_member_album_album_id_fk
  ON album_member (album_id);

CREATE INDEX album_member_member_member_id_fk
  ON album_member (member_id);

CREATE TABLE album_member_request
(
  album_member_request_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  album_id                INT(11) UNSIGNED                                  NOT NULL,
  member_id               INT(11) UNSIGNED                                  NOT NULL,
  status                  ENUM ('new', 'confirmed', 'denied') DEFAULT 'new' NOT NULL,
  created_at              DATETIME DEFAULT CURRENT_TIMESTAMP                NOT NULL,
  updated_at              DATETIME DEFAULT CURRENT_TIMESTAMP                NOT NULL,
  CONSTRAINT album_member_request_album_member_request_id_uindex
  UNIQUE (album_member_request_id),
  CONSTRAINT album_member_request_album_album_id_fk
  FOREIGN KEY (album_id) REFERENCES album (album_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT album_member_request_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX album_member_request_album_album_id_fk
  ON album_member_request (album_id);

CREATE INDEX album_member_request_member_member_id_fk
  ON album_member_request (member_id);

CREATE TABLE chat
(
  chat_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  CONSTRAINT chat_chat_id_uindex
  UNIQUE (chat_id)
);

CREATE TABLE chat_member
(
  chat_member_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  chat_id        INT(11) UNSIGNED NOT NULL,
  member_id      INT(11) UNSIGNED NOT NULL,
  message_id     INT(11) UNSIGNED NOT NULL,
  CONSTRAINT chat_member_chat_member_id_uindex
  UNIQUE (chat_member_id),
  CONSTRAINT chat_member_chat_chat_id_fk
  FOREIGN KEY (chat_id) REFERENCES chat (chat_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT chat_member_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT chat_member_message_message_id_fk
  FOREIGN KEY (message_id) REFERENCES message (message_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX chat_member_chat_chat_id_fk
  ON chat_member (chat_id);

CREATE INDEX chat_member_member_member_id_fk
  ON chat_member (member_id);

CREATE INDEX chat_member_message_message_id_fk
  ON chat_member (message_id);

CREATE TABLE confirm
(
  confirm_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  member_id  INT(11) UNSIGNED                          NOT NULL,
  status     ENUM ('sent', 'confirmed') DEFAULT 'sent' NOT NULL,
  code       VARCHAR(32)                               NOT NULL,
  attempts   TINYINT(1) DEFAULT '0'                    NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP        NOT NULL,
  expired_at DATETIME DEFAULT CURRENT_TIMESTAMP        NOT NULL,
  CONSTRAINT confirm_confirm_id_uindex
  UNIQUE (confirm_id),
  CONSTRAINT confirm_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX confirm_member_member_id_fk
  ON confirm (member_id);

CREATE TABLE friend_request
(
  friend_request_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  member_id         INT(11) UNSIGNED                    NOT NULL,
  request_id        INT(11) UNSIGNED                    NOT NULL,
  status            ENUM ('new', 'confirmed', 'denied') NOT NULL,
  created_at        DATETIME DEFAULT CURRENT_TIMESTAMP  NOT NULL,
  updated_at        DATETIME DEFAULT CURRENT_TIMESTAMP  NOT NULL,
  CONSTRAINT friend_request_friend_request_id_uindex
  UNIQUE (friend_request_id),
  CONSTRAINT friend_request_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT friend_request_request_member_id_fk
  FOREIGN KEY (request_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX friend_request_member_member_id_fk
  ON friend_request (member_id);

CREATE INDEX friend_request_request_member_id_fk
  ON friend_request (request_id);

CREATE TABLE `group`
(
  group_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  CONSTRAINT group_group_id_uindex
  UNIQUE (group_id)
);

CREATE TABLE group_album
(
  group_album_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  group_id       INT(11) UNSIGNED NOT NULL,
  album_id       INT(11) UNSIGNED NOT NULL,
  CONSTRAINT group_album_group_album_id_uindex
  UNIQUE (group_album_id),
  CONSTRAINT group_album_group_group_id_fk
  FOREIGN KEY (group_id) REFERENCES `group` (group_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT group_album_album_album_id_fk
  FOREIGN KEY (album_id) REFERENCES album (album_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX group_album_album_album_id_fk
  ON group_album (album_id);

CREATE INDEX group_album_group_group_id_fk
  ON group_album (group_id);

CREATE TABLE group_member
(
  group_member_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  group_id        INT(11) UNSIGNED NOT NULL,
  member_id       INT(11) UNSIGNED NOT NULL,
  CONSTRAINT group_member_group_member_id_uindex
  UNIQUE (group_member_id),
  CONSTRAINT group_member_group_group_id_fk
  FOREIGN KEY (group_id) REFERENCES `group` (group_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT group_member_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX group_member_group_group_id_fk
  ON group_member (group_id);

CREATE INDEX group_member_member_member_id_fk
  ON group_member (member_id);

CREATE TABLE group_message
(
  group_message INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  group_id      INT(11) UNSIGNED NOT NULL,
  message_id    INT(11) UNSIGNED NOT NULL,
  CONSTRAINT group_message_group_message_uindex
  UNIQUE (group_message),
  CONSTRAINT group_message_group_group_id_fk
  FOREIGN KEY (group_id) REFERENCES `group` (group_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT group_message_message_message_id_fk
  FOREIGN KEY (message_id) REFERENCES message (message_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX group_message_group_group_id_fk
  ON group_message (group_id);

CREATE INDEX group_message_message_message_id_fk
  ON group_message (message_id);

CREATE TABLE image_message
(
  image_message_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  image_id         INT(11) UNSIGNED NOT NULL,
  message_id       INT(11) UNSIGNED NOT NULL,
  CONSTRAINT image_message_image_message_id_uindex
  UNIQUE (image_message_id),
  CONSTRAINT image_message_image_image_id_fk
  FOREIGN KEY (image_id) REFERENCES image (image_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT image_message_message_message_id_fk
  FOREIGN KEY (message_id) REFERENCES message (message_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX image_message_image_image_id_fk
  ON image_message (image_id);

CREATE INDEX image_message_message_message_id_fk
  ON image_message (message_id);

CREATE TABLE member_setting
(
  member_setting_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  member_id         INT(11) UNSIGNED                   NOT NULL,
  public_profile    TINYINT(1) DEFAULT '1'             NOT NULL,
  public_messages   TINYINT(1) DEFAULT '1'             NOT NULL,
  private_messages  TINYINT(1) DEFAULT '1'             NOT NULL,
  group_reqests     TINYINT(1) DEFAULT '1'             NOT NULL,
  friend_requests   TINYINT(1) DEFAULT '1'             NOT NULL,
  delete_member     TINYINT(1) DEFAULT '0'             NOT NULL,
  created_at        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT member_setting_member_setting_id_uindex
  UNIQUE (member_setting_id),
  CONSTRAINT member_setting_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX member_setting_member_member_id_fk
  ON member_setting (member_id);

CREATE TABLE message_like
(
  message_like_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  message_id      INT(11) UNSIGNED                   NOT NULL,
  member_id       INT(11) UNSIGNED                   NOT NULL,
  created_at      DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT message_like_message_like_id_uindex
  UNIQUE (message_like_id),
  CONSTRAINT message_like_message_message_id_fk
  FOREIGN KEY (message_id) REFERENCES message (message_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT message_like_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX message_like_member_member_id_fk
  ON message_like (member_id);

CREATE INDEX message_like_message_message_id_fk
  ON message_like (message_id);

CREATE TABLE message_share
(
  message_share_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  message_id       INT(11) UNSIGNED                   NOT NULL,
  member_id        INT(11) UNSIGNED                   NOT NULL,
  created_at       DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT message_share_message_share_id_uindex
  UNIQUE (message_share_id),
  CONSTRAINT message_share_message_message_id_fk
  FOREIGN KEY (message_id) REFERENCES message (message_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT message_share_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX message_share_member_member_id_fk
  ON message_share (member_id);

CREATE INDEX message_share_message_message_id_fk
  ON message_share (message_id);

CREATE TABLE relation
(
  relation_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  CONSTRAINT relation_relation_id_uindex
  UNIQUE (relation_id)
);

CREATE TABLE relation_member
(
  relation_member_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  relation_id        INT(11) UNSIGNED NOT NULL,
  member_id          INT(11) UNSIGNED NOT NULL,
  CONSTRAINT relation_member_relation_member_id_uindex
  UNIQUE (relation_member_id),
  CONSTRAINT relation_member_relation_relation_id_fk
  FOREIGN KEY (relation_id) REFERENCES relation (relation_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT relation_member_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX relation_member_member_member_id_fk
  ON relation_member (member_id);

CREATE INDEX relation_member_relation_relation_id_fk
  ON relation_member (relation_id);

CREATE TABLE remember_token
(
  remember_token_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  member_id         INT(11) UNSIGNED                   NOT NULL,
  token             VARCHAR(64)                        NOT NULL,
  created_at        DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  expired_at        DATETIME                           NOT NULL,
  CONSTRAINT remember_token_remember_token_id_uindex
  UNIQUE (remember_token_id),
  CONSTRAINT remember_token_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX remember_token_member_member_id_fk
  ON remember_token (member_id);

CREATE TABLE resset_password_token
(
  resset_password_token_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  member_id                INT(11) UNSIGNED                   NOT NULL,
  token                    VARCHAR(64)                        NOT NULL,
  created_at               DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  expired_at               DATETIME                           NOT NULL,
  CONSTRAINT resset_password_token_resset_password_token_id_uindex
  UNIQUE (resset_password_token_id),
  CONSTRAINT resset_password_token_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX resset_password_token_member_member_id_fk
  ON resset_password_token (member_id);

CREATE TABLE wall
(
  wall_id   INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  member_id INT(11) UNSIGNED NOT NULL,
  CONSTRAINT wall_wall_id_uindex
  UNIQUE (wall_id),
  CONSTRAINT wall_member_member_id_fk
  FOREIGN KEY (member_id) REFERENCES member (member_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX wall_member_member_id_fk
  ON wall (member_id);

CREATE TABLE wall_message
(
  wall_message_id INT(11) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  wall_id         INT(11) UNSIGNED NOT NULL,
  message_id      INT(11) UNSIGNED NOT NULL,
  CONSTRAINT wall_message_wall_message_id_uindex
  UNIQUE (wall_message_id),
  CONSTRAINT wall_message_wall_wall_id_fk
  FOREIGN KEY (wall_id) REFERENCES wall (wall_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT wall_message_message_message_id_fk
  FOREIGN KEY (message_id) REFERENCES message (message_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE INDEX wall_message_wall_wall_id_fk
  ON wall_message (wall_id);

CREATE INDEX wall_message_message_message_id_fk
  ON wall_message (message_id);



