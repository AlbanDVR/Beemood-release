CREATE DATABASE beemood;
\c beemood;

-- Enable pgcrypto extension for gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- 1. Création de la table MusicServices (référencée par Playlists)
CREATE TABLE IF NOT EXISTS MusicServices (
    Name VARCHAR(255) PRIMARY KEY
);

-- 2. Création de la table Users
CREATE TABLE IF NOT EXISTS users (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    SpotifyUserID VARCHAR(255),
    SpotifyAccessToken VARCHAR,
    SpotifyRefreshToken VARCHAR,
    SpotifyExpiresIn INTEGER,
    SpotifyTimeTokenCreated FLOAT,
    AuthToken VARCHAR,
    JoinTime DATE DEFAULT CURRENT_DATE
);

-- 3. Création de la table Playlists
CREATE TABLE IF NOT EXISTS Playlists (
    ID VARCHAR(255) PRIMARY KEY,
    Author UUID,
    Title VARCHAR(255),
    Descr VARCHAR(255),
    Duration INTEGER, 
    TrackNb INTEGER,
    MusicService VARCHAR(255),
    RedirectionService VARCHAR(255),
    
    CONSTRAINT fk_playlist_author
        FOREIGN KEY (Author) 
        REFERENCES users(ID)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_playlist_service
        FOREIGN KEY (MusicService) 
        REFERENCES MusicServices(Name)
        ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Playlist_Likes (
    Playlist_ID VARCHAR(255),
    User_ID UUID,
    
    PRIMARY KEY (Playlist_ID, User_ID),
    
    CONSTRAINT fk_playlist_like_playlist
        FOREIGN KEY (Playlist_ID)
        REFERENCES Playlists(ID)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_playlist_like_user
        FOREIGN KEY (User_ID)
        REFERENCES users(ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Stat(
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UserID UUID,
    TrackNumber INTEGER,
    ListeningTime INTEGER,
    ConnectionNumber INTEGER,
    PlaylistNumber INTEGER,
    FavoriteGenre VARCHAR(255),

    CONSTRAINT fk_playlist_creation_author
        FOREIGN KEY (UserID)
        REFERENCES  users(ID)
        ON DELETE CASCADE
)
