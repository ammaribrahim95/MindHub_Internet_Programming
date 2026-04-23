-- =============================================================
-- MindHub — Seed Data
-- =============================================================
-- Run this AFTER schema.sql to populate sample data.
-- Every team member runs this to get the same starting dataset.
-- =============================================================

USE mindhub_db;

-- ----- USERS -----
INSERT INTO users (full_name, email, password, role) VALUES
('Ammar Ibrahim',   'ammar@student.utm.my',   'password123', 'STUDENT'),
('Sarah Ahmad',     'sarah@student.utm.my',   'password123', 'STUDENT'),
('Ali Hassan',      'ali@student.utm.my',     'password123', 'STUDENT'),
('Nurul Aisyah',    'nurul@student.utm.my',   'password123', 'STUDENT'),
('Admin User',      'admin@utm.my',           'admin123',    'ADMIN');

-- ----- USER PROGRESS -----
INSERT INTO user_progress (user_id, streak_days, total_points, level, last_check_in) VALUES
(1, 12, 850,  3, CURDATE()),
(2, 5,  420,  2, CURDATE()),
(3, 3,  210,  1, DATE_SUB(CURDATE(), INTERVAL 1 DAY)),
(4, 8,  630,  2, CURDATE());

-- ----- BADGES -----
INSERT INTO badges (name, description, icon_url, criteria, points) VALUES
('First Step',       'Complete your first mood check-in',          NULL, 'first_checkin',     10),
('7-Day Streak',     'Check in for 7 consecutive days',           NULL, 'streak_7',          50),
('14-Day Streak',    'Check in for 14 consecutive days',          NULL, 'streak_14',        100),
('Quiz Master',      'Complete 5 self-assessments',               NULL, 'assessments_5',     75),
('Community Helper', 'Reply to 10 forum posts',                   NULL, 'replies_10',        60),
('Wellness Warrior', 'Reach Level 3',                             NULL, 'level_3',          120),
('Bookworm',         'Read 10 articles from the content library', NULL, 'content_read_10',   40),
('Early Bird',       'Check in before 8 AM for 5 days',           NULL, 'early_checkin_5',   80);

-- ----- USER BADGES -----
INSERT INTO user_badges (user_id, badge_id) VALUES
(1, 1), (1, 2), (1, 6),
(2, 1), (2, 2),
(3, 1),
(4, 1), (4, 2), (4, 4);

-- ----- CONTENT -----
INSERT INTO content (title, description, content_type, category, url, thumbnail_url, duration, author_id) VALUES
('Guided Meditation for Exam Stress',     'A 10-minute guided meditation session designed for students facing exam anxiety.', 'VIDEO',    'Stress Management', 'https://example.com/meditation', NULL, '10 min', 5),
('Box Breathing Technique',               'Learn the 4-4-4-4 box breathing technique to calm your nervous system.',           'EXERCISE', 'Breathing',         'https://example.com/breathing',  NULL, '4 min',  5),
('Understanding Anxiety in Students',     'An in-depth article about common anxiety patterns in university students.',        'ARTICLE',  'Mental Health',     'https://example.com/anxiety',    NULL, '8 min',  5),
('Sleep Hygiene Tips for Better Rest',    'Practical tips to improve sleep quality during the semester.',                      'ARTICLE',  'Sleep',             'https://example.com/sleep',      NULL, '6 min',  5),
('Progressive Muscle Relaxation',         'Step-by-step guide to release physical tension through muscle relaxation.',         'VIDEO',    'Relaxation',        'https://example.com/pmr',        NULL, '15 min', 5),
('The 20-20-20 Rule for Digital Wellness','Reduce digital eye strain with this simple technique during study sessions.',       'ARTICLE',  'Digital Wellness',  'https://example.com/2020',       NULL, '3 min',  5),
('Mindful Study Techniques',             'Incorporate mindfulness into your study routine for better focus.',                   'VIDEO',    'Mindfulness',       'https://example.com/mindful',    NULL, '12 min', 5),
('Building Resilience Through Journaling','How journaling can help build emotional resilience during tough times.',             'ARTICLE',  'Journaling',        'https://example.com/journal',    NULL, '7 min',  5);

-- ----- ASSESSMENTS -----
INSERT INTO assessments (title, description, category, total_questions) VALUES
('PHQ-9 Depression Screening',   'A standardized screening tool for depression severity.',          'Depression',   9),
('GAD-7 Anxiety Assessment',     'Measures generalized anxiety disorder symptoms.',                 'Anxiety',      7),
('Stress Level Check',           'Quick assessment of your current stress levels.',                 'Stress',       5),
('Sleep Quality Index',          'Evaluate your sleep patterns and quality.',                       'Sleep',        6),
('Burnout Risk Assessment',      'Check if you are showing signs of academic burnout.',             'Burnout',      8);

-- ----- ASSESSMENT QUESTIONS (sample for Stress Level Check, id=3) -----
INSERT INTO assessment_questions (assessment_id, question_text, option_a, option_b, option_c, option_d, correct_answer, points) VALUES
(3, 'How often do you feel overwhelmed by your workload?',           'Never',    'Rarely',     'Sometimes', 'Always',  'A', 1),
(3, 'Do you have trouble sleeping due to stress?',                   'Never',    'Occasionally','Often',    'Always',  'A', 1),
(3, 'How would you rate your current stress level?',                 'Very Low', 'Low',        'Moderate',  'High',    'A', 1),
(3, 'Do you experience physical symptoms from stress?',             'Never',    'Rarely',     'Sometimes', 'Often',   'A', 1),
(3, 'Are you able to manage your time effectively?',                'Always',   'Usually',    'Sometimes', 'Never',   'A', 1);

-- ----- MOOD ENTRIES -----
INSERT INTO mood_entries (user_id, mood_score, mood_label, journal_text, entry_date) VALUES
(1, 4, 'Good',     'Had a productive study session today.',                     DATE_SUB(CURDATE(), INTERVAL 6 DAY)),
(1, 3, 'Neutral',  'Feeling a bit tired but okay.',                            DATE_SUB(CURDATE(), INTERVAL 5 DAY)),
(1, 5, 'Great',    'Aced my quiz today! Feeling confident.',                   DATE_SUB(CURDATE(), INTERVAL 4 DAY)),
(1, 2, 'Low',      'Stressed about upcoming deadlines.',                       DATE_SUB(CURDATE(), INTERVAL 3 DAY)),
(1, 4, 'Good',     'Used breathing exercises, feeling much better.',           DATE_SUB(CURDATE(), INTERVAL 2 DAY)),
(1, 4, 'Good',     'Good workout in the morning, positive vibes.',             DATE_SUB(CURDATE(), INTERVAL 1 DAY)),
(1, 5, 'Great',    'Feeling energized and ready for the week!',                CURDATE()),
(2, 3, 'Neutral',  'Regular day, nothing special.',                            DATE_SUB(CURDATE(), INTERVAL 2 DAY)),
(2, 4, 'Good',     'Had a nice chat with friends.',                            DATE_SUB(CURDATE(), INTERVAL 1 DAY)),
(2, 3, 'Neutral',  NULL,                                                       CURDATE());

-- ----- FORUM POSTS -----
INSERT INTO forum_posts (user_id, title, content, category, is_anonymous) VALUES
(1, 'Tips for managing exam anxiety?',        'I have finals coming up and feeling really anxious. Any tips from fellow students?',   'Anxiety',        1),
(2, 'Best study spots on campus',             'Looking for quiet and peaceful places to study. Any recommendations?',                 'General',        0),
(3, 'How do you deal with procrastination?',  'I keep putting off my assignments. What strategies work for you?',                     'Productivity',   1),
(4, 'Sleep schedule tips needed',             'My sleep schedule is a mess. How do you maintain a healthy sleep routine?',             'Sleep',          1),
(1, 'Meditation really helps!',               'I started meditating 10 minutes daily and it made a huge difference. Try it!',         'Wellness',       0);

-- ----- FORUM REPLIES -----
INSERT INTO forum_replies (post_id, user_id, content, is_anonymous) VALUES
(1, 2, 'Try the Pomodoro technique! 25 min study, 5 min break. It helps me a lot.',                    1),
(1, 4, 'Deep breathing before exams works wonders. Also, get enough sleep!',                           1),
(1, 3, 'I use flashcards and study groups. Being prepared reduces anxiety.',                            0),
(2, 1, 'The library 3rd floor is super quiet, especially in the morning.',                             0),
(3, 4, 'Break tasks into small chunks. Start with the easiest one to build momentum.',                 1),
(3, 2, 'I use a planner app and set reminders. Accountability buddies help too!',                      1),
(4, 1, 'No screens 1 hour before bed. It changed my sleep quality drastically.',                       1);

-- ----- PROFESSIONALS -----
INSERT INTO professionals (name, title, specialization, bio, photo_url, email, phone, available_days) VALUES
('Dr. Sarah Chen',       'Clinical Psychologist',   'Anxiety & Depression',      'Dr. Chen has 15 years of experience in university mental health services.',  NULL, 'sarah.chen@utm.my',    '+60-12-345-6789', 'MON,WED,FRI'),
('Dr. Ahmad Razak',      'Counseling Psychologist', 'Academic Stress',           'Specializes in helping students cope with academic pressure and burnout.',    NULL, 'ahmad.razak@utm.my',   '+60-12-987-6543', 'TUE,THU'),
('Ms. Priya Devi',       'Licensed Counselor',      'Relationships & Identity',  'Focuses on interpersonal relationships and personal identity exploration.',   NULL, 'priya.devi@utm.my',    '+60-11-222-3333', 'MON,TUE,WED,THU'),
('Dr. James Wong',       'Psychiatrist',            'Sleep Disorders',           'Board-certified psychiatrist with expertise in sleep-related issues.',         NULL, 'james.wong@utm.my',    '+60-13-444-5555', 'WED,FRI'),
('Ms. Fatimah Zahra',    'Student Wellness Coach',  'Holistic Wellness',         'Certified wellness coach focusing on mindfulness and lifestyle balance.',      NULL, 'fatimah.zahra@utm.my', '+60-14-666-7777', 'MON,TUE,WED,THU,FRI');

-- ----- APPOINTMENTS -----
INSERT INTO appointments (user_id, professional_id, appointment_date, time_slot, status, notes) VALUES
(1, 1, DATE_ADD(CURDATE(), INTERVAL 3 DAY),  '10:00-11:00', 'CONFIRMED',  'Follow-up session on anxiety management'),
(2, 3, DATE_ADD(CURDATE(), INTERVAL 5 DAY),  '14:00-15:00', 'PENDING',    'First session — relationship concerns'),
(1, 5, DATE_ADD(CURDATE(), INTERVAL 7 DAY),  '09:00-10:00', 'PENDING',    'Wellness coaching consultation'),
(3, 2, DATE_ADD(CURDATE(), INTERVAL 2 DAY),  '11:00-12:00', 'CONFIRMED',  'Academic stress discussion');
