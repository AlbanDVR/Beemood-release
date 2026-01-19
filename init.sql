CREATE DATABASE beemood;
\c beemood;

-- Enable pgcrypto extension for gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- 1. Création de la table MusicServices (référencée par Playlists)
CREATE TABLE IF NOT EXISTS MusicServices (
    Name VARCHAR(255) PRIMARY KEY
);

-- 2. Création de la table Users
CREATE TABLE IF NOT EXISTS Users (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    SpotifyUserID VARCHAR(255),
    SpotifyAccessToken VARCHAR,
    SpotifyRefreshToken VARCHAR,
    AuthToken VARCHAR,
    JoinTime DATE DEFAULT CURRENT_DATE
);

-- 3. Création de la table Playlists
CREATE TABLE IF NOT EXISTS Playlists (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    Author UUID,
    Title VARCHAR(255),
    Tracks VARCHAR[], 
    MusicService VARCHAR(255),
    
    CONSTRAINT fk_playlist_author
        FOREIGN KEY (Author) 
        REFERENCES Users(ID)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_playlist_service
        FOREIGN KEY (MusicService) 
        REFERENCES MusicServices(Name)
        ON DELETE SET NULL
);
