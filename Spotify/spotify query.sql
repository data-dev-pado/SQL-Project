use spotify_playlist;

-- What records are displayed in the first 10 entries?
SELECT * FROM spotify_tracks LIMIT 10;

-- 가장 인기 있는 트랙은 무엇인가요
-- Which tracks are considered the most popular?
SELECT track_name, artist_name, popularity
FROM spotify_tracks
ORDER BY popularity DESC
LIMIT 10;

-- 가장 인기 있는 아티스트는 누구인가요
-- Who are the artists that have gained the highest popularity?
SELECT artist_name, COUNT(*) AS track_count, AVG(popularity) AS avg_popularity
FROM spotify_tracks
GROUP BY artist_name
ORDER BY avg_popularity DESC, track_count DESC
LIMIT 10;

-- 장르별 평균 인기 점수는 몇점일까요
-- What is the average popularity score for each genre?
SELECT artist_genre, AVG(popularity) AS avg_popularity
FROM spotify_tracks
GROUP BY artist_genre
ORDER BY avg_popularity DESC;

-- 연도별 트랙 수는 어느정도 될까요
-- How many tracks exist for each year?
SELECT year, COUNT(*) AS track_count
FROM spotify_tracks
GROUP BY year
ORDER BY year;

-- 연도별 가장 인기 있는 트랙
-- Which track is the most popular in each year?
WITH ranked_tracks AS (
    SELECT year, track_name, artist_name,popularity,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY popularity DESC) AS track_rank
    FROM spotify_tracks
)
SELECT year, track_name, artist_name, popularity
FROM ranked_tracks
WHERE track_rank = 1
ORDER BY year DESC;

-- 가장 많은 트랙을 보유한 아티스트
-- Which artists have the most tracks recorded?
SELECT st.artist_name, COUNT(*) AS track_count
FROM spotify_tracks st
GROUP BY st.artist_name
ORDER BY track_count DESC
LIMIT 10;

-- popularity가 50 이상인 트랙들
-- Which tracks have an average popularity above 50?
SELECT artist_name, COUNT(*) AS track_count
FROM spotify_tracks
GROUP BY artist_name
HAVING AVG(popularity) > 50;

-- 장르별로 평균 템포
-- What is the average tempo for each genre?
SELECT artist_genre, AVG(tempo) AS avg_tempo
FROM spotify_tracks
GROUP BY artist_genre
ORDER BY avg_tempo DESC
LIMIT 5;

-- 연도별 가장 인기 있는 아티스트는 누구인가
-- Who are the most popular artists by year?
SELECT year, artist_name, MAX(popularity) AS max_popularity
FROM spotify_tracks
GROUP BY year, artist_name
ORDER BY year, max_popularity DESC;

-- 특정 tempo와 valence 조합이 텐션을 유발할 수 있는 곡 분포는 무엇인가
-- Which tracks might create tension with a specific combination of tempo and valence?
SELECT track_name, artist_name,tempo,valence
FROM spotify_tracks
WHERE tempo > 150 AND valence < 0.3
ORDER BY tempo DESC, valence ASC;

-- 다양한 장르, 높은 연도 범위, 그리고 변화폭이 큰 음악적 특성을 가진 아티스트는 누구인가?
-- Which artists exhibit a wide range of genres and significant changes in musical characteristics?
SELECT 
    artist_name,
    COUNT(DISTINCT artist_genre) AS genre_count,
    MIN(year) AS first_year,
    MAX(year) AS last_year,
    MAX(valence) - MIN(valence) AS valence_range,
    MAX(energy) - MIN(energy) AS energy_range
FROM spotify_tracks
GROUP BY artist_name
ORDER BY genre_count DESC, valence_range DESC, energy_range DESC
LIMIT 10;

-- Valence가 가장 큰 폭으로 변화한 연도별 분석
-- What is the yearly analysis of the largest change in valence?
SELECT year, MAX(valence) - MIN(valence) AS valence_range
FROM spotify_tracks
GROUP BY year
ORDER BY valence_range DESC
LIMIT 5;