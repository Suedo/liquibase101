-- txn_master table
CREATE TABLE txn_master (
    txn_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    txn_type VARCHAR(50) NOT NULL,
    current_stage VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_txn_type (txn_type),
    INDEX idx_current_stage (current_stage)
) ENGINE=InnoDB;

-- txn_events table
CREATE TABLE txn_events (
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
    FOREIGN KEY (txn_id) REFERENCES txn_master(txn_id),
    INDEX idx_txn_id (txn_id),
    INDEX idx_event_type (event_type)
) ENGINE=InnoDB;

-- txn_revision table
CREATE TABLE txn_revision (
    revision_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    txn_id BIGINT NOT NULL,
    version INT NOT NULL,
    version_data JSON NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (txn_id) REFERENCES txn_master(txn_id),
    INDEX idx_txn_id (txn_id),
    INDEX idx_version (version)
) ENGINE=InnoDB;

-- static data
CREATE TABLE bank_ref_data (
    BankName VARCHAR(100),
    BICCode VARCHAR(11),
    MICRCode VARCHAR(9),
    Address VARCHAR(255)
);
