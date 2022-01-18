create keyspace cryptocurrency with replication = {'class' : 'NetworkTopologyStrategy', 'DC1':2, 'DC2':2};

CREATE TABLE cryptocurrency.coin_by_marketdominance (
    name text,
    datetime timestamp,
    rank int,
    market_dominance double,
    PRIMARY KEY ((rank), datetime)) WITH CLUSTERING ORDER BY (datetime desc);

--INSERT INTO cryptocurrency.coin_by_marketdominance (name, datetime, inserted_in_db, rank, market_dominance) VALUES ('Bitcoin', 1641662870916, toTimestamp(now()), 1, 50.0);

--INSERT INTO NerdMovies JSON '{"movie": "Serenity", "director": "Joss Whedon", "year": 2005}';

CREATE TABLE cryptocurrency.exchanges_by_volume (
    name text,
    day date,
    volumeusd double,
    tradingPairs int,
    PRIMARY KEY ((day), volumeusd, name));

--INSERT INTO cryptocurrency.exchanges_by_volume (name, datetime, market_dominance) VALUES ('Bitcoin', 1, toTimestamp(now()), 50.0);
-- Turn price_usd to price_euro via /rates/euro
CREATE TABLE cryptocurrency.assets_raw_data (
    name text,
    rank int,
    symbol TEXT,
    supply DOUBLE,
    max_supply DOUBLE,
    market_cap_usd DOUBLE,
    volume_usd_24Hr DOUBLE,
    price_usd DOUBLE,
    changePercent24Hr DOUBLE, 
    datetime TIMESTAMP,
    inserted_in_db TIMESTAMP,
    PRIMARY KEY ((name), datetime));

CREATE TABLE cryptocurrency.biggest_gainers_by_day (
  name TEXT,
  day date,
  price_usd double,
  changePercent24Hr double,
  PRIMARY KEY ((day), changePercent24Hr, name)
);

CREATE TABLE cryptocurrency.biggest_losers_by_day (
  name TEXT,
  day date,
  priceUsd double,
  changePercent24Hr double,
  PRIMARY KEY ((day), changePercent24Hr, name)
);

-- WITH property
--     rank text PRIMARY KEY,
--     name text,
--     market_cap text,
--     price text,
--     circulating_supply text,
--     max_supply text,
--     high text,
--     price_timestamp text,
--     price_change_1d text,
--     volume_1d text,
--     volume_change_1d text,
--     market_cap_change_1d text,
--     price_change_7d text,
--     volume_7d text,
--     volume_change_7d text,
--     market_cap_change_7d text,
--     price_change_30d text,
--     volume_30d text,
--     volume_change_30d text,
--     market_cap_change_30d text

CREATE TABLE cryptocurrency.candles (
  exchange text,
  base text,
  quote text,
  datetime TIMESTAMP,
  open double,
  high double,
  low double,
  close double,
  PRIMARY KEY ((exchange, base, quote), datetime)
);

CREATE TABLE cryptocurrency.candles_rsi (
    datetime timestamp,
    rsi double,
    PRIMARY KEY (datetime)
);

