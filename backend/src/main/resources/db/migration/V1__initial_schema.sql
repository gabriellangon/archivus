
-- Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "vector";

CREATE TABLE users (
                       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       username VARCHAR(100) UNIQUE NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password_hash TEXT NOT NULL,
                       created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE notes (
                       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                       title TEXT,
                       content TEXT,
                       note_type VARCHAR(10) NOT NULL CHECK (note_type IN ('text', 'url', 'image')),
                       processing_status VARCHAR(20) DEFAULT 'pending' CHECK (processing_status IN ('pending', 'processing', 'ready', 'failed'));
                       created_at TIMESTAMP DEFAULT NOW(),
                       updated_at TIMESTAMP DEFAULT NOW()

);

-- Pièces jointes (images S3)
CREATE TABLE image_assets (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              note_id UUID NOT NULL REFERENCES notes(id) ON DELETE CASCADE,
                              s3_url TEXT NOT NULL,
                              original_filename TEXT,
                              created_at TIMESTAMP DEFAULT NOW()
);

-- Métadonnées Rekognition (JSONB)
CREATE TABLE image_metadata (
                                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                image_id UUID NOT NULL REFERENCES image_assets(id) ON DELETE CASCADE,
                                labels JSONB,            -- exemple : ["chien", "plage"]
                                text_detected TEXT,      -- OCR si pertinent
                                created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE url_metadata (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              note_id UUID NOT NULL REFERENCES notes(id) ON DELETE CASCADE,
                              title VARCHAR(500),
                              description TEXT,
                              favicon_url TEXT,
                              preview_image_url TEXT,
                              site_name VARCHAR(255),
                              created_at TIMESTAMP DEFAULT NOW()
);

-- Embedding vectoriel (local + synchro OpenSearch)
CREATE TABLE semantic_index (
                                note_id UUID PRIMARY KEY REFERENCES notes(id) ON DELETE CASCADE,
                                embedding VECTOR(1536),
                                created_at TIMESTAMP DEFAULT NOW()
);


CREATE INDEX idx_notes_user ON notes(user_id);
CREATE INDEX idx_notes_type ON notes(note_type);
CREATE INDEX idx_notes_created_at ON notes(created_at DESC);

CREATE INDEX idx_image_assets_note_id ON image_assets(note_id);
CREATE INDEX idx_image_metadata_image_id ON image_metadata(image_id);

-- Fonction trigger générique
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_update_notes_updated
    BEFORE UPDATE ON notes
    FOR EACH ROW EXECUTE FUNCTION update_timestamp();
