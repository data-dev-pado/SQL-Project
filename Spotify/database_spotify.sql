-- 데이터베이스 생성
CREATE DATABASE spotify_playlist;
USE spotify_playlist;

-- 테이블 생성 (CSV 파일의 컬럼에 맞게 조정)
CREATE TABLE spotify_tracks (
    track_name VARCHAR(255),
    artist_name VARCHAR(255),
    artist_genre VARCHAR(255),
    year INT,
    popularity INT,
    duration_ms INT,
    explicit BOOLEAN,
    danceability FLOAT,
    energy FLOAT,
    key_mode INT,
    loudness FLOAT,
    mode INT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT
);