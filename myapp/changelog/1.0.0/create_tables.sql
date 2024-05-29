-- Contains unique transactions with key information
CREATE TABLE tx_master (
    txn_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    txn_type VARCHAR(50) NOT NULL,
    current_stage VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_txn_type (txn_type),
    INDEX idx_current_stage (current_stage)
) ENGINE=InnoDB;

-- Captures all events related to each transaction.
CREATE TABLE tx_events (
    event_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    txn_id BIGINT NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    source_system VARCHAR(50) NOT NULL,
    destination_system VARCHAR(50) NOT NULL,
    flow_direction ENUM('inbound', 'outbound') NOT NULL,
    event_data JSON NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (txn_id) REFERENCES tx_master(txn_id),
    INDEX idx_txn_id (txn_id),  -- Index for quick lookup of events by txn_id
    INDEX idx_event_type (event_type)
) ENGINE=InnoDB;

-- Stores different versions of the incoming transaction payload as it gets processed.
CREATE TABLE payload_revision (
    revision_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    txn_id BIGINT NOT NULL,
    version INT NOT NULL,
    version_data JSON NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (txn_id) REFERENCES tx_master(txn_id),
    INDEX idx_txn_id (txn_id),  -- Index for quick lookup of revisions by txn_id
    INDEX idx_version (version)
) ENGINE=InnoDB;

-- Client static data
CREATE TABLE bank_ref_data (
    BankName VARCHAR(100),
    BICCode VARCHAR(11),
    MICRCode VARCHAR(9),
    Address VARCHAR(255)
) ENGINE=InnoDB;

-- Stores information for replaying transactions from the last recorded good event.
CREATE TABLE msg_replay (
    replay_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    txn_id BIGINT NOT NULL,
    last_good_event_id BIGINT NOT NULL,
    replay_status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (txn_id) REFERENCES tx_master(txn_id),
    FOREIGN KEY (last_good_event_id) REFERENCES tx_events(event_id),
    INDEX idx_txn_id (txn_id),  -- Index for quick lookup of replays by txn_id
    INDEX idx_last_good_event_id (last_good_event_id)
) ENGINE=InnoDB;
