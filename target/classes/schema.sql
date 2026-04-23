-- =============================================================
-- MindHub — Database Schema
-- SECJ3303 Internet Programming
-- =============================================================
-- Run this script to create all tables.
-- Each team member runs this on their LOCAL MySQL instance.
-- The schema.sql is version-controlled in Git so everyone
-- stays in sync.
-- =============================================================

CREATE DATABASE IF NOT EXISTS mindhub_db
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE mindhub_db;

-- =============================================================
-- 1. USERS — Authentication & profiles
-- =============================================================
CREATE TABLE IF NOT EXISTS users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100)  NOT NULL,
    email       VARCHAR(150)  NOT NULL UNIQUE,
    password    VARCHAR(255)  NOT NULL,
    role        ENUM('STUDENT','ADMIN') NOT NULL DEFAULT 'STUDENT',
    avatar_url  VARCHAR(500)  DEFAULT NULL,
    created_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 2. USER_PROGRESS — Gamification streaks & points
-- =============================================================
CREATE TABLE IF NOT EXISTS user_progress (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL UNIQUE,
    streak_days     INT DEFAULT 0,
    total_points    INT DEFAULT 0,
    level           INT DEFAULT 1,
    last_check_in   DATE DEFAULT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 3. BADGES — Badge definitions
-- =============================================================
CREATE TABLE IF NOT EXISTS badges (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)  NOT NULL,
    description VARCHAR(500)  NOT NULL,
    icon_url    VARCHAR(500)  DEFAULT NULL,
    criteria    VARCHAR(255)  DEFAULT NULL,
    points      INT           DEFAULT 0,
    created_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 4. USER_BADGES — Many-to-many: users <-> badges
-- =============================================================
CREATE TABLE IF NOT EXISTS user_badges (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    user_id   INT NOT NULL,
    badge_id  INT NOT NULL,
    earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE,
    FOREIGN KEY (badge_id) REFERENCES badges(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_badge (user_id, badge_id)
) ENGINE=InnoDB;

-- =============================================================
-- 5. CONTENT — Educational articles & videos
-- =============================================================
CREATE TABLE IF NOT EXISTS content (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    title          VARCHAR(255)  NOT NULL,
    description    TEXT,
    content_type   ENUM('VIDEO','ARTICLE','EXERCISE') NOT NULL DEFAULT 'ARTICLE',
    category       VARCHAR(100)  DEFAULT NULL,
    url            VARCHAR(500)  DEFAULT NULL,
    thumbnail_url  VARCHAR(500)  DEFAULT NULL,
    duration       VARCHAR(50)   DEFAULT NULL,
    author_id      INT           DEFAULT NULL,
    created_at     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- =============================================================
-- 6. ASSESSMENTS — Quiz / self-assessment definitions
-- =============================================================
CREATE TABLE IF NOT EXISTS assessments (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(255)  NOT NULL,
    description     TEXT,
    category        VARCHAR(100)  DEFAULT NULL,
    total_questions INT           DEFAULT 0,
    created_at      TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 7. ASSESSMENT_QUESTIONS — Individual quiz questions
-- =============================================================
CREATE TABLE IF NOT EXISTS assessment_questions (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    assessment_id  INT NOT NULL,
    question_text  TEXT NOT NULL,
    option_a       VARCHAR(500) NOT NULL,
    option_b       VARCHAR(500) NOT NULL,
    option_c       VARCHAR(500) DEFAULT NULL,
    option_d       VARCHAR(500) DEFAULT NULL,
    correct_answer CHAR(1)      NOT NULL COMMENT 'A, B, C, or D',
    points         INT          DEFAULT 1,
    FOREIGN KEY (assessment_id) REFERENCES assessments(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 8. ASSESSMENT_RESULTS — User quiz scores
-- =============================================================
CREATE TABLE IF NOT EXISTS assessment_results (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT NOT NULL,
    assessment_id  INT NOT NULL,
    score          INT NOT NULL DEFAULT 0,
    total_points   INT NOT NULL DEFAULT 0,
    completed_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)       REFERENCES users(id)       ON DELETE CASCADE,
    FOREIGN KEY (assessment_id) REFERENCES assessments(id)  ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 9. MOOD_ENTRIES — Daily mood check-in & journal
-- =============================================================
CREATE TABLE IF NOT EXISTS mood_entries (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    mood_score   INT NOT NULL COMMENT '1=Very Low, 2=Low, 3=Neutral, 4=Good, 5=Great',
    mood_label   VARCHAR(50)  DEFAULT NULL,
    journal_text TEXT         DEFAULT NULL,
    entry_date   DATE         NOT NULL,
    created_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 10. FORUM_POSTS — Peer support threads
-- =============================================================
CREATE TABLE IF NOT EXISTS forum_posts (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT NOT NULL,
    title         VARCHAR(255) NOT NULL,
    content       TEXT         NOT NULL,
    category      VARCHAR(100) DEFAULT 'General',
    is_anonymous  TINYINT(1)   DEFAULT 1,
    is_flagged    TINYINT(1)   DEFAULT 0,
    report_count  INT          DEFAULT 0,
    created_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 11. FORUM_REPLIES — Replies to forum threads
-- =============================================================
CREATE TABLE IF NOT EXISTS forum_replies (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    post_id      INT NOT NULL,
    user_id      INT NOT NULL,
    content      TEXT NOT NULL,
    is_anonymous TINYINT(1) DEFAULT 1,
    created_at   TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES forum_posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)       ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 12. PROFESSIONALS — Counselor / therapist directory
-- =============================================================
CREATE TABLE IF NOT EXISTS professionals (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(150) NOT NULL,
    title           VARCHAR(100) DEFAULT NULL,
    specialization  VARCHAR(200) DEFAULT NULL,
    bio             TEXT         DEFAULT NULL,
    photo_url       VARCHAR(500) DEFAULT NULL,
    email           VARCHAR(150) DEFAULT NULL,
    phone           VARCHAR(50)  DEFAULT NULL,
    available_days  VARCHAR(100) DEFAULT NULL COMMENT 'e.g. MON,TUE,WED',
    created_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 13. APPOINTMENTS — Booking slots
-- =============================================================
CREATE TABLE IF NOT EXISTS appointments (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT NOT NULL,
    professional_id  INT NOT NULL,
    appointment_date DATE NOT NULL,
    time_slot        VARCHAR(50) NOT NULL COMMENT 'e.g. 09:00-10:00',
    status           ENUM('PENDING','CONFIRMED','CANCELLED','COMPLETED') DEFAULT 'PENDING',
    notes            TEXT DEFAULT NULL,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)         REFERENCES users(id)         ON DELETE CASCADE,
    FOREIGN KEY (professional_id) REFERENCES professionals(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- INDEXES for performance
-- =============================================================
CREATE INDEX idx_mood_user_date   ON mood_entries(user_id, entry_date);
CREATE INDEX idx_forum_flagged    ON forum_posts(is_flagged);
CREATE INDEX idx_appointments_dt  ON appointments(appointment_date);
CREATE INDEX idx_content_category ON content(category);
CREATE INDEX idx_results_user     ON assessment_results(user_id);
