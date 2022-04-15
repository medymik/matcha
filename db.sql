DROP TABLE relationships;
DROP TABLE positions;
DROP TABLE messages;
DROP TABLE users;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TYPE IF EXISTS relation_type;
CREATE TYPE relation_type AS ENUM ('pending', 'accepted', 'blocked');
DROP TYPE IF EXISTS gender;
CREATE TYPE gender AS ENUM ('male', 'female');

CREATE TABLE IF NOT EXISTS users (
    id uuid default uuid_generate_v4(),
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    username VARCHAR NOT NULL,
    password VARCHAR NOT NULL,
    PRIMARY KEY (id),
    created_at TIMESTAMP DEFAULT NOW(),
    sexe gender DEFAULT 'male'
);

CREATE TABLE relationships (
    from_id uuid,
    to_id uuid,
    PRIMARY KEY (
        from_id,
        to_id
    ),
    CONSTRAINT fk_from_id
        FOREIGN KEY (from_id)
            REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_to_id
        FOREIGN KEY (to_id)
            REFERENCES users(id) ON DELETE CASCADE,
    status relation_type DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE positions (
    id uuid DEFAULT uuid_generate_v4(),
    coordinates point NOT NULL,
    user_id uuid,
    PRIMARY KEY (id),
    CONSTRAINT fk_user_geography
        FOREIGN KEY (user_id)
            REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE messages (
    from_id uuid,
    to_id uuid,
    PRIMARY KEY (
        from_id,
        to_id
    ),
    CONSTRAINT fk_message_from_id
        FOREIGN KEY (from_id)
            REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_message_to_id
        FOREIGN KEY (to_id)
            REFERENCES users(id) ON DELETE CASCADE,
    body VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TODO work on indexes, add other fields to users