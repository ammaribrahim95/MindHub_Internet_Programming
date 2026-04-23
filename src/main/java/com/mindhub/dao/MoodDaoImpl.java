package com.mindhub.dao;

import com.mindhub.model.MoodEntry;
import com.mindhub.model.ReportData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MoodDaoImpl implements MoodDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<MoodEntry> rowMapper = (rs, rowNum) -> {
        MoodEntry m = new MoodEntry();
        m.setId(rs.getInt("id"));
        m.setUserId(rs.getInt("user_id"));
        m.setMoodScore(rs.getInt("mood_score"));
        m.setMoodLabel(rs.getString("mood_label"));
        m.setJournalText(rs.getString("journal_text"));
        m.setEntryDate(rs.getDate("entry_date"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        return m;
    };

    @Override
    public void save(MoodEntry entry) {
        jdbcTemplate.update(
                "INSERT INTO mood_entries (user_id, mood_score, mood_label, journal_text, entry_date) VALUES (?,?,?,?,?)",
                entry.getUserId(), entry.getMoodScore(), entry.getMoodLabel(),
                entry.getJournalText(), entry.getEntryDate());
    }

    @Override
    public List<MoodEntry> findByUserId(int userId) {
        return jdbcTemplate.query("SELECT * FROM mood_entries WHERE user_id = ? ORDER BY entry_date DESC", rowMapper, userId);
    }

    @Override
    public List<MoodEntry> findRecentByUserId(int userId, int limit) {
        return jdbcTemplate.query("SELECT * FROM mood_entries WHERE user_id = ? ORDER BY entry_date DESC LIMIT ?",
                rowMapper, userId, limit);
    }

    @Override
    public MoodEntry findTodayByUserId(int userId) {
        List<MoodEntry> results = jdbcTemplate.query(
                "SELECT * FROM mood_entries WHERE user_id = ? AND entry_date = CURDATE()", rowMapper, userId);
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<ReportData> getWeeklyMoodByUserId(int userId) {
        String sql = "SELECT DAYNAME(entry_date) AS label, mood_score AS count FROM mood_entries " +
                "WHERE user_id = ? AND entry_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) ORDER BY entry_date";
        return jdbcTemplate.query(sql, (rs, rowNum) -> new ReportData(rs.getString("label"), rs.getInt("count")), userId);
    }

    @Override
    public double getAverageMoodByUserId(int userId) {
        Double avg = jdbcTemplate.queryForObject(
                "SELECT AVG(mood_score) FROM mood_entries WHERE user_id = ?", Double.class, userId);
        return avg != null ? avg : 0.0;
    }

    @Override
    public List<ReportData> getMoodTrendsAll() {
        String sql = "SELECT DATE_FORMAT(entry_date, '%Y-%m-%d') AS label, ROUND(AVG(mood_score),1) AS count " +
                "FROM mood_entries GROUP BY entry_date ORDER BY entry_date DESC LIMIT 30";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            ReportData rd = new ReportData();
            rd.setLabel(rs.getString("label"));
            rd.setValue(rs.getDouble("count"));
            return rd;
        });
    }

    @Override
    public int countAll() {
        Integer c = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM mood_entries", Integer.class);
        return c != null ? c : 0;
    }
}

