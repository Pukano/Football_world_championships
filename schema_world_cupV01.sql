-- Suppression de la DB si elle existe (en cas de rechargement).
DROP SCHEMA IF EXISTS world_cups;
-- Création de la DB avec son encoding.
CREATE SCHEMA world_cups CHARACTER SET utf8mb4;  -- Choix de 'utf8mb4' car 'utf8' est un alias pour 'utf8mb3' qui                                              
USE world_cups;

DROP TABLE IF EXISTS wc;
CREATE TABLE wc(
    wc_years YEAR NOT NULL,
    country VARCHAR(50) NOT NULL,
    winner VARCHAR(50) NOT NULL,
    runners_up VARCHAR(50) NOT NULL,
    third VARCHAR(50) NOT NULL,
    fourth VARCHAR(50) NOT NULL,
    goals_scored TINYINT UNSIGNED NOT NULL,
    qualified_teams SMALLINT UNSIGNED NOT NULL,
    matches_played SMALLINT UNSIGNED NOT NULL,
    attendance INT UNSIGNED NOT NULL

    ) ENGINE=InnoDB;

DROP TABLE IF EXISTS teams;
CREATE TABLE teams(
  #id_team PRIMARY KEY,
  team_initials CHAR(3) ,
  team_name VARCHAR(50) NOT NULL
  #coach_name VARCHAR(100) NOT NULL
  ) ENGINE=InnoDB;

DROP TABLE IF EXISTS matches;
CREATE TABLE matches(
    years YEAR NOT NULL,
    date_time VARCHAR(40) NOT NULL,
    stage VARCHAR(40) NOT NULL,
    stadium VARCHAR(50) NOT NULL,
    city VARCHAR(40) NOT NULL,
    home_team_name VARCHAR(50) NOT NULL,
    home_team_goals TINYINT UNSIGNED DEFAULT NULL,
    away_team_goals TINYINT UNSIGNED DEFAULT NULL,
    away_team_name VARCHAR(50) NOT NULL,
    win_conditions VARCHAR(250) DEFAULT NULL,
    attendance_match INT UNSIGNED DEFAULT NULL,
    half_time_home_goals TINYINT UNSIGNED DEFAULT NULL,
    half_time_away_goals TINYINT UNSIGNED DEFAULT NULL,
    referee VARCHAR(50),
    assistant1 VARCHAR(50)
    ,
    assistant2 VARCHAR(50),
    round_id INT UNSIGNED NOT NULL,
    match_id INT UNSIGNED NOT NULL,
    home_team_initials CHAR(3) NOT NULL,
    away_team_initials CHAR(3) NOT NULL

 )ENGINE=InnoDB;

DROP TABLE IF EXISTS players;
CREATE TABLE players(
   
    player_name VARCHAR(50),
    team_initials CHAR(3) NOT NULL
    #goals tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
    #yellow_cards tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
    #red_cards tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
    )ENGINE=InnoDB; 

DROP TABLE IF EXISTS players_matches;
CREATE TABLE players_matches(
    player_name VARCHAR(50) NOT NULL,
    team_initials CHAR(3) NOT NULL,
    match_id INT UNSIGNED NOT NULL,
    line_up CHAR(1) DEFAULT NULL,
    event VARCHAR(40) DEFAULT NULL,
    position VARCHAR(40) DEFAULT NULL,
    shirt_number VARCHAR(3) DEFAULT NULL
    )ENGINE=InnoDB;
SHOW WARNINGS ;


ALTER TABLE  wc ADD CONSTRAINT PK_wc PRIMARY KEY (wc_years);

ALTER TABLE teams ADD CONSTRAINT  PK_teams PRIMARY KEY(team_initials);

ALTER TABLE matches ADD CONSTRAINT PK_matches PRIMARY KEY(match_id);

ALTER TABLE players 
  ADD CONSTRAINT PK_player PRIMARY KEY (player_name, team_initials);
  

ALTER TABLE players_matches ADD CONSTRAINT PK_pla_ma PRIMARY KEY(player_name, match_id),
ADD KEY fk_players_matches_player_name (team_initials,player_name);
-- FOREIGN KEY

ALTER TABLE players
  ADD CONSTRAINT fk_players_teams FOREIGN KEY (team_initials) REFERENCES teams(team_initials);

ALTER TABLE matches
  ADD CONSTRAINT fk_matches_wc FOREIGN KEY (years)REFERENCES wc(wc_years),
  ADD CONSTRAINT fk_matches_teams FOREIGN KEY (home_team_initials) REFERENCES teams(team_initials),
  ADD CONSTRAINT fk_matches_team FOREIGN KEY (away_team_initials) REFERENCES teams(team_initials);

ALTER TABLE players_matches
  ADD CONSTRAINT fk_plMatch_matches FOREIGN KEY (match_id) REFERENCES matches(match_id),
  ADD CONSTRAINT fk_plMatch_players FOREIGN KEY (player_name) REFERENCES players(player_name);
-- FIN DE FICHIER SCHEMA
